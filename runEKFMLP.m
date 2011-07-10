function [ avgPerf ] = runEKFMLP( epochs, samples, numHiddenNodes, eta, epsilon, q, output )
%RUNEKFMLP Summary of this function goes here
%   Detailed explanation goes here
%   q - typically ranges from 0 to 0.1 can be annealed from large number to
%   a number on the order of 10e-6
%   epsilon - approx. 0.01 (can range from 0.001 to 0.01)
%   eta - the learning rate parameter 0.001 to 1

% Output flags
if(output)
    plotTestEpoch = true;
    plotPerformance = true;
    saveVars = true;
else
    plotTestEpoch = false;
    plotPerformance = false;
    saveVars = false;
end

if(mod(epochs,2) ~= 0)
    error('Make the number epochs even');
end
% Record the starting time
startTime = datestr(now);

numOutputs = 1;
% numHiddenNodes = 30;
numElements = 2;

% Generate the training data
[points, groupName] = genTrainingDataMLPEKF(epochs, samples);
% Get more information about the training data
[desiredOutput, redPoints, blackPoints] = separateDataMLPEKF(groupName);

% Create w, P, W, R, desiredOutput
% NOTE numWeights assumes one output
numWeights = numHiddenNodes*(numElements+2) + 1;
w = randn(numWeights,1);
P = (1/epsilon)*eye(numWeights);
Q = q*eye(numWeights);
R = (1/eta)*eye(samples);

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
    
    % TEMP Debug
    figure;
    title(['Training output: Epoch ' num2str(k)]);
    x = squeeze(points(k,1,:));
    y = squeeze(points(k,2,:));
    z = squeeze(mlpOutput(k,:))';
%     scatter3(x,y,z,10,z);
    tri = delaunay(x,y);
    trisurf(tri,x,y,z);
    hold on
    axis square;
%     view(2);
    
end

red = [1 0 0];
green = [0 1 0];
saveFolder = 'C:\Users\Phil\Documents\School\Masters\ECE 739 - Neural Networks\Project\EKF MLP';

% Evaluate the performance of the MLP
startIndex = trainEpochs+1;
if(plotTestEpoch)
    testDataPlot = figure;
    tempDebug = figure;
end
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
    
    if(plotTestEpoch)
        % Plot each epoch
        curFig = figure;
        scatter(testPoints(1,correct),testPoints(2,correct),...
            20,colorMat(correct,:),'Marker','+');
        hold on
        scatter(testPoints(1,incorrect),testPoints(2,incorrect),...
            40,colorMat(incorrect,:),'Marker','x');
        hold off
        axis square;
        title('Classified data');
        legend('Correct','Incorrect');
        saveas(curFig,[saveFolder filesep 'Classified Data ' num2str(k) '.png']);
        saveas(curFig,[saveFolder filesep 'Classified Data ' num2str(k) '.fig']);
        close(curFig);
        
        % Plot each epoch on the common plot
        % Make the common figure current
        figure(testDataPlot);
        scatter(testPoints(1,correct),testPoints(2,correct),...
            20,colorMat(correct,:),'Marker','+');
        hold on
        scatter(testPoints(1,incorrect),testPoints(2,incorrect),...
            40,colorMat(incorrect,:),'Marker','x');
        hold on
        axis square;
        
        % TEMP Debug
        figure(tempDebug);
        x = squeeze(points(k,1,:));
        y = squeeze(points(k,2,:));
        z = squeeze(mlpOutput(k,:))';
        scatter3(x,y,z,10,z);
        hold on
        axis square;
        view(2);
    end
end
if(plotTestEpoch)
    % Finish up a few things with the common plot
    figure(testDataPlot);
    title([{'Classified data'},{'All Test Data'}]);
    legend('Correct','Incorrect');
    saveas(testDataPlot,[saveFolder filesep 'All Classified Data' '.png']);
    saveas(testDataPlot,[saveFolder filesep 'All Classified Data' '.fig']);
    close(testDataPlot);
end
endTime = datestr(now);

if(plotPerformance)
    curFig = figure;
    plot(perf*100);
    title('Performance');
    ylabel('Percent correct');
    xlabel('Testing epoch');
    saveas(curFig,[saveFolder filesep 'Performance' '.png']);
    saveas(curFig,[saveFolder filesep 'Performance' '.fig']);
    close(curFig);
end

avgPerf = sum(perf)/(epochs/2);

if(saveVars)
    dateString = datestr(now,'yyyymmdd_HHMMSS');
    fileName = ['mlpekf_simulation' dateString '_perf' int2str(avgPerf*100)];
    % Save all variables to a file
    save(fileName);
end


end


