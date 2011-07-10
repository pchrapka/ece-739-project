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