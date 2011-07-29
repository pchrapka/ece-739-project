function [ w,P,mlpOutput ] = trainEKF( config, w,P,inputData,desiredOutput,Q,R )
%TRAINEKF FIXME Summary of this function goes here
%   Detailed explanation goes here
%   inData should be number of elements x number of samples
%   desiredOutput should be number of outputs x number of samples

% f is a function that updates the weights of the MLP, since the process is
% rather stochastic we can simply make the noise (represented by the
% covariance Q) alter the weight values
f = @(v)v;

% h is a function that represents the measurement process, this would be
% the MLP network itself as a function of the current estimate of the
% weight vector
h = @(v)config.SimFunc(config, v, inputData);

% Other parameters
% w is the weight vector or the state of the problem
% P is the covariance matrix of the state (typically initialized to I)
% desiredOutput is the desired output of the MLP
% Q and R are covariance matrices of both noise processes

% Use the Extended Kalman Filter to determine the weight vector that best
% fits the current test data
[w,P]=ekf(f,w,P,h,desiredOutput(:),Q,R);
% Get the output of the MLP network based on the current weight vector
mlpOutput = h(w);

end

