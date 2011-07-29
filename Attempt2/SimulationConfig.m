classdef SimulationConfig
    %SIMULATIONCONFIG Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        % Number of epochs to run the simulation
        NumEpochs = 0;
        % Number of data samples per epoch
        NumPointsPerEpoch = 0;
        % Desired output value (Red is +ve, Black is -ve)
        DesiredOutputValue = 0;
        
        % Initial value for P
        p = 0;
        % Value for Q
        q = 0;
        DoAnnealing = false;
        % Value for R
        r = 0;
        
        % Array of performance values for each epoch
        Performance
        % Number of test points used
        NumTestPoints = 200;
        % Flag for plotting performance during the running simulation
        PlotPerf = false;
        % Flag for plotting the classified data
        PlotClassifiedData = false;
        PlotClassifiedDataFigHandle;
        
        % Algorithm output
        FinalW = [];
        FinalP = [];
        Exception = [];
        
        % MLP Configuration
        MLPConfigObj
    end
    
    methods
        function obj = SimulationConfig()
        end
        
        function obj = Init(obj)
            % Allocate memory before we use it
            obj.Performance = zeros(obj.NumEpochs,1);
        end
    end
    
end

