classdef MLPConfig
    %MLPCONFIG Summary of this class goes here
    %   Detailed explanation goes here
    
    properties     
        % Number of hidden layers
        NumHiddenLayers
        % Array of number of hidden nodes per layer
        NumHiddenNodes = [];
        % Function that calculates the output of the network
        SimFunc
    end
    
    properties(Constant)
        % Number of elements (this will be 2)
        NumElements = 2;
        % Number of outputs
        NumOutputs = 1;
    end
    
    properties(Dependent)
        NumWeights
    end
    
    methods
        function obj = MLPConfig()
            % Constructor
        end
        
        function value = get.NumWeights(obj)
            % Calculate the number of weights in the input stage
            value = obj.NumElements*obj.NumHiddenNodes(1)...
                + obj.NumHiddenNodes(1);
            
            % If we have more layers, we need to figure out how many
            % weights there are between layers
            if(obj.NumHiddenLayers > 1)
                for i=1:obj.NumHiddenLayers-1
                    % Add the number of interconnections and the biases
                    value = value...
                        + obj.NumHiddenNodes(i)*obj.NumHiddenNodes(i+1)...
                        + obj.NumHiddenNodes(i+1);
                end
            end
            
            % Figure out the output layer
            value = value + obj.NumHiddenNodes(end) + 1;
        end
    end
    
end

