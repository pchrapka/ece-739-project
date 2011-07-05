%% Script to search through epsilon, eta, values for optimal parameters

clear all;
close all;
clc;

samples = 10;
epochs = 500;
testSamples = 200;
eta = linspace(0.01,1,samples);
epsilon = linspace(0.001,0.01,samples);
% q = linspace(1e-6,0.1,samples);
% HN = round(linspace(5,1000,samples));
HN = [50 80];

perf = zeros(length(HN),length(eta),length(epsilon),epochs);
for i=1:length(HN)
    for j=1:length(eta)
        for k=1:length(epsilon)
            disp(['HN: ' num2str(HN(i)) ' eta: ' num2str(eta(j)) ' epsilon: ' num2str(epsilon(k))]);
            perf(i,j,k,:) = runEKFMLP2(epochs,testSamples, HN(i), eta(j), epsilon(k));
            disp(['Final performance: ' num2str(perf(i,j,k,epochs)*100) '%']);
        end
    end
end

dateString = datestr(now,'yyyymmdd_HHMMSS');
fileName = ['mlpekf_gridSearch' dateString];
save(fileName);

