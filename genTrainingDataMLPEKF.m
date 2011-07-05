function [ points, groupName ] = genTrainingDataMLPEKF( epochs, samples )
%GENTRAININGDATAMLPEKF Generates training data formatted for the MLP EKF
%problem

numElements = 2;

points = zeros(epochs,numElements,samples);
% groups = zeros(epochs,samples);
groupName = cell(epochs,samples);
% desiredOutput = zeros(epochs,samples);

for k=1:epochs
    % Generate the training and test data
    [points(k,:,:), groupName(k,:)] = genTrainingData(samples);
    % Differentiate the groups
%     groups(k,:) = ismember(groupName(k,:),'red');
    
    % Make red = 0.7 and black = -0.7
%     desiredOutput(k,:) = groups(k,:)*0.7 + (groups(k,:)-1)*0.7;
end

end

