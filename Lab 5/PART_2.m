% Define the required variables.
Ts = 0.01;
Ts_plot = 0.0001;

t = -10 : Ts : 10 - Ts;
t_plot = -1/6 : Ts_plot : 1/6;

% Define the cosine signal.
x = cos(2 * pi * 30 * t);
x_plot = cos(2 * pi * 30 * t_plot);

% Compute the Fourier Transform of the cosine signal. 
cos_array = FourierTransform(x, t, Ts);

% Define required vectors. 
Fs = 1 / Ts;
N = length(x);
F = linspace(-Fs/2, Fs/2, N);

% Plot the original signal and its Fourier Transform.
figure;

subplot(2,1,1);
plot(t_plot, x_plot);
title("Waveform of the defined cosine signal.");
xlabel("Time (s).");
ylabel("Magnitude");
grid on;

subplot(2,1,2);
plot(F, abs(cos_array));
title("Magnitude of the Fourier Transform of the cosine signal.");
xlabel("Frequency (Hz).");
ylabel("Magnitude");
grid on;