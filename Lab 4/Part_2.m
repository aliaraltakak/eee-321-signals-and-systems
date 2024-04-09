% Define time variables.
Ts = 0.001;
t = 0:Ts:4-Ts; 

% Define x3(t) for one period.
r_t = t; 
u_t_3 = double(t >= 3); 
x3 = r_t - [zeros(1,3000), r_t(1:end-3000)] - 3*u_t_3;

% Number of coefficients to estimate on each side of zero.
k = 30;

% Compute the Fourier series coefficients for x3(t).
coeffs_x3 = FSAnalysis(x3, k);

% Plot the initial signal. 
subplot(2,1,1);
stem(-k:k, real(coeffs_x3), 'filled');
title('Real Part of Fourier Series Coefficients for x3(t)');
xlabel('k');
ylabel('Real Part');
grid on;

subplot(2,1,2);
stem(-k:k, imag(coeffs_x3), 'filled');
title('Imaginary Part of Fourier Series Coefficients for x3(t)');
xlabel('k');
ylabel('Imaginary Part');
grid on;

% Implementation of Part A.
z1 = fliplr(x3); 

% Compute Fourier series coefficients for z1(t).
coeffs_z1 = FSAnalysis(z1, k);

% Plot the real part. 
figure;
subplot(2,1,1);
stem(-k:k, real(coeffs_z1), 'filled');
title('Real Part of Fourier Series Coefficients for z1(t)');
xlabel('k');
ylabel('Real Part');
grid on;

% Plot the imaginary part. 
subplot(2,1,2);
stem(-k:k, imag(coeffs_z1), 'filled');
title('Imaginary Part of Fourier Series Coefficients for z1(t)');
xlabel('k');
ylabel('Imaginary Part');
grid on;

% Implementation of Part B.
dx3_dt = diff(x3) / Ts; 
dx3_dt = [dx3_dt, dx3_dt(end)]; 

% Compute the Fourier series coefficients for the derivative z2(t).
coeffs_z2 = FSAnalysis(dx3_dt, k);

% Plot the Fourier series coefficients
figure;
subplot(2,1,1);
stem(-k:k, real(coeffs_z2), 'filled');
title('Real Part of Fourier Series Coefficients for z2(t)');
xlabel('k');
ylabel('Real Part');
grid on;

subplot(2,1,2);
stem(-k:k, imag(coeffs_z2), 'filled');
title('Imaginary Part of Fourier Series Coefficients for z2(t)');
xlabel('k');
ylabel('Imaginary Part');
grid on;

% Implementation of Part C.
samples_shift = 2 / Ts;

% Shift x3 by 2 seconds to obtain z3
z3 = [zeros(1, samples_shift), x3(1:end-samples_shift)];

% Compute the Fourier series coefficients for z3(t)
coeffs_z3 = FSAnalysis(z3, k);

% Plot the Fourier series coefficients
figure;
subplot(2,1,1);
stem(-k:k, real(coeffs_z3), 'filled');
title('Real Part of Fourier Series Coefficients for z3(t)');
xlabel('k');
ylabel('Real Part');
grid on;

subplot(2,1,2);
stem(-k:k, imag(coeffs_z3), 'filled');
title('Imaginary Part of Fourier Series Coefficients for z3(t)');
xlabel('k');
ylabel('Imaginary Part');
grid on;

% Implementation of Part D.
z4 = (x3 + z1) / 2;

% Compute the Fourier series coefficients for z4(t)
coeffs_z4 = FSAnalysis(z4, k);

% Plot the Fourier series coefficients
figure;
subplot(2,1,1);
stem(-k:k, real(coeffs_z4), 'filled');
title('Real Part of Fourier Series Coefficients for z4(t) [Even Part of x3(t)]');
xlabel('k');
ylabel('Real Part');
grid on;

subplot(2,1,2);
stem(-k:k, imag(coeffs_z4), 'filled');
title('Imaginary Part of Fourier Series Coefficients for z4(t) [Even Part of x3(t)]');
xlabel('k');
ylabel('Imaginary Part');
grid on;

% Implementation of Part E.
z5 = x3.^2;

% Compute the Fourier series coefficients for z5(t)
coeffs_z5 = FSAnalysis(z5, k);

% Plot the Fourier series coefficients
figure;
subplot(2,1,1);
stem(-k:k, real(coeffs_z5), 'filled');
title('Real Part of Fourier Series Coefficients for z5(t) [Squared x3(t)]');
xlabel('Coefficient Index k');
ylabel('Real Part');
grid on;

subplot(2,1,2);
stem(-k:k, imag(coeffs_z5), 'filled');
title('Imaginary Part of Fourier Series Coefficients for z5(t) [Squared x3(t)]');
xlabel('Coefficient Index k');
ylabel('Imaginary Part');
grid on;