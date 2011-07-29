simNumber = 1;
for a=1:3
for b=1:3
for c=1:2
for d=1:3
for e=1:6
for A=1:length(parameters)
simObj.(parameters{A}{1}) = parameters{A}{2}(eval(parameters{A}{3}));
end
disp(['Simulation ' num2str(simNumber)]);
try
%% Run the simulation
simObj = runEKFMLPSimulation(simObj);
catch ex
disp(ex);
simObj.Exception = ex;
end
%% Save the workspace variables
dateString = datestr(now,'yyyymmdd');
fileName = ['mlpekf_simulation' dateString '_' num2str(simNumber,'%5.5d')];
save([saveFolder filesep fileName],'simObj');
simNumber = simNumber + 1;
end
end
end
end
end
