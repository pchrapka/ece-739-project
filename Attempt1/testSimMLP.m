classdef testSimMLP < TestCase
    properties
        x11 = [0.3; 0.5];
        x12 = [0.1; -0.4];
        x13 = [0.4; -0.1];
        x3 = [0.3 0.1 0.4; 0.5 -0.4 -0.1];
    end
    
    methods
        function self = testSimMLP(name)
            self = self@TestCase(name);
        end
        
        function setUp(self)
            % Common constructor/initializer
            %self.fh = figure;
        end
        
        function testDown(self)
            % Common destructor
        end
        
        function testHiddenNodes4Output1(self)
            % Set the network to one output
            numOutputs = 1;
            numHiddenNodes = 4;
            numElements = 2;
            numWeights = numHiddenNodes*(numElements+2) + 1;
            weightIncrement = 0.01;
            w = (weightIncrement:weightIncrement:numWeights*weightIncrement)';
            expectedOut = [0.254371];
            output = simMLP(w,self.x11,numOutputs);
            assertElementsAlmostEqual(output,expectedOut,...
                'absolute',1e-4,0,...
                'One output doesn''t work');
        end
        
        function testHiddenNodes5Output1(self)
            numOutputs = 1;
            numHiddenNodes = 5;
            numElements = 2;
            numWeights = numHiddenNodes*(numElements+2) + 1;
            weightIncrement = 0.01;
            w = (weightIncrement:weightIncrement:numWeights*weightIncrement)';
            expectedOut = [0.3710];
            output = simMLP(w,self.x11,numOutputs);
            assertElementsAlmostEqual(output,expectedOut,...
                'absolute',1e-4,0,...
                'One output doesn''t work');
        end
        
        function testHiddenNodes4Output1MultipleSamples(self)
            % Set the network to one output
            numOutputs = 1;
            numHiddenNodes = 4;
            numElements = 2;
            numWeights = numHiddenNodes*(numElements+2) + 1;
            weightIncrement = 0.01;
            w = (weightIncrement:weightIncrement:numWeights*weightIncrement)';
            expectedOut = [0.2544 0.2175 0.2333];
            output = simMLP(w,self.x3,numOutputs);
            assertElementsAlmostEqual(output,expectedOut,...
                'absolute',1e-4,0,...
                'One output doesn''t work');
        end
    end
end


% % Test 1 output
% numOutputs = 1;
% w = (0.01:0.01:0.17)';
% 
% % Test 2 outputs
% % numOutputs = 2;
% % w = (0.01:0.01:0.22)';
% 
% % Test 3 outputs
% % numOutputs = 3;
% % w = (0.01:0.01:0.27)';
% 
% output = simMLP(w,x3,numOutputs);