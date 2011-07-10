%% Test script for testTrainEKF
close all;
clear all;
clc;

% Record the starting time
startTime = datestr(now);

% Data configuration
numElements = 2;

% Training configuration
epochs = 500;
samples = 200;

% Network configuration
numOutputs = 1;
numHiddenNodes = 50;

% Network parameters
eta = 0.56;
epsilon = 0.001;
% NOTE I think q is still too big here
q = 0.0111;

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
figure;
for k=1:epochs
    disp(['Training Epoch: ' num2str(k)]);
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
    perf(k) = getPerfMLP(w,numOutputs);
    disp(['Performance: ' num2str(perf(k)*100) '%']);
    
end

endTime = datestr(now);

figure;
plot(1:epochs,perf);
xlabel('Epochs');
ylabel('Performance');
xlim([0 epochs]);

figure;
surf(wSaved);
ylabel('Epoch');
xlabel('Weight Number');
zlabel('Weight Value');
