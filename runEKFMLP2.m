function [ perf,w ] = runEKFMLP2( epochs, samples, numHiddenNodes, eta, epsilon )
%RUNEKFMLP2 Summary of this function goes here
%   Detailed explanation goes here

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
q = 0.0111; % Started at 0.1 which was too large

% Generate the training data
[points, groupName] = genTrainingDataMLPEKF(epochs, samples);
% Get more information about the training data
[desiredOutput, redPoints, blackPoints] = separateDataMLPEKF(groupName);

% Create w, P, W, R, desiredOutput
% NOTE numWeights assumes one output
numWeights = numHiddenNodes*(numElements+2) + 1;
w = randn(numWeights,1);
wSaved = zeros(epochs,numWeights);
P = (1/epsilon)*eye(numWeights);
Q = q*eye(numWeights);
R = (1/eta)*eye(samples);

mlpOutput = zeros(epochs,samples);
perf = zeros(epochs,1);
for k=1:epochs
    disp(['Training Epoch: ' num2str(k)]);
    % Save the current set of weights
    wSaved(k,:) = w;
    % Randomly select training and test sets
    % [train, test] = crossvalind('holdOut',groups);
    % cp = classperf(groups); % Not sure exactly how this works so maybe
    
    % Train the MLP using the Extended Kalman Filter
    [ w,P,mlpOutput(k,:) ] = trainEKF( ...
        w,P,...
        squeeze(points(k,:,:)),...
        squeeze(desiredOutput(k,:)),...
        Q,R );
    
    % Perform annealing on Q
    if(Q(1,1) > 1e-6)
        Q = Q*0.99;
    end
    
    % Get a measure of performance
    % TODO may need to fix this to get mean squared error
    perf(k) = getPerfMLP(w,numOutputs,false);
    disp(['Performance: ' num2str(perf(k)*100) '%']);
    
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

