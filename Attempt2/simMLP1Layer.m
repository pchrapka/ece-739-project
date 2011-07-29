function [ output ] = simMLP( config, w, x )
%SIMMLP TODO Update this help
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

% Determine the number of hidden nodes, assuming one hidden layer
numHN1 = config.NumHiddenNodes(1);

% Extract the first set of weights between the input layer and the hidden
% layer
index1 = 1;
index2 = numHN1*numElements;
w01 = reshape(w(index1:index2),numHN1,numElements);

% Extract the biases for the hidden layer
index1 = index2+1;
index2 = index2+numHN1;
b1 = reshape(w(index1:index2),numHN1,1);

% Extract the weights between the hidden layer and the output layer
index1 = index2+1;
index2 = index2+numHN1;
w12 = reshape(w(index1:index2),numHN1,1);

% Extract the final bias
b2 = w(end);

% Calculate the input to HN 1
v1 = w01*x + repmat(b1,1,numSamples);
% Calculate the output of HN 1
y1 = tansig(v1);

% Calculate the final output
output = w12'*y1 + repmat(b2,1,numSamples);
% NOTE final output should be 1 x numSamples

% Adjust the output into a column vector
output = output(:);

end

