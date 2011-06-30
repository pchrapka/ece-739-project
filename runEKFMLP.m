function [ avgPerf ] = runEKFMLP( epochs, samples, numHiddenNodes, Qweight, Rweight )
%RUNEKFMLP Summary of this function goes here
%   Detailed explanation goes here

if(mod(epochs,2) ~= 0)
    error('Make the number epochs even');
end
% Record the starting time
startTime = datestr(now);

numOutputs = 1;
% numHiddenNodes = 30;
numElements = 2;

points = zeros(epochs,numElements,samples);
groups = zeros(epochs,samples);
groupName = cell(epochs,samples);
desiredOutput = ones(epochs,samples);
for k=1:epochs
    % Generate the training and test data
    [points(k,:,:), groupName(k,:)] = genTrainingData(samples);
    % Differentiate the groups
    groups(k,:) = ismember(groupName(k,:),'red');
    % Make red = 0.7 and black = -0.7
    desiredOutput(k,:) = groups(k,:)*0.7 + (groups(k,:)-1)*-0.7;
end

% Create w, P, W, R, desiredOutput
% NOTE numWeights assumes one output
numWeights = numHiddenNodes*(numElements+2) + 1;
w = randn(numWeights,1);
P = eye(numWeights);
Q = Qweight*eye(numWeights);
R = Rweight*eye(samples);

trainEpochs = epochs/2;
mlpOutput = zeros(epochs,samples);
for k=1:trainEpochs

    % Randomly select training and test sets
    % [train, test] = crossvalind('holdOut',groups);
    % cp = classperf(groups); % Not sure exactly how this works so maybe
    
    % Train the MLP using the Extended Kalman Filter
    [ w,P,mlpOutput(k,:) ] = trainEKF( ...
        w,P,...
        squeeze(points(k,:,:)),...
        squeeze(desiredOutput(k,:)),...
        Q,R );
    
end

red = [1 0 0];
green = [0 1 0];
saveFolder = 'C:\Users\Phil\Documents\School\Masters\ECE 739 - Neural Networks\Project\EKF MLP';

% Evaluate the performance of the MLP
startIndex = trainEpochs+1;
perf = zeros(epochs - startIndex,1);
for k=startIndex:epochs
    mlpOutput(k,:) = simMLP(w,squeeze(points(k,:,:)),numOutputs);
    
    testPoints = squeeze(points(k,:,:));
    redPoints = (mlpOutput(k,:) >= 0);
    greenPoints = (mlpOutput(k,:) < 0);
    colorMat = redPoints'*red + greenPoints'*green;
    correct = logical((redPoints & ismember(groupName(k,:),'red'))...
        + (greenPoints & ismember(groupName(k,:),'black')));
    incorrect = logical((correct - 1)*-1);
    
    % Record the performance
    perf(k-epochs/2+1,1) = sum(correct)/samples;
    
    % Plot each epoch
%     curFig = figure;
%     scatter(testPoints(1,correct),testPoints(2,correct),...
%         20,colorMat(correct,:),'Marker','+');
%     hold on
%     scatter(testPoints(1,incorrect),testPoints(2,incorrect),...
%         40,colorMat(incorrect,:),'Marker','x');
%     hold off
%     axis square;
%     title('Classified data');
%     legend('Correct','Incorrect');
%     saveas(curFig,[saveFolder filesep 'Classified Data ' num2str(k) '.png']);
%     saveas(curFig,[saveFolder filesep 'Classified Data ' num2str(k) '.fig']);
%     close(curFig);
end
endTime = datestr(now);

avgPerf = sum(perf)/(epochs/2);

% dateString = datestr(now,'yyyymmdd_HHMMSS');
% fileName = ['mlpekf_simulation' dateString];
% % Save all variables to a file
% save(fileName);


end


