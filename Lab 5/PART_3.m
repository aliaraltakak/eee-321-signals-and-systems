% Define the required parameters. 
T = 1; % Duration of the rectangular pulse.

f1 = 100; % Frequency of the signal x1(t).
f2 = 800; % Frequency of the signal x2(t).

c = 343; % Propagation speed.
Ts = 0.0001; % Sampling period.
t = 0 : Ts : 2; % 2-second time vector.
Fs = 1 / Ts; % Calculate sampling frequency from the sampling period

d1 = 0.05; % Distance 1.
d2 = 0.1; % Distance 2.

N = length(t);
F = Fs*linspace(-0.5, 0.5, N); % Frequency vector

% Define the sinusoidal input signals. 
cos_1 = cos(2 * pi * f1 * t);
cos_2 = cos(2 * pi * f2 * t);

% Define the rectangular pulse for transmission. 
rect_pulse = double( abs(t - T/2) <= T/2);

% Generate the transmitted signals.
x1 = cos_1 .* rect_pulse;
x2 = cos_2 .* rect_pulse;

% Calculate the propagation delay of the signals. 
delay_t1 = 2 * (d1 / c);
delay_t2 = 2 * (d2 / c);

% Calculate the phase shifts.
phase_shift_1 = 2 * pi * f1 * delay_t1;
phase_shift_2 = 2 * pi * f2 * delay_t2;

% Apply the time shifts to obtain the received signals. 
r1 = cos(2 * pi * f1 * t + phase_shift_1) .* rect_pulse;
r2 = cos(2 * pi * f2 * t + phase_shift_2) .* rect_pulse;

% Plotting both transmitted and received signals.
figure;

% Transmitted Signal x1(t)
subplot(4,1,1);
plot(t, x1);
title('Transmitted Signal x1(t).');
xlabel('Time (s).');
ylabel('Amplitude.');
grid on;

xlim([-2, 2]);
ylim([-1.5, 1.5]);

% Received Signal r1(t)
subplot(4,1,2);
plot(t, r1);
title('Received Signal r1(t).');
xlabel('Time (s).');
ylabel('Amplitude.');
grid on;

xlim([-2, 2]);
ylim([-1.5, 1.5]);

% Transmitted Signal x2(t)
subplot(4,1,3);
plot(t, x2);
title('Transmitted Signal x2(t).');
xlabel('Time (s).');
ylabel('Amplitude.');
grid on;

xlim([-2, 2]);
ylim([-1.5, 1.5]);

% Received Signal r2(t)
subplot(4,1,4);
plot(t, r2);
title('Received Signal r2(t).');
xlabel('Time (s).');
ylabel('Amplitude.');
grid on;

xlim([-2, 2]);
ylim([-1.5, 1.5]);

% Calculate the Fourier Transforms
X1_f = FourierTransform(x1, t, Ts);
X2_f = FourierTransform(x2, t, Ts);
R1_f = FourierTransform(r1, t, Ts);
R2_f = FourierTransform(r2, t, Ts);

% Plot the Fourier Transform of the signal x1(t) and r1(t).
figure;
plot(F, abs(R1_f), 'b-', 'LineWidth', 1.5); 
hold on; 
plot(F, abs(X1_f), 'r--', 'LineWidth', 1.5); 
title('Fourier Transform of Transmitted and Received x1(t) and r1(t).');
xlabel('Frequency (Hz).');
ylabel('Amplitude.');
legend('Received R1(f)', 'Transmitted X1(f)');
grid on;
hold off;

% Plot the Fourier Transform of the signal x2(t) and r2(t).
figure;
plot(F, abs(R2_f), 'b-', 'LineWidth', 1.5); 
hold on; 
plot(F, abs(X2_f), 'r--', 'LineWidth', 1.5); 
title('Fourier Transform of Transmitted and Received x2(t) and r2(t).');
xlabel('Frequency (Hz).');
ylabel('Amplitude.');
legend('Received R2(f)', 'Transmitted X2(f)');
grid on;
hold off;

% Define frequency ranges for the band-pass filters around f1 and f2.
f1_range = [f1 - 25, f1 + 25];
f2_range = [f2 - 25, f2 + 25];

% Apply the band-pass filter to the time-domain received signals r1 and r2.
y1_f = bandpass(r1, f1_range, Fs);
y2_f = bandpass(r2, f2_range, Fs);

Y1_f = FourierTransform(y1_f, t, Ts);
Y2_f = FourierTransform(y2_f, t, Ts);

% Plot the outcomes of the Band-Pass filter.
figure;
subplot(2,1,1);
plot(F, abs(Y1_f));
title('Magnitude of Y1 After BPF.');
xlabel('Frequency (Hz).');
ylabel('Amplitude.');
grid on;

subplot(2,1,2);
plot(F, abs(Y2_f));
title('Magnitude of Y2 After BPF.');
xlabel('Frequency (Hz).');
ylabel('Amplitude.');
grid on;

% Find indices corresponding to f1 and f2
[~, idx1] = min(abs(F-f1));
[~, idx2] = min(abs(F-f2));

% Compute phase values at these frequencies
phase1 = angle(R1_f(idx1));
phase2= angle(R2_f(idx2));
phase1 = unwrap(phase1);
phase2 = unwrap(phase2);

% compute estimated distances based on phase shift and speed of sound
estimated_d1 = (phase1 / (2 * pi * f1)) * (c / 2); 
estimated_d2 = (phase2 / (2 * pi * f2)) * (c / 2);

% Display the true values and estimated values for distances.
fprintf('True value of distance 1: %.4f meters.\n', d1);
fprintf('Estimated distance 1 from processing: %.4f meters.\n', abs(estimated_d1));
fprintf('\n');
fprintf('True value of distance 2: %.4f meters.\n', d2);
fprintf('Estimated distance 2 from processing: %.4f meters.\n', abs(estimated_d2));

% Calculate the difference and error between the distances.
diff_1 = abs(d1 - estimated_d1);
diff_2 = abs(d2 - estimated_d2);

error_1 = abs((diff_1 / d1) * 100);
error_2 = abs((diff_2 / d2) * 100);

% Display the difference and error between the true values and estimated
% values.
fprintf('\n');
fprintf('Difference between the true value and estimated value of distance 1: %.4f meters.\n', diff_1);
fprintf('Difference between the true value and estimated value of distance 2: %.4f meters.\n', diff_2);
fprintf('\n');
fprintf('Error rate between the estimation and actual value of distance 1: %.2f percent.\n', error_1);
fprintf('Error rate between the estimation and actual value of distance 2: %.2f percent.\n', error_2);
