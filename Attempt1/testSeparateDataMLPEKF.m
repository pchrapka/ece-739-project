%% The script tests both genTrainingDataMLPEKF and separateDataMLPEKF
% The output figure should have the shape of the concentric circles and
% the two classes should be different colors
clear all; 
close all;
clc;
epochs = 10;
samples = 200;

[points, groupName] = genTrainingDataMLPEKF(epochs, samples);
[desiredOutput, redPoints, blackPoints] = separateDataMLPEKF(groupName);

figure;
for k=1:epochs
    x = squeeze(points(k,1,:));
    y = squeeze(points(k,2,:));
    z = squeeze(desiredOutput(k,:))';
    %     tri = delaunay(x,y);
    %     trisurf(tri,x,y,z);
    scatter3(x,y,z,10,z);
    hold on;
end
view(2);
axis square;