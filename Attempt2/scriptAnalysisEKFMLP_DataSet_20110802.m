%% Batch analysis script
% Script for analyzing the data files generated by the batch simulation
% script

close all;

selectSubset = true;

%% Find the files
defaultDirectory = 'C:\Users\Phil\Documents\School\Masters\ECE 739 - Neural Networks\Project\EKF MLP\BatchSimulation_20110802_163149';
directoryName = defaultDirectory;

% Get the data files
allFiles = dir([directoryName filesep 'mlpekf_simulation*.mat']);

%% Load all the data files
% Allocate memory for all the data
allSimulations = cell(length(allFiles),1);
% Load each file
for i=1:length(allFiles)
%     simulations(i) = load([directoryName filesep allFiles(i).name]);
    temp = load([directoryName filesep allFiles(i).name]);
    allSimulations{i} = temp.simObj;
end

%% Select a subset of the simulations (optional)
if(selectSubset)
    % Create empty arrays
    simulations = {};
    files = struct(allFiles(1));
    for i=1:length(allSimulations)
        % Select files based on the following condition
        if(allSimulations{i}.r >= 500)
            curLen = length(simulations);
            simulations{curLen+1,1} = allSimulations{i};
            files(curLen+1) = allFiles(i);
        end
    end
    plotDirName = 'AnalysisPlots_R500';
else
    % If we don't a subset just copy all the data
    simulations = allSimulations;
    files = allFiles;
    plotDirName = 'AnalysisPlots';
end

%% Make a folder for the plots
plotDir = [directoryName filesep plotDirName];
if(exist(plotDir,'dir') ~= 7)
    mkdir(plotDir);
end

%% MLP Configuration Comparison

numConfigs = 6;
count = zeros(numConfigs,1);
avgPerf = zeros(simulations{1}.NumEpochs,numConfigs);

% Loop through data sets and sum 
for i=1:length(simulations)
    switch(length(simulations{i}.MLPConfigObj.NumHiddenNodes))
        case 1
            switch(simulations{i}.MLPConfigObj.NumHiddenNodes(1))
                case 10
                    index = 1;
                    avgPerf(:,index) = avgPerf(:,index) + simulations{i}.Performance;
                    count(index) = count(index) + 1;
                case 20
                    index = 2;
                    avgPerf(:,index) = avgPerf(:,index) + simulations{i}.Performance;
                    count(index) = count(index) + 1;
                case 30
                    index = 3;
                    avgPerf(:,index) = avgPerf(:,index) + simulations{i}.Performance;
                    count(index) = count(index) + 1;
                otherwise
                    disp('Unknown number of hidden nodes');
                    disp(num2str(simulations{i}.MLPConfigObj.NumHiddenNodes));
            end
        case 2
            switch(simulations{i}.MLPConfigObj.NumHiddenNodes(1))
                case 4
                    index = 4;
                    avgPerf(:,index) = avgPerf(:,index) + simulations{i}.Performance;
                    count(index) = count(index) + 1;
                case 10
                    index = 5;
                    avgPerf(:,index) = avgPerf(:,index) + simulations{i}.Performance;
                    count(index) = count(index) + 1;
                case 20
                    index = 6;
                    avgPerf(:,index) = avgPerf(:,index) + simulations{i}.Performance;
                    count(index) = count(index) + 1;
                otherwise
                    disp('Unknown number of hidden nodes');
                    disp(num2str(simulations{i}.MLPConfigObj.NumHiddenNodes));
            end
        otherwise
            disp('Unknown number of hidden nodes');
            disp(num2str(simulations{i}.MLPConfigObj.NumHiddenNodes));
    end
end

% Take the average
for i=1:numConfigs
    avgPerf(:,i) = avgPerf(:,i)/count(i);
end

epochAxis = 1:1:simulations{1}.NumEpochs;
figure;
plot(epochAxis,100*(1-avgPerf));
legend(...
    '1 Layer 10 Hidden Nodes',...
    '1 Layer 20 Hidden Nodes',...
    '1 Layer 30 Hidden Nodes',...
    '2 Layer 4,3 Hidden Nodes',...
    '2 Layer 10,3 Hidden Nodes',...
    '2 Layer 20,6 Hidden Nodes',...
    'Location','Best');
ylim([0 60]);
title('Comparison of MLP Network Architectures');
xlabel('Epochs');
ylabel('Error Rate (%)');

%% Desired Output Comparison

numValues = 4;
count = zeros(numValues,1);
avgPerf = zeros(simulations{1}.NumEpochs,numValues);

% Loop through data sets and sum 
for i=1:length(simulations)
    switch(simulations{i}.DesiredOutputValue)
        case 1
            index = 1;
            avgPerf(:,index) = avgPerf(:,index) + simulations{i}.Performance;
            count(index) = count(index) + 1;
        case 2
            index = 2;
            avgPerf(:,index) = avgPerf(:,index) + simulations{i}.Performance;
            count(index) = count(index) + 1;
        case 5
            index = 3;
            avgPerf(:,index) = avgPerf(:,index) + simulations{i}.Performance;
            count(index) = count(index) + 1;
        case 10
            index = 4;
            avgPerf(:,index) = avgPerf(:,index) + simulations{i}.Performance;
            count(index) = count(index) + 1;
        otherwise
            disp('Unknown desired output');
            disp(num2str(simulations{i}.DesiredOutputValue));
    end
end

% Take the average
for i=1:numValues
    avgPerf(:,i) = avgPerf(:,i)/count(i);
end

epochAxis = 1:1:simulations{1}.NumEpochs;
figure;
plot(epochAxis,100*(1-avgPerf));
legend(...
    'Desired Output = 1',...
    'Desired Output = 2',...
    'Desired Output = 5',...
    'Desired Output = 10',...
    'Location','Best');
ylim([0 60]);
title('Comparison of Desired Output Values');
xlabel('Epochs');
ylabel('Error Rate (%)');

