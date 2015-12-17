function [xq, centers] = my_quantizer(x, N, min_value, max_value);
%
% MY_QUANTIZER function file
% Implements a uniform quantization algorithm.
% After the run the quantized signal can be retrieved with: centers(xq(i)),
% since centers has the correct values and the xq the levels.
%

%   Copyright 2015 George 'papanikge' Papanikolaou
%   $Revision: 0.1 $  $Date: 2015/12/15 17:39:11 $

s = size(x);

% Basic checks.
if s(2) ~= 1
    error('The signal (x) must be in column form.');
end

s = s(1);

% Change the dynamic range and eliminate outliers.
if min(x) < min_value
    for i=1:s
        if x(i) < min_value
            x(i) = min_value;
        end
    end
end
if max(x) > max_value
    for i=1:s
        if x(i) > max_value
            x(i) = max_value;
        end
    end
end

% Calculate the 'step'.
range = max_value - min_value;
levels = 2 ^ N;
step = range/levels;

% Calculate centers.
centers = [];
centers(1) = max_value - step/2;
for i=2:levels
    centers(i) = centers(i-1) - step;
end

xq = [];
% We are not going to calculate the quantization zones at all. We are going to
% use the 'min' function here for assigning data points to centers. It returns
% the index of the closest value of our value this way.
for i=1:s
    [distance index] = min(abs(centers - x(i)));
    xq(i) = index;
end
