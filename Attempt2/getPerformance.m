function [ perf ] = getPerformance( simConfig, w, numTestPoints )
%GETPERFORMANCE Summary of this function goes here
%   Detailed explanation goes here

[testPoints, groupName, desiredOutput] = genTrainingData(...
        numTestPoints, simConfig.DesiredOutputValue);

% Get the MLP config
mlpConfig = simConfig.MLPConfigObj;

% Simulate the MLP
output = mlpConfig.SimFunc(mlpConfig, w, testPoints);

% Figure out the point classes before and after
redPointsBefore = ismember(groupName,'red');
blackPointsBefore = ismember(groupName,'black');
redPointsAfter = (output >= 0);
blackPointsAfter = (output < 0);

% Determine the number of points classified correctly
correct = logical(redPointsAfter & redPointsBefore)...
    + logical(blackPointsAfter & blackPointsBefore);

% Calculate the performance
perf = sum(correct)/numTestPoints;

if(simConfig.PlotClassifiedData)
    saveFolder = 'C:\Users\Phil\Documents\School\Masters\ECE 739 - Neural Networks\Project\EKF MLP';
    simConfig.PlotClassifiedDataFigHandle = figure;
    redPointsCorrect = logical(redPointsAfter & redPointsBefore);
    scatter(...
        testPoints(1,redPointsCorrect),...
        testPoints(2,redPointsCorrect),...
        20,[1 0 0],...
        'Marker','+');
    hold on;
    blackPointsCorrect = logical(blackPointsAfter & blackPointsBefore);
    scatter(...
        testPoints(1,blackPointsCorrect),...
        testPoints(2,blackPointsCorrect),...
        20,[0 0 0],...
        'Marker','+');
    hold on;
    redPointsIncorrect = ~redPointsCorrect & redPointsBefore;
    scatter(...
        testPoints(1,redPointsIncorrect),...
        testPoints(2,redPointsIncorrect),...
        20,[1 0 0],...
        'Marker','x');
    hold on;
    blackPointsIncorrect = ~blackPointsCorrect & blackPointsBefore;
    scatter(...
        testPoints(1,blackPointsIncorrect),...
        testPoints(2,blackPointsIncorrect),...
        20,[0 0 0],...
        'Marker','x');
    title('Classified data');
    
    % Construct legend string
    ind1 = 1;
    if(sum(redPointsCorrect) ~= 0)
        legendString{ind1} = 'Correct red points';
        ind1 = ind1 + 1;
    end
    if(sum(blackPointsCorrect) ~= 0)
        legendString{ind1} = 'Correct black points';
        ind1 = ind1 + 1;
    end
    if(sum(redPointsIncorrect) ~= 0)
        legendString{ind1} = 'Incorrect red points';
        ind1 = ind1 + 1;
    end
    if(sum(blackPointsIncorrect) ~= 0)
        legendString{ind1} = 'Incorrect black points';
    end
    legend(legendString,'Location','BestOutside');
    
    axis square;
    hold off;
    
    saveas(simConfig.PlotClassifiedDataFigHandle,[saveFolder filesep 'Classification Performance' '.png']);
    saveas(simConfig.PlotClassifiedDataFigHandle,[saveFolder filesep 'Classification Performance' '.fig']);
    
%     % Create a 3D scatter plot
%     figure;
%     x = squeeze(testPoints(1,:));
%     y = squeeze(testPoints(2,:));
%     z = squeeze(mlpOutput)';
%     scatter3(x,y,z,10,z);
%     axis square;
%     view(2);
%     title('Output scatter plot of MLP EKF');
    
    figure;
    x = squeeze(testPoints(1,:));
    y = squeeze(testPoints(2,:));
    z = output';
    tri = delaunay(x,y);
    trisurf(tri,x,y,z);
    hold on
    axis square;
    title('Output surface of MLP EKF');
end

end

