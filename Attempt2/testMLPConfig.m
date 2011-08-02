classdef testMLPConfig < TestCase
    %TESTMLPCONFIG Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Instance
        x11 = [0.3; 0.5];
        x12 = [0.1; -0.4];
        x13 = [0.4; -0.1];
        x3 = [0.3 0.1 0.4; 0.5 -0.4 -0.1];
    end
    
    methods
        function self = testMLPConfig(name)
            self = self@TestCase(name);
        end
        
        function setUp(self)
            % Common constructor/initializer
            self.Instance = MLPConfig();
        end
        
        function tearDown(self)
            % Common destructor
        end
        
        function testNumWeights1Layer(self)
            self.Instance.NumHiddenLayers = 1;
            self.Instance.NumHiddenNodes = 4;
            assertEqual(self.Instance.NumWeights,17,...
                'Weight calculation is off');
            self.Instance.NumHiddenNodes = 5;
            assertEqual(self.Instance.NumWeights,21,...
                'Weight calculation is off');
        end
        
        function testNumWeights2Layer(self)
            self.Instance.NumHiddenLayers = 2;
            self.Instance.NumHiddenNodes = [4 3];
            assertEqual(self.Instance.NumWeights,31,...
                'Weight calculation is off');
            self.Instance.NumHiddenNodes = [5 2];
            assertEqual(self.Instance.NumWeights,30,...
                'Weight calculation is off');
        end
        
        function testSimMLP1Layer(self)
            self.Instance.NumHiddenLayers = 1;
            self.Instance.NumHiddenNodes = [4];
            self.Instance.SimFunc = @simMLP1Layer;
            
            % Generate a weight vector
            numWeights = self.Instance.NumWeights;
            weights = linspace(0.01,numWeights*0.01,numWeights);
            
            output = self.Instance.SimFunc(...
                self.Instance, weights, self.x11);
            expectedOutput = 0.2544;
            assertElementsAlmostEqual(output, expectedOutput,...
                'absolute',1e-4,0,...
                'Output does not match');
            
            output = self.Instance.SimFunc(...
                self.Instance, weights, self.x12);
            expectedOutput = 0.2175;
            assertElementsAlmostEqual(output, expectedOutput,...
                'absolute',1e-4,0,...
                'Output does not match');
            
            output = self.Instance.SimFunc(...
                self.Instance, weights, self.x13);
            expectedOutput = 0.2333;
            assertElementsAlmostEqual(output, expectedOutput,...
                'absolute',1e-4,0,...
                'Output does not match');
            
            output = self.Instance.SimFunc(...
                self.Instance, weights, self.x3);
            expectedOutput = [0.2544;0.2175;0.2333];
            assertElementsAlmostEqual(output, expectedOutput,...
                'absolute',1e-4,0,...
                'Output does not match');
        end
        
        function testSimMLP2Layer(self)
            self.Instance.NumHiddenLayers = 2;
            self.Instance.NumHiddenNodes = [4 3];
            self.Instance.SimFunc = @simMLP2Layer;
            
            % Generate a weight vector
            numWeights = self.Instance.NumWeights;
            weights = linspace(0.01,numWeights*0.01,numWeights);
            
            output = self.Instance.SimFunc(...
                self.Instance, weights, self.x11);
            expectedOutput = 0.6176;
            assertElementsAlmostEqual(output, expectedOutput,...
                'absolute',1e-4,0,...
                'Output does not match');
            
            output = self.Instance.SimFunc(...
                self.Instance, weights, self.x12);
            expectedOutput = 0.5804;
            assertElementsAlmostEqual(output, expectedOutput,...
                'absolute',1e-4,0,...
                'Output does not match');
            
            output = self.Instance.SimFunc(...
                self.Instance, weights, self.x13);
            expectedOutput = 0.5966;
            assertElementsAlmostEqual(output, expectedOutput,...
                'absolute',1e-4,0,...
                'Output does not match');
            
            output = self.Instance.SimFunc(...
                self.Instance, weights, self.x3);
            expectedOutput = [0.6176;0.5804;0.5966];
            assertElementsAlmostEqual(output, expectedOutput,...
                'absolute',1e-4,0,...
                'Output does not match');
        end
    end
    
end

