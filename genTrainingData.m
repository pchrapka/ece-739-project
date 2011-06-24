function [ training, group ] = genTrainingData( numPoints )
%GENTRAININGDATA Summary of this function goes here
%   Detailed explanation goes here

r3 = 0.2;
r2 = 0.5;
% Largest diameter
r1 = 1;

% Preallocate memory
point = zeros(numPoints,2);
group = zeros(numPoints,3);
for i=1:numPoints
    %% Generate random points within the disk
    [x, y] = randPointFromDisk(r1);
    
    %% Classify where the points lie
    % FIXME fix the rgb/group labels
    % Check if the point lies above or below the x axis
    r = sqrt(x^2+y^2);
    if(y >= 0)
        if(r >= r2)
            % Outermost ring top
            group(i,:) = [1 0 0];%'red';
        elseif(r >= r3)
            % Middle ring top
            group(i,:) = [0 1 0];%'black';
        else
            % Inner ring top
            group(i,:) = [1 0 0];%'red';
        end
    else
        if(r >= r2)
            % Outermost ring bottom
            group(i,:) = [0 1 0];%'black';
        elseif(r >= r3)
            % Middle ring bottom
            group(i,:) = [1 0 0];%'red';
        else
            % Inner ring bottom
            group(i,:) = [0 1 0];%'black';
        end
    end
        
    point(i,1) = x;
    point(i,2) = y;
end

training = point;


end

