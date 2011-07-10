clear all;
clc;
close all;

% Load the data file
load mlpekf_simulation20110630_190701_perf66

curFig = figure;
startIndex = trainEpochs+1;
for k=startIndex:epochs
    testPoints = squeeze(points(k,:,:));
    redPoints = (mlpOutput(k,:) >= 0);
    greenPoints = (mlpOutput(k,:) < 0);
    colorMat = redPoints'*red + greenPoints'*green;
    correct = logical((redPoints & ismember(groupName(k,:),'red'))...
        + (greenPoints & ismember(groupName(k,:),'black')));
    incorrect = logical((correct - 1)*-1);
    
    % Plot each epoch
    scatter(testPoints(1,correct),testPoints(2,correct),...
        20,colorMat(correct,:),'Marker','+');
    hold on
    scatter(testPoints(1,incorrect),testPoints(2,incorrect),...
        40,colorMat(incorrect,:),'Marker','x');
    hold on
    axis square;
end

title([{'Classified data'},{'All Test Data'}]);
legend('Correct','Incorrect');
% saveas(curFig,[saveFolder filesep 'Classified Data ' num2str(k) '.png']);
% saveas(curFig,[saveFolder filesep 'Classified Data ' num2str(k) '.fig']);