% n = -5:0.1:5;
% a = tansig(n);
% plot(n,a);

%% Initialize variables
% Number of hidden layers, only 1 as required by Haykin
hiddenLayer = 1;
% Hidden layer size, ie. number of neurons in the hidden layer
% Leave the hidden layer size as two for now, write the code so that it can
% easily accomodate more
hiddenLayerSize = 2;
% Number of inputs, our vector consists of the x and y coordinates
numInputs = 2;
% Number of outputs, since we are using the tanh function we want the
% output to be between -0.7 and 0.7 with +ve being one class and -ve being
% the other
numOutputs = 1;

% Create the weight vector
% One weight for each input to hidden layer connection
w = ones(hiddenLayerSize,numInputs);
% w1 = w(:,1);
% w2 = w(:,2);

x = [0.1; 0.2]; % Sample input vector

totalOut = simMLP(w,x);

