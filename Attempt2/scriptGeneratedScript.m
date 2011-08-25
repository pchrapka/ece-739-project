simNumber = 1;
for a=1:1
for b=1:3
for c=1:2
for d=1:6
for e=1:1
for f=1:4
% Create a MLPSimulationConfig object
simObj = MLPSimulationConfig();
% Initialize variables
simObj.NumEpochs = 500;
simObj.NumPointsPerEpoch = 200;
simObj.PlotPerf = false;
% Initialize the MLPSimulationConfig object
simObj = simObj.Init();
% Initialize the simulation parameters
for A=1:length(parameters)
simObj.(parameters{A}{1}) = parameters{A}{2}(eval(parameters{A}{3}));
end
disp(['Simulation ' num2str(simNumber)]);
try
% Run the simulation
simObj = runEKFMLPSimulation(simObj);
catch ex
% Catch an exception if it occurs
disp('Caught an exception');
disp(ex);
simObj.Exception = ex;
end
% Save the workspace variables
dateString = datestr(now,'yyyymmdd');
fileName = ['mlpekf_simulation' dateString '_' num2str(simNumber,'%5.5d')];
save([saveFolder filesep fileName],'simObj');
simNumber = simNumber + 1;
end
end
end
end
end
end
