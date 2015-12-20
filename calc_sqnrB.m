function calc_sqnrB()
%
% Calculate noise scipt
% This is just a wrapper for the testing of the second source according to
% the second requirement. Accepts/Returns nothing. Makes no assumptions.
%

fprintf('==> epsilon value is the machine eps: %d\n', eps);

for n=2:2:6
    % Basic runs.
    x = sourceB(-1, 1);
    [xq, centers, D] = lloyd_max(x, n, -1, 1);
    new = centers(xq);
    new = new';
    S = mean(x.^2);
    N = mean((new-x).^2);
    % We want it in dBs.
    R = 10 * log10(S/N);

    fprintf('SQNR of %d-bit quantization (using Lloyd-Max) is %f dBs\n', n, R);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fprintf('==> Running uniform quantizer\n');

for n=2:2:6
    % Basic runs.
    x = sourceB(-1, 1);
    [xq, centers] = my_quantizer(x, n, -1, 1);
    new = centers(xq);
    new = new';
    S = mean(x.^2);
    N = mean((new-x).^2);
    % We want it in dBs.
    R = 10 * log10(S/N);

    fprintf('SQNR of %d-bit quantization (using uniform quantizer) is %f dBs\n', n, R);
end
