function [ mlp ] = createMLP( input_args )
%CREATEMLP Summary of this function goes here
%   Detailed explanation goes here

% numInputs = 2;
% numLayers = 2;
% Set biases
% We don't need any biases so it can stay as 0
% biasConnect = zeros(numLayers,1);
% 
% Set inputs
% inputConnect = zeros(numLayers,numInputs);
% We want all inputs connected to the first layer
% inputConnect(1,:) = 1;
% 
% Set layer connections
% layerConnect = zeros(numLayers,numLayers);
% We want layer 2 after layer 1
% layerConnect(2,1) = 1;
% if(numLayers > 2)
%     Little sanity check
%     warning('Add some more code here');
% end
% 
% Set output connections
% outputConnect = zeros(1,numLayers);
% We want output from the last layer
% outputConnect(1,numLayers) = 1;
% 
% mlp = network(numInputs,numLayers,biasConnect,...
%     inputConnect,layerConnect,outputConnect);
% 
% transfer tansig
% mlp.layers{:}.transferFcn = 'tansig';

% Try creating a pattern recognition network
mlp2 = newpr([-0.8; 0.8], [-0.7 0.7], 2);
end

