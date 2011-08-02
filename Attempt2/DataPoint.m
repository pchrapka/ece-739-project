classdef DataPoint
    %DATAPOINT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Point = zeros(2,1);
        GroupName = '';
        DesiredOutput = 0;
    end
    
    properties(Dependent)
        x
        y
    end
    
    methods
        function obj = DataPoint()
        end
        
        function value = get.x(obj)
            value = obj.Point(1,1);
        end
        
        function value = get.y(obj)
            value = obj.Point(2,1);
        end
    end
    
end

