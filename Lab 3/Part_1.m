% Define variables such as sampling period.
Ts = 0.001;
n = 0:10000;
a = 1; % Constant value for the exponential.

% Manual accumulation for the integrator's impulse response.
integ_impulse = [1, zeros(1, length(n) - 1)];
h_n = zeros(1, length(n));
h_n(1) = integ_impulse(1) * Ts;
for i = 2:length(n)
    h_n(i) = h_n(i-1) + Ts * integ_impulse(i);
end

% Manual accumulation for the integrator's step response.
integ_step = ones(1, length(n));
s_n = zeros(1, length(n));
for i = 2:length(n)
    s_n(i) = s_n(i-1) + Ts * integ_step(i);
end

% Plot the integrator.
figure;
subplot(2,1,1);
stem(n, h_n);
title('Impulse response of the integrator.')
xlabel('Sample indices')
ylabel('h[n]')

subplot(2,1,2);
stem(n, s_n);
title('Step response of the integrator.')
xlabel('Sample indices.')
ylabel('s[n]');

% Manual accumulation for the second system's impulse response.
second_impulse = exp(-a * n * Ts);
second_step = zeros(1, length(n));
for i = 2:length(n)
    second_step(i) = second_step(i-1) + Ts * second_impulse(i);
end

% Plot the second system.
figure;
subplot(2,1,1);
stem(n, second_impulse);
title('Impulse response of the second system.')
xlabel('Sample indices.')
ylabel('h[n]')

subplot(2,1,2);
stem(n, second_step);
title('Step response of the second system.');
xlabel('Sample indices.');
ylabel('s[n]');
