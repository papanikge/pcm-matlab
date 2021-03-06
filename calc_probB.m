function calc_probB()
%
% Calculate probability of data within the zones.
% This is just a wrapper for the third requirement. Accepts/Returns nothing.
%

x = sourceB(-1, 1);

% Uniform
for n=2:2:6
    [xq, centers] = my_quantizer(x, n, -1, 1);
    v = tabulate(xq);
    fprintf('Probabilities (uniform quantizer) with %d-bit are: [second column is percentage]\n', n);
    % Freaking MATLAB cannot hold two different data types in a matrix so
    % we're gonna print the zone numbers as floats too...
    prob = v(:,3);
    [v(:,1) prob] 
    prob = prob ./ 100;
    entropy = - sum(prob .* log2(prob))
end

% Lloyd-Max
for n=2:2:6
    [xq, centers, D] = lloyd_max(x, n, -1, 1);
    v = tabulate(xq);
    fprintf('Probabilities (Lloyd-max) with %d-bit are: [second column is percentage]\n', n);
    prob = v(:,3);
    [v(:,1) prob] 
    prob = prob ./ 100;
    entropy = - sum(prob .* log2(prob))
end
