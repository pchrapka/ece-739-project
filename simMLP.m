function output = simMLP( w,x,numOutputs )
%SIMMLP TODO Update this help
%   Assumes one hidden layer and includes weights between the hidden layer
%   and the output layer as well as biases at each node.

% Evaluates the neural network using the weights and provided input
%   OUT = SIMNN(W,X)
%   Evalutes the input for each neuron input = w*x
%       | w11 w21 || x1 |   | w11*x1 + w21*x2 |
%       | w12 w22 || x2 | = | w12*x1 + w22*x2 |
%       | ... ... |         |       ...       |
%       | w1M w2M |         | w1M*x1 + w2M*x2 |
%   Then it applies the tansig function to each input and sums the results
%   which is returned as OUT.

% % Evalute the input to each neuron
% input = w*x;
% % Apply the tansig function
% out = tansig(input);
% % Sum the output 
% % NOTE The output layer is linear with a weight of 1
% output = sum(out);

% Determine the size of x - It can contain more than one sample
[numElements, numSamples] = size(x);
% Determine the number of elements in the weight vector
numWeights = numel(w);
% Determine the number of hidden nodes, assuming on hidden layer
numHiddenNodes = (numWeights-numOutputs)/(numElements + numOutputs + 1);
% Extract the first set of weights between the input layer and the hidden
% layer
w1 = reshape(w(1:numHiddenNodes*numElements),numHiddenNodes,[]);
% Extract the set of biases for each hidden node
startIndex = numHiddenNodes*numElements+1;
b1 = reshape(w(startIndex:startIndex+numHiddenNodes-1),numHiddenNodes,1);
% Extract the second set of weights between the hidden layer and the output
% layer
startIndex = startIndex + numHiddenNodes;
w2 = reshape(w(startIndex:startIndex+numHiddenNodes*numOutputs-1),...
    numHiddenNodes,numOutputs);
% Extract the bias at the output node
startIndex = startIndex + numHiddenNodes*numOutputs;
b2 = reshape(w(startIndex:end),numOutputs,1);

% Calculate the input to each neuron and replicate b1 to match matrix sizes
% NOTE Size should be numHiddenNodes x numSamples
inputToNeuron = w1*x + repmat(b1,1,numSamples);
% Calculate the output of each neuron for each sample
outputFromNeuron = tansig(inputToNeuron);
% Multiply the output by the second set of weights and add the final bias
output = w2'*outputFromNeuron + repmat(b2,1,numSamples);
% NOTE final output should be numOutputs x numSamples

end

