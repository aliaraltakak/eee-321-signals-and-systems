% Define the required parameters. 
T = 1; % Rectangular pulse duration.
Ts = 0.0001; % Sampling period. 
Fs = 1 / Ts; % Sampling frequency.
t = 0 : Ts : 2; % 2-second time vector. 

f1 = 100; % Frequency of the signal of transmitter 1.
f2 = 800; % Frequency of the signal of transmitter 2.

c = 343; % Propagation speed.
v1 = -30; % Relative velocity of object from transmitter 1.
v2 = 40; % Relative velocity of object from transmitter 2. 

% Define the rectangular pulse signal. 
rect_pulse = double(abs(t - T/2) <= T/2);

% Define the sinusoidal signals.
cos_1 = cos(2 * pi * f1 * t);
cos_2 = cos(2 * pi * f2 * t);

% Define the transmitted signals. 
x1 = cos_1 .* rect_pulse;
x2 = cos_2 .* rect_pulse;

% Calculate the observed frequencies, using the Doppler Principle.
f_obs_1 = f1 * (c + v1) / (c - v1);
f_obs_2 = f2 * (c + v2) / (c - v2);

% Generate the received signals. 
r1 = cos(2 * pi * f_obs_1 * t) .* rect_pulse;
r2 = cos(2 * pi * f_obs_2 * t) .* rect_pulse;

% Plot the transmitted and received signals. 
figure;

subplot(4,1,1);
plot(t, x1);
xlabel("Time (s).");
ylabel("Amplitude.");
title("Transmitted signal x1(t).");
grid on;

xlim([-2, 2]);
ylim([-1.5, 1.5]);

subplot(4,1,2);
plot(t, r1);
xlabel("Time (s).");
ylabel("Amplitude.");
title("Received signal r1(t).");
grid on;

xlim([-2, 2]);
ylim([-1.5, 1.5]);

subplot(4,1,3);
plot(t, x2);
xlabel("Time (s).");
ylabel("Amplitude.");
title("Transmitted signal x2(t).");
grid on;

xlim([-2, 2]);
ylim([-1.5, 1.5]);

subplot(4,1,4);
plot(t, r2);
xlabel("Time (s).");
ylabel("Amplitude.");
title("Received signal r2(t).");
grid on;

xlim([-2, 2]);
ylim([-1.5, 1.5]);

% Compute the Fourier Transforms of the transmitted signals.
x1_f = FourierTransform(x1, t, Ts);
x2_f = FourierTransform(x2, t, Ts);

% Compute the Fourier Transforms of the received signals.
r1_f = FourierTransform(r1, t, Ts);
r2_f = FourierTransform(r2, t, Ts);

% Plot the obtained Fourier Transforms. 
N = length(t);
F = Fs * linspace(-0.5, 0.5, N);

figure;
plot(F, abs(x1_f));
xlabel("Frequency Spectrum (Hz).");
ylabel("Amplitude");
title("Fourier Transform of the signal x1(t).");
grid on;

figure;
plot(F, abs(x2_f));
xlabel("Frequency Spectrum (Hz).");
ylabel("Amplitude");
title("Fourier Transform of the signal x2(t).");
grid on;

figure;
plot(F, abs(r1_f));
xlabel("Frequency Spectrum (Hz).");
ylabel("Amplitude");
title("Fourier Transform of the signal r1(t).");
grid on;

figure;
plot(F, abs(r2_f));
xlabel("Frequency Spectrum (Hz).");
ylabel("Amplitude");
title("Fourier Transform of the signal r2(t).");
grid on;

% Detect the peak frequencies from the transmitted signals.
[~, idx1] = max(abs(x1_f));
[~, idx2] = max(abs(x2_f));

observed_fx1 = F(idx1);
observed_fx2 = F(idx2);

% Detect the peak frequencies from the received signals.
[~, r_idx1] = max(abs(r1_f));
[~, r_idx2] = max(abs(r2_f));

observed_fr1 = F(r_idx1);
observed_fr2 = F(r_idx2);

% Calculate the differences between transmitted and received signal
% frequencies.
diff_1 = abs(observed_fx1 - observed_fr1);
diff_2 = abs(observed_fx2 - observed_fr2);

% Display the peak frequencies from both transmitted and received signals.
fprintf('Peak Frequency of Transmitted Signal x1: %.2f Hz\n', abs(observed_fx1));
fprintf('Peak Frequency of Transmitted Signal x2: %.2f Hz\n', abs(observed_fx2));
fprintf('Peak Frequency of Transmitted Signal r1: %.2f Hz\n', abs(observed_fr1));
fprintf('Peak Frequency of Transmitted Signal r2: %.2f Hz\n', abs(observed_fr2));

% Display the difference between the peak frequencies of transmitted and
% received signals.
fprintf("\n")
fprintf('Difference between the peak frequencies of x1 and r1: %.2f Hz\n', diff_1);
fprintf('Difference between the peak frequencies of x2 and r2: %.2f Hz\n', diff_2);

% Calculate the scaling factors for both signals.
factor_1 = (f_obs_1) / f1;
factor_2 = (f_obs_2) / f2;

% Calculate the estimated velocities using the scaling factor and Doppler
% Effect.
estimated_v1 = c * ((factor_1 - 1) / (factor_1 + 1));
estimated_v2 = c * ((factor_2 - 1) / (factor_2 + 1));

% Display the results of the estimation. 
fprintf("\n");
fprintf("True value of Velocity v1: %.2f m/s\n", v1);
fprintf('Estimated Velocity v1: %.2f m/s\n', estimated_v1);
fprintf("\n");
fprintf("True value of Velocity v2: %.2f m/s\n", v2);
fprintf('Estimated Velocity v2: %.2f m/s\n', estimated_v2);
