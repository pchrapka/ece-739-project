function runSVM( numPoints, boxConstraintValue )
%RUNSVM Summary of this function goes here
%   Detailed explanation goes here

% Record the start time
startTime = datestr(now);

% Generate the training and test data
[points, groupName] = genTrainingData(numPoints);

% Differentiate the groups
groups = ismember(groupName,'red');

% Randomly select training and test sets
% TODO figure out exactly what this does
[train, test] = crossvalind('holdOut',groups);
% Initialize the class performance object with the correct classification
cp = classperf(groups);
% Set optimization options
% Set the max number of iterations to 20000
maxIterations = 20000;
options = optimset('quadprog');
options = optimset(options,'MaxIter',maxIterations);
% Train the SVM
try 
    disp('Training...');
    startTime1 = datestr(now);
    svmStruct = svmtrain(points(train,:),groups(train),...
        'Kernel_Function','rbf','Method','QP',...
        'QuadProg_Opts',options,'BoxConstraint',boxConstraintValue);
    endTime1 = datestr(now);
catch exception
    % Display the exception
    disp(exception);
    % Try again, double the iterations
    maxIterations = maxIterations*10;
    options = optimset(options,'MaxIter',maxIterations);
    try 
        disp('Training Take 2...');
        startTime2 = datestr(now);
        svmStruct = svmtrain(points(train,:),groups(train),...
            'Kernel_Function','rbf','Method','QP',...
            'QuadProg_Opts',options,'BoxConstraint',boxConstraintValue);
        endTime2 = datestr(now);
    catch exception
        % Display the exception
        disp(exception);
        disp('So this does not seem to be working');
    end

end

% Classify the test set
disp('Classifying...');
classes = svmclassify(svmStruct,points(test,:));
% Determine the performance of the classifier
classperf(cp,classes,test);
disp(['Performance: ' num2str(cp.CorrectRate*100) '%']);

% Record the end time
endTime = datestr(now);

dateString = datestr(now,'yyyymmdd_HHMMSS');
fileName = ['svm_simulation_' dateString];
% Save all variables to a file
save(fileName);

%% Plotting rountines
red = [1 0 0];
green = [0 1 0];
saveFolder = 'C:\Users\Phil\Documents\School\Masters\ECE 739 - Neural Networks\Project\Plots';

% Display the training data
group1ColorTrain = ismember(groups(train),1) * red;
group2ColorTrain = ismember(groups(train),0) * green;
colorMatTrain = group1ColorTrain + group2ColorTrain;
% Display classified points on scatter plot
curFig = figure;
scatter(points(train,1),points(train,2),20,colorMatTrain);
axis square;
title('Training data');
saveas(curFig,[saveFolder filesep 'Training Data' '.png']);
saveas(curFig,[saveFolder filesep 'Training Data' '.fig']);
close(curFig);

% Display the test data with correct labels
group1ColorTest = ismember(groups(test),1) * red;
group2ColorTest = ismember(groups(test),0) * green;
colorMatTest = group1ColorTest + group2ColorTest;
% Display classified points on scatter plot
curFig = figure;
scatter(points(test,1),points(test,2),20,colorMatTest);
axis square;
title('Test data with proper labels');
saveas(curFig,[saveFolder filesep 'Test Data' '.png']);
saveas(curFig,[saveFolder filesep 'Test Data' '.fig']);
close(curFig);

% Display classified points on scatter plot
% + is correct
% x is incorrect
testPoints = points(test,:);
correct = (classes == groups(test));
incorrect = (classes ~= groups(test));

group1ColorTest1 = ismember(classes,1) * red;
group2ColorTest1 = ismember(classes,0) * green;
colorMatTest1 = group1ColorTest1 + group2ColorTest1;

curFig = figure;
scatter(testPoints(correct,1),testPoints(correct,2),...
    20,colorMatTest1(correct,:),'Marker','+');
hold on
scatter(testPoints(incorrect,1),testPoints(incorrect,2),...
    40,colorMatTest1(incorrect,:),'Marker','x');
hold off
axis square;
title('Classified data');
legend('Correct','Incorrect');
saveas(curFig,[saveFolder filesep 'Classified Data' '.png']);
saveas(curFig,[saveFolder filesep 'Classified Data' '.fig']);
close(curFig);

% Display classified points with more emphasis on incorrect data points
curFig = figure;
scatter(testPoints(correct,1),testPoints(correct,2),...
    20,colorMatTest1(correct,:),'Marker','.');
hold on
scatter(testPoints(incorrect,1),testPoints(incorrect,2),...
    40,colorMatTest1(incorrect,:),'Marker','x');
hold off
axis square;
title('Classified data');
legend('Correct','Incorrect');
saveas(curFig,[saveFolder filesep 'Classified Data (Large Xs)' '.png']);
saveas(curFig,[saveFolder filesep 'Classified Data (Large Xs)' '.fig']);
close(curFig);

end

