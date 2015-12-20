function data = sourceB(min_value, max_value)
%
% SourceB function file
% It returns an audio file (hardcoded for now) in the required form.
%

[y, fs, N] = wavread('speech.wav');
% [y, fs] = audioread('speech.wav');

% If you want to play it you need an audio player...
% p = audioplayer(y, fs);
% play(p, 1);

% Normalize between 0 and 1 when appropriate.
if min(y) < min_value || max(y) > max_value
    y = normc(y); % or normr
    % scale to [x, y]
    range = max_value - min_value;
    new = (new * range) + min_value;
    y = new
end

data = y;
