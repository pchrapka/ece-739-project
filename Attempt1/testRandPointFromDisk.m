numPoints = 2000;
diameter = 0.8;
% point = zeros(numPoints,2);

for i=1:numPoints
    [point(i,1), point(i,2)] = randPointFromDisk(diameter);
end

figure;
scatter(getcolumn(point(1:numPoints,1:2),1),...
    getcolumn(point(1:numPoints,1:2),2),...
    'DisplayName','point(1:numPoints,1:2)(:,1) vs. point(1:numPoints,1:2)(:,2)',...
    'YDataSource','point(1:numPoints,1:2)(:,2)');
axis square