%% Script to search through epsilon, eta, values for optimal parameters
clear all;
close all;
clc;

%% Initialize variables
samples = 10;
epochs = 500;
testSamples = 200;
eta = linspace(0.001,1,samples);
epsilon = linspace(0.001,0.01,samples);
% q = linspace(1e-6,0.1,samples);
% HN = round(linspace(5,1000,samples));
q = 0.001;
HN = 10;%10:10:100;
annealingFlag = true;
perfPlotFlag = false;
iterations = 10;

saveFolder = 'C:\Users\Phil\Documents\School\Masters\ECE 739 - Neural Networks\Project\EKF MLP';

%% Perform the search
perf = zeros(length(HN),length(eta),length(epsilon),iterations,epochs);
% finalAvgPerf = zeros(iterations,length(HN),length(eta),length(epsilon));
count = 0;
totalIterations = length(HN)*length(eta)*length(epsilon)*iterations;
% Initialize a cell array for weight vectors
w = cell(length(HN),1);
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
                % finalAvgPerf(i,j,k) = sum(perf(i,j,k,(epochs-20 + 1):epochs))/20;
                % disp(['Final performance: ' num2str(perf(i,j,k,epochs)*100) '%']);
                
                % Increment the counter
                count = count + 1;
            end
        end
    end
end