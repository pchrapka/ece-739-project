function [ points, groupName ] = genTrainingDataMLPEKF( epochs, samples )
%GENTRAININGDATAMLPEKF Generates training data formatted for the MLP EKF
%problem

numElements = 2;

points = zeros(epochs,numElements,samples);
groupName = cell(epochs,samples);

for k=1:epochs
    % Generate the training and test data
    [points(k,:,:), groupName(k,:)] = genTrainingData(samples);
end

end

