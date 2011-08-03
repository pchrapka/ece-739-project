classdef SVMSimulationConfig
    %SVMSIMULATIONCONFIG Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        % Number of epochs to run the simulation
        NumEpochs = 100;
        % Number of data samples per epoch
        NumPointsPerEpoch = 200;
        % Desired output value (Red is +ve, Black is -ve)
        DesiredOutputValue = 1;
        
        % Box constraint value
        BoxConstraint = 500;
        
        % Number of test points used
        NumTestPoints = 200;
        
        % Exception from running the simulation
        Exception = [];
        % Array of performance values for each epoch
        Performance
        
        % Start time
        StartTime
        % End time
        EndTime
        % Trained SVMStruct
        SVMStruct
        
        % Flag for plotting performance in getPerformanceSVM
        PlotPerformance = false;
    end
    
    methods
        function obj = SVMSimulationConfig()
        end
        
        function obj = Init(obj)
            % Allocate memory before we use it
            obj.Performance = zeros(obj.NumEpochs,1);
        end
    end
    
end

