function [ point,groupName,desiredOutput ] = genTrainingData( numPoints, outValue )
%GENTRAININGDATA Summary of this function goes here
%   Detailed explanation goes here

r3 = 0.2;
r2 = 0.5;
% Largest diameter
r1 = 0.8;

% Preallocate memory
point = zeros(2,numPoints);
groupName = cell(numPoints,1);
desiredOutput = zeros(1,numPoints);

numPoints2 = numPoints/2;
numRedPoints = 0;
numBlackPoints = 0;
i = 1;

% Generate random data
while((numRedPoints < numPoints2) || (numBlackPoints < numPoints2))
    %% Generate random points within the disk
    [x, y] = randPointFromDisk(r1);
    
    %% Classify where the points lie
    % Check if the point lies above or below the x axis
    r = sqrt(x^2+y^2);
    if(y >= 0)
        if(r >= r2)
            % Outermost ring top
            if(numRedPoints < numPoints2)
                groupName{i} = 'red';
                desiredOutput(i) = abs(outValue);
                numRedPoints = numRedPoints + 1;
                point(1,i) = x;
                point(2,i) = y;
                i = i+1;
            end
        elseif(r >= r3)
            % Middle ring top
            if(numBlackPoints < numPoints2)
                groupName{i} = 'black';
                desiredOutput(i) = -1*abs(outValue);
                numBlackPoints = numBlackPoints + 1;
                point(1,i) = x;
                point(2,i) = y;
                i = i+1;
            end
        else
            % Inner ring top
            if(numRedPoints < numPoints2)
                groupName{i} = 'red';
                desiredOutput(i) = abs(outValue);
                numRedPoints = numRedPoints + 1;
                point(1,i) = x;
                point(2,i) = y;
                i = i+1;
            end
        end
    else
        if(r >= r2)
            % Outermost ring bottom
            if(numBlackPoints < numPoints2)
                groupName{i} = 'black';
                desiredOutput(i) = -1*abs(outValue);
                numBlackPoints = numBlackPoints + 1;
                point(1,i) = x;
                point(2,i) = y;
                i = i+1;
            end
        elseif(r >= r3)
            % Middle ring bottom
            if(numRedPoints < numPoints2)
                groupName{i} = 'red';
                desiredOutput(i) = abs(outValue);
                numRedPoints = numRedPoints + 1;
                point(1,i) = x;
                point(2,i) = y;
                i = i+1;
            end
        else
            % Inner ring bottom
            if(numBlackPoints < numPoints2)
                groupName{i} = 'black';
                desiredOutput(i) = -1*abs(outValue);
                numBlackPoints = numBlackPoints + 1;
                point(1,i) = x;
                point(2,i) = y;
                i = i+1;
            end
        end
    end
end

end

