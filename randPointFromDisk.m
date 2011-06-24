function [x,y] = randPointFromDisk( diameter )
%RANDPOINTFROMDISK Generates a random point from a disk with uniform
%distribution
%   [X,Y] = RANDPOINTFROMDISK(DIAMETER) returns the x and y coordinates of
%   a random point uniformly distributed within a disk of diameter DIAMETER

d = 1;
r = rand(1)*d;
theta = rand(1)*2*pi;

x = sqrt(r)*cos(theta);
y = sqrt(r)*sin(theta);

end

