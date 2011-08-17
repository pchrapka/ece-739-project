% x = [0.3 0.1 0.4; 0.5 -0.4 -0.1];
% a = 1;
% b = 1;
% ny = 1;
% nh1 = 4; %number of nodes in first hidden layer
% nh2 = 3; %number of nodes in first hidden layer
% numWeights = 31;
% w = linspace(0.01,numWeights*0.01,numWeights);
% 
% [nx ,N]= size (x); %[input dimensionality, number of samples]
% 
% %Extracting weights from theta
% W1=reshape( w(1:nh1*(nx+1)), nh1, []);
% W2=reshape( w(nh1*(nx+1)+(1:nh2*(nh1+1))), nh2 , []);
% W3=reshape( w((nh1*(nx+1)+nh2*(nh1+1)+1):end), ny , []);
% 
% %The NN model
% y = W3(:,1:nh2)*a*tanh(b*(W2(:,1:nh1)*a*tanh(b*(W1(:,1:nx)*x+...
%     W1(:,nx+ones(1,N))))+W2(:,nh1+ones(1,N))))...
%     +W3(:,nh2+ones(1,N));

% eval(['for i=1:' num2str(5) ' disp(i); end'])

%% SVM Example
% Load the data and select features for classification
load fisheriris
data = [meas(:,1), meas(:,2)];
% Extract the Setosa class
groups = ismember(species,'setosa');
% Randomly select training and test sets
[train, test] = crossvalind('holdOut',groups);
cp = classperf(groups);
% Use a linear support vector machine classifier
svmStruct = svmtrain(data(train,:),groups(train),'showplot',true);
% Add a title to the plot
title(sprintf('Kernel Function: %s',...
    func2str(svmStruct.KernelFunction)),...
    'interpreter','none');
% Classify the test set using svmclassify
classes = svmclassify(svmStruct,data(test,:),'showplot',true);
% See how well the classifier performed
classperf(cp,classes,test);
cp.CorrectRate