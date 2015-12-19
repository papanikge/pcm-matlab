function calc_noise()
%
% Calculate noise scipt
% This is just a wrapper for the first requirement. Accepts/Returns nothing.
%

% Basic runs.
x = sourceA(10000);
[xq, centers] = my_quantizer(x, 4, 0, 4);

% Transform it to the correct format.
new = centers(xq);
new = new';

% Experimental calculation of SQNR (Signal quantization noise ratio).
S = mean(x.^2);
N = mean((new-x).^2);
% We want it in dBs.
R = 10 * log10(S/N);

fprintf('SQNR of 4-bit quantization (Random sample off of the Normal distribution) is %f dBs\n', R);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Basic runs.
x = sourceA(10000);
[xq, centers] = my_quantizer(x, 6, 0, 4);

% Transform it to the correct format.
new = centers(xq);
new = new';

% Experimental calculation of SQNR (Signal quantization noise ratio).
S = mean(x.^2);
N = mean((new-x).^2);
% We want it in dBs.
R = 10 * log10(S/N);

fprintf('SQNR of 6-bit quantization (Random sample off of the Normal distribution) is %f dBs\n', R);
