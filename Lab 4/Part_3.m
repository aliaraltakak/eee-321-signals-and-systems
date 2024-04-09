% Define the system variables. 
M = 100; 
c = 0.1; 
K = 0.1;
k = 30; 

% Define time variables.
Ts = 0.001;
t = 0:Ts:4-Ts; 

% Define x3(t) for one period.
r_t = t; 
u_t_3 = double(t >= 3); 
x3 = r_t - [zeros(1,3000), r_t(1:end-3000)] - 3*u_t_3;

% Preallocate output signal y with the same size as x3, system initially at rest
y = zeros(size(x3));

% Discrete time simulation of the system
for n = 3:length(x3)
    y(n) = (Ts^2/M)*(x3(n) - c*y(n-1)/Ts - K*y(n-2)) + 2*y(n-1) - y(n-2);
end

coeffs_x3 = FSAnalysis(x3, k); 
coeffs_output = FSAnalysis(y, k); 

% Plotting
figure;
subplot(2,1,1);
stem(-k:k, real(coeffs_x3), 'filled');
title('Real Part of Input x3(t).');
xlabel('k');
ylabel('Real Part.');
grid on;

subplot(2,1,2);
stem(-k:k, imag(coeffs_x3), 'filled');
title('Imaginary Part of Input x3(t).');
xlabel('k');
ylabel('Imaginary Part.');
grid on;

figure;
subplot(2,1,1);
stem(-k:k, real(coeffs_output), 'filled');
title('Real Part of Output y(t).');
xlabel('k');
ylabel('Real Part.');
grid on;

subplot(2,1,2);
stem(-k:k, imag(coeffs_output), 'filled');
title('Imaginary Part of Output y(t).');
xlabel('k');
ylabel('Imaginary Part.');
grid on;

% Plot the output
figure;
stem(t, y);
title('Waveform of the output.');
xlabel('Time');
ylabel('Gain Level');
