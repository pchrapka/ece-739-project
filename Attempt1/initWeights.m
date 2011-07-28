function [ weights ] = initWeights( numWeights )
%INITWEIGHTS Returns a weight vector
%   W = INITWEIGHTS(NUMWEIGHTS) returns a weight vector of length
%   NUMWEIGHTS. The first time a new length is specified a random vector is
%   generated. For every subsequent call the same random vector is
%   returned.
%
%   The reasoning: The performance results are inconsistent if the weight
%   vector is initialized differently for every iteration. By maintaining
%   the same initial weight vector a more adequate comparison can be made.
%   Another approach would be to average simulations with different initial
%   weight vectors. Although this is probably the proper approach, it would
%   take more time.

% Generate the file name
fileName = ['Weight Files' filesep 'weightvector' num2str(numWeights) '.mat'];

if(exist(fileName,'file') == 2)
    % If a file already exists load the file
    fileData = load(fileName);
    weights = fileData.weights;
else
    % A new file needs to be generated
    weights = randn(numWeights,1);
    % Save the variable in a file
    save(fileName);
end

end

