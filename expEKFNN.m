n = -5:0.1:5;
a = tansig(n);
plot(n,a);

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

% Create the weight vectors for each input node
w1 = ones(hiddenLayerSize,1);
w2 = ones(hiddenLayerSize,1);

x = [0.1; 0.2]; % Sample input vector
% Evaluate NN
% TODO put this into a separate function
% Combine the weight vectors
w = [w1 w2];
% Evalute the input for each neuron input = w*x
% | w11 w21 || x1 |   | w11*x1 + w21*x2 |
% | w12 w22 || x2 | = | w12*x1 + w22*x2 |
% | ... ... |         |       ...       |
% | w1M w2M |         | w1M*x1 + w2M*x2 |
input = w*x;
% Apply the tansig function
out = tansig(input);
% Sum the output 
% NOTE The output layer is linear with a weight of 1
totalOut = sum(out);

