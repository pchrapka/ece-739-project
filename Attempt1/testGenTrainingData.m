%% Generate data points and plot them
numPoints = 5000;

[training, group] = genTrainingData(numPoints);

red = [1 0 0];
green = [0 1 0];
group1Color = ismember(group,'red') * red;
group2Color = ismember(group,'black') * green;
colorMat = group1Color + group2Color;

figure;
scatter(training(1,:),...
    training(2,:),...
    20,colorMat,...
    'DisplayName','point(1:numPoints,1:2)(:,1) vs. point(1:numPoints,1:2)(:,2)',...
    'YDataSource','point(1:numPoints,1:2)(:,2)');
axis square

%% Check the statistics on the data
xMean = mean(training(1,:));
xVar = var(training(1,:));
xStd = std(training(1,:));
xZeroMean = training(1,:) - xMean;
xVar2 = var(xNormalized);
xVar3 = var(training(1,:)/std(training(1,:)));
xNormalized = xZeroMean/xStd;

yMean = mean(training(2,:));
yVar = var(training(2,:));