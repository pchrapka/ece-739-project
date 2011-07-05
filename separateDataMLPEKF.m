function [ desiredOutput, redPoints, blackPoints ] = separateDataMLPEKF( groupName )
%SEPARATEDATAMLPEKF Summary of this function goes here
%   Detailed explanation goes here

% Differentiate the two groups
redPoints = ismember(groupName,'red');
blackPoints = ismember(groupName,'black');

% Generate the desired output
% Make red = 0.7 and black = -0.7
desiredOutput = redPoints*0.7 + blackPoints*-0.7;

end

