%% Script to simulate the EKF trained MLP
clear all;
clc;
close all;

%% Create a SimulationConfig object
simObj = SimulationConfig();

%% Initialize all the relevant variables
simObj.NumEpochs = 500;
simObj.NumPointsPerEpoch = 200;
simObj.DesiredOutputValue = 10;
simObj.p = 100;
simObj.q = 0.001;
simObj.r = 500;
% Turn on performance plotting on the fly
simObj.PlotPerf = true;
simObj.NumTestPoints = 200;
simObj.DoAnnealing = true;

%% Create an MLPConfig object
simObj.MLPConfigObj = MLPConfig();

%% Initialize the MLPConfig object
% Use 2 hidden layers
simObj.MLPConfigObj.NumHiddenLayers = 2;
simObj.MLPConfigObj.NumHiddenNodes = [10 3];
simObj.MLPConfigObj.SimFunc = @simMLP2Layer;

% Use 1 hidden layer
% simObj.MLPConfigObj.NumHiddenLayers = 1;
% simObj.MLPConfigObj.NumHiddenNodes = [10];
% simObj.MLPConfigObj.SimFunc = @simMLP1Layer;

%% Initialize the SimulationConfig object
simObj = simObj.Init();

%% Run the simulation
simObj = runEKFMLPSimulation(simObj);

%% Get some performance plots
simObj.PlotClassifiedData = true;
simObj.NumTestPoints = 1000;
perf = getPerformance(simObj, simObj.FinalW, simObj.NumTestPoints)