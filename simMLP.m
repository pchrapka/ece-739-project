function output = simMLP( w,x )
%SIMNN Evaluates the neural network using the weights and provided input
%   OUT = SIMNN(W,X)
%   Evalutes the input for each neuron input = w*x
%       | w11 w21 || x1 |   | w11*x1 + w21*x2 |
%       | w12 w22 || x2 | = | w12*x1 + w22*x2 |
%       | ... ... |         |       ...       |
%       | w1M w2M |         | w1M*x1 + w2M*x2 |
%   Then it applies the tansig function to each input and sums the results
%   which is returned as OUT.

% Evalute the input to each neuron
input = w*x;
% Apply the tansig function
out = tansig(input);
% Sum the output 
% NOTE The output layer is linear with a weight of 1
output = sum(out);

end

