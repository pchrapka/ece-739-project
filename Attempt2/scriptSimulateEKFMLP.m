%% Script to simulate the EKF trained MLP
clear all;
clc;
close all;

%% Create a MLPSimulationConfig object
simObj = MLPSimulationConfig();

%% Initialize all the relevant variables
simObj.NumEpochs = 200;
simObj.NumPointsPerEpoch = 200;
simObj.DesiredOutputValue = 10;
simObj.p = 10;
simObj.q = 0.001;
simObj.r = 900;
% Turn on performance plotting on the fly
simObj.PlotPerf = false;
simObj.NumTestPoints = 200;
simObj.DoAnnealing = false;

%% Create an MLPConfig object
simObj.MLPConfigObj = MLPConfig();

%% Initialize the MLPConfig object
% Use 2 hidden layers
simObj.MLPConfigObj.NumHiddenLayers = 2;
simObj.MLPConfigObj.NumHiddenNodes = [24 8];
simObj.MLPConfigObj.SimFunc = @simMLP2Layer;

% Use 1 hidden layer
% simObj.MLPConfigObj.NumHiddenLayers = 1;
% simObj.MLPConfigObj.NumHiddenNodes = [10];
% simObj.MLPConfigObj.SimFunc = @simMLP1Layer;

%% Initialize the MLPSimulationConfig object
simObj = simObj.Init();

%% Run the simulation
StartTime = datestr(now);
simObj = runEKFMLPSimulation(simObj);
EndTime = datestr(now);

%% Get some performance plots
simObj.PlotClassifiedData = true;
simObj.NumTestPoints = 1000;
perf = getPerformance(simObj, simObj.FinalW, simObj.NumTestPoints)