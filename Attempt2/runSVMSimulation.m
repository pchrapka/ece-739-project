function [ simConfig ] = runSVMSimulation( simConfig )
%RUNSVMSIMULATION Summary of this function goes here
%   Detailed explanation goes here

% Allocate memory for all of the training data
trainingData = zeros(simConfig.NumPointsPerEpoch*simConfig.NumEpochs,2);
groupNames = cell(simConfig.NumPointsPerEpoch*simConfig.NumEpochs,1);
desiredOutput = zeros(simConfig.NumPointsPerEpoch*simConfig.NumEpochs,1);

% Train the algorithm for the number of epochs, on every iteration add in a
% new epoch to improve performance
for k=1:simConfig.NumEpochs
   disp(['Epoch ' num2str(k)]);
   % Generate the new training data for this epoch
   [newDataPoints,newGroupNames,newDesiredOutput] = ...
       genTrainingData(...
       simConfig.NumPointsPerEpoch,...
       simConfig.DesiredOutputValue);
   
   % Flip the generated data
   newDataPoints = newDataPoints';
   newDesiredOutput = newDesiredOutput';
   
   % Calculate the indexes
   startIndex = (k-1)*simConfig.NumPointsPerEpoch+1;
   endIndex = k*simConfig.NumPointsPerEpoch;
   
   % Add the new training data to the rest of the data
   trainingData(startIndex:endIndex,:) = newDataPoints;
   groupNames(startIndex:endIndex) = newGroupNames;
   desiredOutput(startIndex:endIndex) = newDesiredOutput;
   
   % Set optimization options, so we don't run into max iteration problems
   % Set the max number of iterations to 200000
   maxIterations = 200000;
%    options = optimset('quadprog');
%    options = optimset(options,'MaxIter',maxIterations);
    options = svmsmoset('MaxIter',maxIterations*200);

   % Get the starting time
   simConfig.StartTime = datestr(now);
   % Train the SVM
%    simConfig.SVMStruct = svmtrain(...
%        trainingData(1:endIndex,:),...
%        desiredOutput(1:endIndex),...
%        'Kernel_Function','rbf',...
%        'Method','QP',...
%        'QuadProg_Opts',options,...
%        'BoxConstraint',simConfig.BoxConstraint);
    simConfig.SVMStruct = svmtrain(...
       trainingData(1:endIndex,:),...
       desiredOutput(1:endIndex),...
       'Kernel_Function','rbf',...
       'Method','SMO',...
       'SMO_Opts',options,...
       'BoxConstraint',simConfig.BoxConstraint);
   % Get the ending time
   simConfig.EndTime = datestr(now);
   
   % Get the performance
   simConfig.Performance(k) = getPerformanceSVM(simConfig);
   disp(['Performance ' num2str(simConfig.Performance(k))]);
       
end

end

