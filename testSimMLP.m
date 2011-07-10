x = [0.1 0.1 0.4; 0.7 -0.4 -0.1];

% Test 1 output
numOutputs = 1;
w = (0.01:0.01:0.17)';

% Test 2 outputs
% numOutputs = 2;
% w = (0.01:0.01:0.22)';

% Test 3 outputs
% numOutputs = 3;
% w = (0.01:0.01:0.27)';

output = simMLP(w,x,numOutputs);