%% Script to simulate the SVM
clear all;
clc;
close all;

%% Initialize batch parameters 
boxConstraint = [100 200 2500];

%% Create a folder
saveFolder = 'C:\Users\Phil\Documents\School\Masters\ECE 739 - Neural Networks\Project\SVM\';
dateString = datestr(now,'yyyymmdd_HHMMSS');
saveFolder = [saveFolder 'BatchSimulation_' dateString];
if(exist(saveFolder,'dir')~=7)
    mkdir(saveFolder);
end

%% Run the simulations
simNumber = 1;
for i=1:length(boxConstraint)
    % Create an SVMSimulationConfig object
    simObj = SVMSimulationConfig();

    % Initialize all the relevante variables
    simObj.BoxConstraint = boxConstraint(i);
    simObj.DesiredOutputValue = 1;
    simObj.NumEpochs = 200;

    % Initialize the SVMSimulationConfig object
    simObj = simObj.Init();

    % Run the simulation
    simObj = runSVMSimulation(simObj);
    
    % Save the object
    dateString = datestr(now,'yyyymmdd');
    fileName = ['svm_simulation_' dateString '_' num2str(simNumber,'%5.5d')];
    save([saveFolder filesep fileName],'simObj');
    simNumber = simNumber + 1;
end

% simObj.PlotPerformance = true;
% simObj.NumTestPoints = 2000;
% perf = getPerformanceSVM(simObj);