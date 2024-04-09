% Define the required signal parameters. 
f0 = 587;
Ts = 0.0001;
dur = 0.01;
phi_vals = [0, pi/4, pi/2, 3*pi/4, pi];

% Define the time vector. 
t = 0:Ts:dur;

% Define and plot the sinusoidal signals with 
% varying phi values.
for i = 1:length(phi_vals)
    phi = phi_vals(i);
    x2 = cos(2 * pi * f0 * t + phi);

    figure;
    plot(t, x2);
    xlabel('Time (in seconds).');
    ylabel('Amplitude.');
    title(['Plot of x(t) for phi =' num2str(phi)]);
    grid on;

    % Listen to the signal x2 for varying phi values.
    soundsc(x2, 1/Ts);
    pause(1);
end

