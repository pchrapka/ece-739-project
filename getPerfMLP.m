function [ perf ] = getPerfMLP( w, numOutputs, plotOutput )
%GETPERFMLP Summary of this function goes here
%   Detailed explanation goes here

epochs = 1;
samples = 1000;

% Generate the training data
[testPoints, groupName] = genTrainingDataMLPEKF(epochs, samples);
% Get more information about the training data
[desiredOutput, redPoints, blackPoints] = separateDataMLPEKF(groupName);

mlpOutput = simMLP(w,squeeze(testPoints(1,:,:)),numOutputs);

redPointsAfter = (mlpOutput >= 0);
blackPointsAfter = (mlpOutput < 0);

correct = logical(redPointsAfter & redPoints) + logical(blackPointsAfter & blackPoints);
% incorrect = logical(blackPointsAfter & blackPoints);

perf = sum(correct)/samples;

if(plotOutput)
    saveFolder = 'C:\Users\Phil\Documents\School\Masters\ECE 739 - Neural Networks\Project\EKF MLP';
    h = figure;
    redPointsCorrect = logical(redPointsAfter & redPoints);
    scatter(...
        testPoints(1,1,redPointsCorrect),...
        testPoints(1,2,redPointsCorrect),...
        20,[1 0 0],...
        'Marker','+');
    hold on;
    blackPointsCorrect = logical(blackPointsAfter & blackPoints);
    scatter(...
        testPoints(1,1,blackPointsCorrect),...
        testPoints(1,2,blackPointsCorrect),...
        20,[0 0 0],...
        'Marker','+');
    hold on;
    redPointsIncorrect = ~redPointsCorrect & redPoints;
    scatter(...
        testPoints(1,1,redPointsIncorrect),...
        testPoints(1,2,redPointsIncorrect),...
        20,[1 0 0],...
        'Marker','x');
    hold on;
    blackPointsIncorrect = ~blackPointsCorrect & blackPoints;
    scatter(...
        testPoints(1,1,blackPointsIncorrect),...
        testPoints(1,2,blackPointsIncorrect),...
        20,[0 0 0],...
        'Marker','x');
    title('Classified data');
    legend(...
        'Correct red points',...
        'Correct black points',...
        'Incorrect red points',...
        'Incorrect black points');
    axis square;
    hold off;
    saveas(h,[saveFolder filesep 'Classification Performance' '.png']);
    saveas(h,[saveFolder filesep 'Classification Performance' '.fig']);
    
    % Create a 3D scatter plot
    figure;
    x = squeeze(testPoints(1,1,:));
    y = squeeze(testPoints(1,2,:));
    z = squeeze(mlpOutput)';
    scatter3(x,y,z,10,z);
    axis square;
    view(2);
    title('Output scatter plot of MLP EKF');
    
    figure;
    x = squeeze(testPoints(1,1,:));
    y = squeeze(testPoints(1,2,:));
    z = squeeze(mlpOutput)';
    tri = delaunay(x,y);
    trisurf(tri,x,y,z);
    hold on
    axis square;
    title('Output surface of MLP EKF');
end

end

