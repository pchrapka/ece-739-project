function [ simConfig ] = runEKFMLPSimulation( simConfig )
%RUNEKFMLPSIMULATION Summary of this function goes here
%   Detailed explanation goes here

% Get the number of weights
numWeights = simConfig.MLPConfigObj.NumWeights;

% Initialize the weight vector with random values
w = randn(numWeights,1);

% Initialize parameters for the EKF
P = simConfig.p*eye(numWeights);
Q = simConfig.q*eye(numWeights);
R = simConfig.r*eye(simConfig.NumPointsPerEpoch);

% Initialize the performance plot
if(simConfig.PlotPerf)
    perfPlot = figure;
end

% Train the algorithm for the number of epochs
for k=1:simConfig.NumEpochs
    % Generate the training data for this epoch
    [trainingPoints, ~, desiredOutput] = genTrainingData(...
        simConfig.NumPointsPerEpoch, ...
        simConfig.DesiredOutputValue);
    
    % Train the EKF
    [w,P,~] = trainEKF(simConfig.MLPConfigObj,...
        w,P,...
        trainingPoints, desiredOutput,...
        Q,R);
    
    % Perform annealing on Q
    if(simConfig.DoAnnealing)
        if(Q(1,1) > 1e-6)
            Q = Q*0.99;
        end
    end
    
    % Measure it's performance
    simConfig.Performance(k) = getPerformance(...
        simConfig,w,simConfig.NumTestPoints);
    
    % Plot performance on the fly
    if(simConfig.PlotPerf)
        figure(perfPlot);
        plot(simConfig.Performance(1:k));
        xlim([0 simConfig.NumEpochs]);
        ylim([0 1]);
        xlabel('Epochs');
        ylabel('Performance');
    end
    
end

% Save the final w and P
simConfig.FinalW = w;
simConfig.FinalP = P;

end

