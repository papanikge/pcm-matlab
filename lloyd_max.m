function [xq, centers, D] = lloyd_max(x, N, min_value, max_value);
%
% LLOYD_MAX function file
% Implements the Lloyd-Max non-uniform quantization algorithm.
%

%   Copyright 2015 George 'papanikge' Papanikolaou
%   $Revision: 0.1 $  $Date: 2015/12/16 18:16:09 $

s = size(x);
s = s(1);

% We'll start the algorithm with the centers of the uniform quantizer,
% so we're using that in order to do the basic checks and get the centers.
[temp, centers] = my_quantizer(x, N, min_value, max_value);

% We need to change the 'dynamic range' again. We need a finite signal.
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

% In the uniform quantizer we had the centers upside-down, because it led to
% more readable code. Now we need them normal-side-up.
centers = flip(centers);
% We are also gonna need the min and max values inside.
centers = [min_value centers max_value];

% D is the Distortion log.
D = [0 1];

% Main algorithm loop.
k = 2;
while abs(D(k) - D(k-1)) >= eps
    xq = [];
    total = 0;
    % ...and more required matrices.
    counted   = zeros(length(centers));
    cond_mean = zeros(length(centers));

    % Calculating the quantization zones.
    T = [];
    T(1) = min_value;
    for i=2:(length(centers)-2)
        T(i) = (centers(i) + centers(i+1))/2;
    end
    T(i+1) = max_value;

    % Iterating over the signal for the actual job.
    for i=1:s
        % Iterating over the zones to find the correct one.
        for j=1:(length(T)-1)
            if T(j) < x(i) && x(i) <= T(j+1)
                % The result.
                xq(i) = j;
                % We need to calculate the mean distance from the center.
                total = total + abs(centers(j+1) - x(i));
                % We also need to find the conditional mean for the next zones.
                cond_mean(j) = cond_mean(j) + x(i);
                counted(j)   = counted(j) + 1;
            end
        end
        % Edge case of a data point directly on the min bound.
        if x(i) == T(1)
            % Almost the same stuff as above.
            xq(i) = 1;
            total = total + abs(centers(2) - x(i));
            cond_mean(1) = cond_mean(1) + x(i);
            counted(1)   = counted(1) + 1;
        end
    end
    avg_distortion = total/s;

    % Finishing touches.
    D = [D avg_distortion];
    k = k + 1;

    % Finding the new centers, since that's what we need to get the zones.
    for j=2:(length(centers)-1)
        if counted(j-1) ~= 0
            centers(j) = cond_mean(j-1)/counted(j-1);
        end
    end
end

% Erasing the required-until-now extra values in the Distortion log vector.
% Now D(i) is the mean distortion of the i-th iteration.
D(1) = [];
D(2) = [];

% Fix the `centers` vector too.
centers(1) = [];
centers(length(centers)) = [];

% We have it transposed.
xq = xq';

fprintf('Successfully exited after %d iterations.\n', k-2);
