% Define the required parameters.
f1 = 10;
f2 = 1000;
dur = 1.0;
Ts = 0.0001;

% Define the time vector.
t = 0:Ts:dur;

% Define the required cosine signal. 
x4 = cos(2 * pi * f1 * t) .* cos(2 * pi * f2 * t);

% Plot the signal x4 with values f1 = 10 and f2 = 1000.
figure;
plot(t, x4);
xlabel('Time (in seconds).');
ylabel('Amplitude.');
title('x4(t) with frequency values f1 = 10 Hz and f2 = 1000 Hz.');
grid on;

% Listen to the signal x4.
soundsc(x4, 1/Ts);
pause(2);

% Redefine the signal x4 with new frequency values
% f1 = 5 Hz and f1 = 15 Hz.
f1_vals = [5, 15];

figure;

for i = 1:length(f1_vals)
    varying_f1 = f1_vals(i);
    varying_x4 = cos(2 * pi * varying_f1 * t) .* cos(2 * pi * f2 * t);

    % Plot the signal with varying f1 values. 
    subplot(length(f1_vals), 1, i);
    plot(t, varying_x4);
    xlabel('Time (in seconds).');
    ylabel('Amplitude.');
    title(['x4(t) for f1 = ' num2str(varying_f1) 'Hz and f2 = 1000 Hz.']);
    grid on;

    % Listen to the signal with varying f1 values. 
    soundsc(varying_x4, 1/Ts);
    pause(2);

end


% Now, express the signal as a sum of cosine signals. 
x4_sum = 0.5 * ( cos(2 * pi * (f1 + f2) * t) + cos(2 * pi * (f2 - f1) * t));

% Plot the signal that we defined as a sum of cosine signals. 
figure;
plot(t, x4_sum);
xlabel('Time (in seconds).');
ylabel('Amplitude.');
title('x4(t) expressed as the sum of two cosine signals.')
grid on;

% Listen to the signal that we defined as a sum of cosine signals.
soundsc(x4_sum, 1/Ts);

