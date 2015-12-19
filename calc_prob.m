function calc_prob()
%
% Calculate probability of data point being outside of the dynamic zone.
% This is just a wrapper for the first requirement. Accepts/Returns nothing.
%

% Basic runs.
x = sourceA(10000);

% Let's compute it.
counter = 0;
for i=1:10000
    % `min` and `max` values are hard-coded.
    if x(i) < 0 || x(i) > 4
        counter = counter + 1;
    end
end

prob = counter/100;

fprintf('The probability of the data (from Source A) being outside of the dynamic zone (0,4) is %1.1f%%.\n', prob);
