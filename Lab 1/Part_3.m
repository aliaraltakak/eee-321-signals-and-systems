% Define the required parametes.
f0 = 440;
a_vals = [2, 1, 3];
dur = 3.0;
Ts = 0.0001;

% Define the time vector. 
t = 0:Ts:dur;

% Define the signal and plot them with varying
% values.
for i = 1:length(a_vals)
    a = a_vals(i);
    x3 = exp(-(a^2 + 2) * t) .* cos(2 * pi * f0 * t);

    figure;
    plot(t, x3);
    xlabel('Time (in seconds).');
    ylabel('Amplitude.');
    title(['x(t) with an a value of ' num2str(a)]);
    grid on;
    timer()
    % Listen to the sounds of the signals.
    soundsc(x3, 1/Ts);
    pause(2);
end
