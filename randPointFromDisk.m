function [x,y] = randPointFromDisk( diameter )
%RANDPOINTFROMDISK Summary of this function goes here
%   Detailed explanation goes here

d = 1;
r = rand(1)*d;
theta = rand(1)*2*pi;

x = sqrt(r)*cos(theta);
y = sqrt(r)*sin(theta);

end

