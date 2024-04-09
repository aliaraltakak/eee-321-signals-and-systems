% Define the parameters for x1.
f0_x1 = 440;
Ts_x1 = 0.0001;
dur_x1 = 3.0;
Tplot_x1 = 0.01;

% Define the time vector for x1.
t_x1 = 0:Ts_x1:dur_x1;

% Define the sinusoidal signal.
x1 = sin(2 * pi* f0_x1 * t_x1);

% Plot the sinusoidal x1.
figure;
plot(t_x1(1: Tplot_x1/Ts_x1), x1(1: Tplot_x1/Ts_x1));
xlabel('Time (in seconds).')
ylabel('Amplitude.')
title('Plot of the discretized sinusoidal signal.')
grid on;

figure;
stem(t_x1(1: Tplot_x1/Ts_x1), x1(1: Tplot_x1/Ts_x1));
xlabel('Time (in seconds).')
ylabel('Amplitude.')
title('Stem plot of the discretized sinusoidal signal.')
grid on;


% Define the parameters for major triad. 
f_A = 440;
f_Csharp = 554;
f_E = 659;
dur_triad = 3.0;

% Define the time vector for major triad.
t_triad = 0:Ts_x1:dur_triad;

% Define the sinusoidal for major triad. 
s = sin(2 * pi * f_A * t_triad) + sin(2 * pi * f_Csharp * t_triad) + sin(2 * pi * f_E * t_triad);

% Plot the major triad sinusoidal. 
figure;
plot(t_triad, s);
xlabel('Time (in seconds).');
ylabel('Amplitude.');
title('Plot of the major triad sinusoidal signal.');
grid on;

% Listen to the major triad.
soundsc(s, 1/Ts_x1);