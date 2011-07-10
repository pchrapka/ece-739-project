function [ perf ] = getPerfMLP( w,numOutputs )
%GETPERFMLP Summary of this function goes here
%   Detailed explanation goes here

epochs = 1;
samples = 1000;

% Generate the training data
[testPoints, groupName] = genTrainingDataMLPEKF(epochs, samples);
% Get more information about the training data
[desiredOutput, redPoints, blackPoints] = separateDataMLPEKF(groupName);

mlpOutput = simMLP(w,squeeze(testPoints(1,:,:)),numOutputs);

redPointsAfter = (mlpOutput >= 0);
blackPointsAfter = (mlpOutput < 0);

correct = logical(redPointsAfter & redPoints) + logical(blackPointsAfter & blackPoints);
% incorrect = logical(blackPointsAfter & blackPoints);

perf = sum(correct)/samples;

end

