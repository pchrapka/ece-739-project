function [ point, groupName ] = genTrainingData( numPoints )
%GENTRAININGDATA Summary of this function goes here
%   Detailed explanation goes here

r3 = 0.2;
r2 = 0.5;
% Largest diameter
r1 = 0.8;

% Preallocate memory
point = zeros(numPoints,2);
% groupName = zeros(numPoints,3);
% groupName = zeros(numPoints,1);
groupName = cell(numPoints,1);
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
            %groupName(i) = 1;
            %groupName(i,:) = [1 0 0];%'red';
            groupName{i} = 'red';
        elseif(r >= r3)
            % Middle ring top
            %group(i) = 0;
            %group(i,:) = [0 1 0];%'black';
            groupName{i} = 'black';
        else
            % Inner ring top
            %groupName(i) = 1;
            %groupName(i,:) = [1 0 0];%'red';
            groupName{i} = 'red';
        end
    else
        if(r >= r2)
            % Outermost ring bottom
            %groupName(i) = 0;
            %groupName(i,:) = [0 1 0];%'black';
            groupName{i} = 'black';
        elseif(r >= r3)
            % Middle ring bottom
            %groupName(i) = 1;
            %groupName(i,:) = [1 0 0];%'red';
            groupName{i} = 'red';
        else
            % Inner ring bottom
            %groupName(i) = 0;
            %groupName(i,:) = [0 1 0];%'black';
            groupName{i} = 'black';
        end
    end
        
    point(i,1) = x;
    point(i,2) = y;
end

end

