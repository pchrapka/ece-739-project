%% Script to search through epsilon, eta, values for optimal parameters
clear all;
close all;
clc;

%% Initialize variables
samples = 10;
epochs = 500;
testSamples = 200;
eta = linspace(0.01,1,samples);
epsilon = linspace(0.001,0.01,samples);
% q = linspace(1e-6,0.1,samples);
% HN = round(linspace(5,1000,samples));
HN = 40:10:130;
saveFolder = 'C:\Users\Phil\Documents\School\Masters\ECE 739 - Neural Networks\Project\EKF MLP';

%% Perform the search
perf = zeros(length(HN),length(eta),length(epsilon),epochs);
finalAvgPerf = zeros(length(HN),length(eta),length(epsilon));
for i=1:length(HN)
    for j=1:length(eta)
        for k=1:length(epsilon)
            disp(['HN: ' num2str(HN(i)) ' eta: ' num2str(eta(j)) ' epsilon: ' num2str(epsilon(k))]);
            % Run the algorithm
            [perf(i,j,k,:),~] = runEKFMLP2(epochs,testSamples, HN(i), eta(j), epsilon(k));
            % Get the average performance of the last 20 runs
            finalAvgPerf(i,j,k) = sum(perf(i,j,k,(epochs-20 + 1):epochs))/20;
            disp(['Final performance: ' num2str(perf(i,j,k,epochs)*100) '%']);
        end
    end
end

%% Calculate the maximum performance
maxPerf = max(max(max(finalAvgPerf)));
% Find the max performance and convert the linear index to 3 dimensions
[I1,I2,I3] = ind2sub(size(finalAvgPerf),find(finalAvgPerf >= maxPerf));
% Figure out the actual parameter values
bestHN = HN(I1);
bestEta = eta(I2);
bestEpsilon = epsilon(I3);
disp('Best Values:');
disp(['  Hidden Nodes: ' num2str(bestHN)]);
disp(['  Eta:          ' num2str(bestEta)]);
disp(['  Epsilon:      ' num2str(beatEpsilon)]);

%% Create plots
% Plot the best performance
h = figure;
plot(squeeze(perf(I1,I2,I3,:)));
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
                plot(squeeze(perf(i,j,k,:)));
                info = ['HN: ' num2str(HN(i))...
                    ' eta: ' num2str(eta(j))...
                    ' epsilon: ' num2str(epsilon(k))...
                    ' Final Avg Perf: ' num2str(finalAvgPerf(i,j,k),'%4.2f')];
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
    close(h);
end

%% Save the workspace variables
dateString = datestr(now,'yyyymmdd_HHMMSS');
fileName = ['mlpekf_gridSearch' dateString];
save(fileName);