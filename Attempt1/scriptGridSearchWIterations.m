%% Script to search through epsilon, eta, values for optimal parameters
clear all;
close all;
clc;

%% Initialize variables
samples = 10;
epochs = 500;
testSamples = 200;
eta = 0.5;%linspace(0.001,1,samples);
epsilon = 0.006;%linspace(0.001,0.01,samples);
% q = linspace(1e-6,0.1,samples);
% HN = round(linspace(5,1000,samples));
q = 0.001;
HN = 10;%10:10:100;
annealingFlag = true;
perfPlotFlag = false;
iterations = 100;

saveFolder = 'C:\Users\Phil\Documents\School\Masters\ECE 739 - Neural Networks\Project\EKF MLP';

%% Perform the search
% Allocate memory
perf = zeros(length(HN),length(eta),length(epsilon),iterations,epochs);
finalAvgPerf = zeros(length(HN),length(eta),length(epsilon),iterations);
% Initialize a cell array for weight vectors
w = cell(length(HN),1);

count = 0;
totalIterations = length(HN)*length(eta)*length(epsilon)*iterations;

for i=1:length(HN)
    numElements = 2;
    numWeights = HN(i)*(numElements+2) + 1;
    w{i} = zeros(length(eta),length(epsilon),iterations,numWeights);
    for j=1:length(eta)
        for k=1:length(epsilon)
            for m=1:iterations
                % Display the progress
                fprintf(1,'\b\b\b\b\b\b\b\b%6.2f %%',count/totalIterations*100);
                
                % disp(['HN: ' num2str(HN(i)) ' eta: ' num2str(eta(j)) ' epsilon: ' num2str(epsilon(k))]);
                % Run the algorithm
                [perf(i,j,k,m,:),w{i}(j,k,m,:)] = runEKFMLP2(...
                    epochs,testSamples,...
                    HN(i), eta(j), epsilon(k), q, ...
                    annealingFlag, perfPlotFlag);
                % Get the average performance of the last 20 runs
                finalAvgPerf(i,j,k,m) = sum(perf(i,j,k,m,(epochs-20+1):epochs))/20;
                % disp(['Final performance: ' num2str(perf(i,j,k,epochs)*100) '%']);
                
                % Increment the counter
                count = count + 1;
            end
        end
    end
    fprintf(1,'\b\b\b\b\b\b\b\b%6.2f %%\n',count/totalIterations*100);
end

%% Calculate the maximum performance
maxPerf = max(max(max(max(finalAvgPerf))));
% Find the max performance and convert the linear index to 3 dimensions
[I1,I2,I3,I4] = ind2sub(size(finalAvgPerf),find(finalAvgPerf >= maxPerf));
% Figure out the actual parameter values
bestHN = HN(I1);
bestEta = eta(I2);
bestEpsilon = epsilon(I3);
bestIteration = I4;
disp('Best Values:');
disp(['  Hidden Nodes: ' num2str(bestHN)]);
disp(['  Eta:          ' num2str(bestEta)]);
disp(['  Epsilon:      ' num2str(bestEpsilon)]);
disp(['  Iteration:    ' num2str(bestIteration)]);

%% Create plots
% Plot the best performance
h = figure;
plot(squeeze(perf(I1,I2,I3,I4,:)));
title('Performance vs. Epochs');
xlabel('Epochs');
ylabel('Performance');
perfFolder = [ saveFolder filesep 'PerformancePlots' ];

% Plot all performances
plotAll = true;
if(plotAll)
    % Create a directory for the plots
    if(exist(perfFolder,'dir') ~= 7)
        mkdir(perfFolder);
    end
    
    index = 1;
    h = figure;
    for i=1:length(HN)
        for j=1:length(eta)
            for k=1:length(epsilon)
                for m=1:iterations
                    plot(squeeze(perf(i,j,k,m,:)));
                    info = ['HN: ' num2str(HN(i))...
                        ' eta: ' num2str(eta(j))...
                        ' epsilon: ' num2str(epsilon(k))...
                        ' q: ' num2str(q)...
                        ' Annealing: ' num2str(annealingFlag)...
                        ' No. ' num2str(m)...
                        ' Final Avg Perf: ' num2str(finalAvgPerf(i,j,k,m),'%4.2f')];
                    title({'Performance vs. Epochs',info});
                    xlabel('Epochs');
                    ylabel('Performance');
                    ylim([0 1]);
                    saveas(h,[perfFolder filesep 'Figure' num2str(index,'%04.4d') '.png']);
                    saveas(h,[perfFolder filesep 'Figure' num2str(index,'%04.4d') '.fig']);
                    index = index + 1;
                end
            end
        end
    end
    close(h);
end

%% Save the workspace variables
dateString = datestr(now,'yyyymmdd_HHMMSS');
fileName = ['mlpekf_gridSearchWIterations' dateString];
save(fileName);