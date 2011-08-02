%% Batch analysis script
% Script for analyzing the data files generated by the batch simulation
% script

%% Find the files
% Ask the user for the data file directory
defaultDirectory = 'C:\Users\Phil\Documents\School\Masters\ECE 739 - Neural Networks\Project\EKF MLP\';
directoryName = uigetdir(defaultDirectory,'Select the data file directory');

% Get the data files
files = dir([directoryName filesep 'mlpekf_simulation*.mat']);

%% Load all the data files
% Allocate memory for all the data
simulations = cell(length(files),1);
% Load each file
for i=1:length(files)
%     simulations(i) = load([directoryName filesep files(i).name]);
    temp = load([directoryName filesep files(i).name]);
    simulations{i} = temp.simObj;
end

%% Make a folder for the plots
plotDir = [directoryName filesep 'Plots'];
if(exist(plotDir,'dir') ~= 7)
    mkdir(plotDir);
end

%% Print out the simulations that had errors
% disp('The following simulations had errors');
% count = 0;
% for i=1:length(simulations)
%     if(~isempty(simulations{i}.Exception))
%         disp(['Simulation: ' files(i).name]);
%         disp(['  DesiredOutputValue: '...
%             num2str(simulations{i}.DesiredOutputValue)]);
%         disp(['  p: '...
%             num2str(simulations{i}.p)]);
%         disp(['  q: '...
%             num2str(simulations{i}.q)]);
%         disp(['  r: '...
%             num2str(simulations{i}.r)]);
%         disp(['  NumHiddenLayers: '...
%             num2str(simulations{i}.MLPConfigObj.NumHiddenLayers)]);
%         disp(['  NumHiddenNodes: '...
%             num2str(simulations{i}.MLPConfigObj.NumHiddenNodes)]);
%         count = count + 1;
%     end
% end

%% Calculate the final average performance
tail = 20;
finalAvg = zeros(length(simulations),1);
for i=1:length(simulations)
    finalAvg(i) = sum(simulations{i}.Performance(end-tail+1:end))/tail;
end

%% Plot the performance
h = figure;
for i=1:length(simulations)
    plot(simulations{i}.Performance);
    info = ['HN: ' num2str(simulations{i}.MLPConfigObj.NumHiddenNodes)...
        ' p: ' num2str(simulations{i}.p)...
        ' r: ' num2str(simulations{i}.r)...
        ' q: ' num2str(simulations{i}.q)...
        ' Annealing: ' num2str(simulations{i}.DoAnnealing)...
        ' Final Avg Perf: ' num2str(finalAvg(i),'%4.2f')];
    title({'Performance vs. Epochs',info});
    xlabel('Epochs');
    ylabel('Performance');
    ylim([0 1]);
    saveas(h,[plotDir filesep files(i).name '_Performance' '.png']);
    saveas(h,[plotDir filesep files(i).name '_Performance' '.fig']);
end
close(h);