function [ perf,w ] = runEKFMLP2( epochs, samples, numHiddenNodes, eta, epsilon, q, doAnnealing, plotPerf )
%RUNEKFMLP2 Summary of this function goes here
%   Detailed explanation goes here

% OPTIONS
% Flag to use a random initial weight vector
% Otherwise loads weights from a file
useRandom = true;%false;
% doAnnealing = true; % from args
preProcessData = true;

% Record the starting time
startTime = datestr(now);

% Data configuration
numElements = 2;

% Training configuration
% epochs = 500; % from args
% samples = 200; % from args

% Network configuration
numOutputs = 1;
% numHiddenNodes = 50; % from args

% Network parameters
% eta = 0.56; % from args
% epsilon = 0.001; % from args
% q = 0.0111; % Started at 0.1 which was too large
% q = 0.001; % from args

% Generate the training data
[points, groupName] = genTrainingDataMLPEKF(epochs, samples);
% Get more information about the training data
[desiredOutput, redPoints, blackPoints] = separateDataMLPEKF(groupName);

% Create w, P, W, R, desiredOutput
% NOTE numWeights assumes one output
numWeights = numHiddenNodes*(numElements+2) + 1;
if(useRandom)
    w = randn(numWeights,1);
    % Make the weight vector zero mean
    w = w - mean(w);
else
    w = initWeights(numWeights);
    % Make the weight vector zero mean
    w = w - mean(w);
end
% wSaved = zeros(epochs,numWeights);
P = (1/epsilon)*eye(numWeights);
Q = q*eye(numWeights);
R = (1/eta)*eye(samples);

mlpOutput = zeros(epochs,samples);
perf = zeros(epochs,1);
if(plotPerf)
    h = figure;
end
for k=1:epochs
    % disp(['Training Epoch: ' num2str(k)]);
    
    curTestData = squeeze(points(k,:,:));
    curDesiredOutput = squeeze(desiredOutput(k,:));
    if(preProcessData)
        % Normalize the test data
        curTestData(1,:) = (curTestData(1,:) - mean(curTestData(1,:)))...
            /std(curTestData(1,:));
        curTestData(2,:) = (curTestData(2,:) - mean(curTestData(2,:)))...
            /std(curTestData(2,:));
    end
    
    % Save the current set of weights
    % wSaved(k,:) = w;
    
    % Train the MLP using the Extended Kalman Filter
    [ w,P,mlpOutput(k,:) ] = trainEKF( ...
        w,P,...
        curTestData,...
        curDesiredOutput,...
        Q,R );
    
    % Perform annealing on Q
    if(doAnnealing)
        if(Q(1,1) > 1e-6)
            Q = Q*0.99;
        end
    end
    
    % Get a measure of performance
    perf(k) = getPerfMLP(w,numOutputs,false,preProcessData);
    % disp(['Performance: ' num2str(perf(k)*100) '%']);
    
    if(plotPerf)
        % Plot the performance until now
        figure(h);
        plot(perf(1:k));
        xlim([0 epochs]);
        ylim([0 1]);
        xlabel('Epochs');
        ylabel('Performance');
    end
end

endTime = datestr(now);

% figure;
% plot(1:epochs,perf);
% xlabel('Epochs');
% ylabel('Performance');
% xlim([0 epochs]);
% 
% figure;
% surf(wSaved);
% ylabel('Epoch');
% xlabel('Weight Number');
% zlabel('Weight Value');

end

