function [ output ] = simMLP2Layer( config, w, x )
%SIMMLP2LAYER
%   Assumes one hidden layer and includes weights between the hidden layer
%   and the output layer as well as biases at each node.
%   Should work with more than one output and multiple samples in x
%   X should be a number of elements x number of samples matrix

% Determine the size of x - It can contain more than one sample
[numElements, numSamples] = size(x);
% Make sure that x is the proper size
if(numElements ~= config.NumElements)
    error('Invalid size of x');
end

% Determine the number of elements in the weight vector
% numWeights = config.NumWeights;
numHN1 = config.NumHiddenNodes(1);
numHN2 = config.NumHiddenNodes(2);

% Extract the first set of weights between the input layer and the 1st
% hidden layer
index1 = 1;
index2 = numHN1*numElements;
w01 = reshape(w(index1:index2),numHN1,numElements);

% Extract the biases for the first hidden layer
index1 = index2+1;
index2 = index2+numHN1;
b1 = reshape(w(index1:index2),numHN1,1);

% Extract the weights between the 2 hidden layers
index1 = index2+1;
index2 = index2+numHN1*numHN2;
w12 = reshape(w(index1:index2),numHN2,numHN1);

% Extract the biases for the second hidden layer
index1 = index2+1;
index2 = index2+numHN2;
b2 = reshape(w(index1:index2),numHN2,1);

% Extract the weights between the second hidden layer and the output layer
index1 = index2+1;
index2 = index2+numHN2;
w23 = reshape(w(index1:index2),numHN2,1);

% Extract the final bias
b3 = w(end);

% Calculate the input to HN 1
v1 = w01*x + repmat(b1,1,numSamples);
% Calculate the output of HN 1
y1 = tansig(v1);

% Calculate the input to HN 2
v2 = w12*y1 + repmat(b2,1,numSamples);
% Calculate the output of HN 2
y2 = tansig(v2);

% Calculate the final output
output = w23'*y2 + repmat(b3,1,numSamples);
% NOTE final output should be 1 x numSamples

% Adjust the output into a column vector
output = output(:);

end



