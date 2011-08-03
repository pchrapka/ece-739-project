function [ perf ] = getPerformanceSVM( simConfig )
%GETPERFORMANCESVM Summary of this function goes here
%   Detailed explanation goes here

% Get some test data
[testPoints,testGroupNames,testDesiredOutput] = ...
    genTrainingData(...
    simConfig.NumTestPoints,...
    simConfig.DesiredOutputValue);

% Flip the generated data
testPoints = testPoints';
testDesiredOutput = testDesiredOutput';

% Classify the data
output = svmclassify(simConfig.SVMStruct,testPoints);

% Figure out the point classes before and after
redPointsBefore = ismember(testGroupNames,'red');
blackPointsBefore = ismember(testGroupNames,'black');
redPointsAfter = (output == 1*simConfig.DesiredOutputValue);
blackPointsAfter = (output == -1*simConfig.DesiredOutputValue);

% Determine the correct points
correct = (output == testDesiredOutput);

% Calculate the performance
perf = sum(correct)/simConfig.NumTestPoints;

% Plot the data
if(simConfig.PlotPerformance)
    figure;
    redPointsCorrect = logical(redPointsAfter & redPointsBefore);
    scatter(...
        testPoints(redPointsCorrect,1),...
        testPoints(redPointsCorrect,2),...
        20,[1 0 0],...
        'Marker','+');
    hold on;
    blackPointsCorrect = logical(blackPointsAfter & blackPointsBefore);
    scatter(...
        testPoints(blackPointsCorrect,1),...
        testPoints(blackPointsCorrect,2),...
        20,[0 0 0],...
        'Marker','+');
    hold on;
    redPointsIncorrect = ~redPointsCorrect & redPointsBefore;
    scatter(...
        testPoints(redPointsIncorrect,1),...
        testPoints(redPointsIncorrect,2),...
        20,[1 0 0],...
        'Marker','x');
    hold on;
    blackPointsIncorrect = ~blackPointsCorrect & blackPointsBefore;
    scatter(...
        testPoints(blackPointsIncorrect,1),...
        testPoints(blackPointsIncorrect,2),...
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
end
   

end

