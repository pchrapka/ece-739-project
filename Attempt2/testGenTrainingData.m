%% Generate data points and plot them
numPoints = 5000;

[trainingPoints, groupName, desiredOutput] = genTrainingData(numPoints,0.7);

red = [1 0 0];
black = [0 0 0];
group1Color = ismember(groupName,'red') * red;
group2Color = ismember(groupName,'black') * black;
colorMat = group1Color + group2Color;

figure;
scatter(trainingPoints(1,:),...
    trainingPoints(2,:),...
    20,colorMat,'filled');
axis square

%% Check the statistics on the data
% xMean = mean(training(1,:));
% xVar = var(training(1,:));
% xStd = std(training(1,:));
% xZeroMean = training(1,:) - xMean;
% xVar2 = var(xNormalized);
% xVar3 = var(training(1,:)/std(training(1,:)));
% xNormalized = xZeroMean/xStd;
% 
% yMean = mean(training(2,:));
% yVar = var(training(2,:));