function data = sourceA(M)
%
% SourceA function file
% Generates the required data that we need for the quantizer benchmarks.
%

temp = (randn(M,1) + j*randn(M,1)) / sqrt(2);
data = abs(temp) .^ 2;
