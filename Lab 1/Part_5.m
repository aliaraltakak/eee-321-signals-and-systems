% Define the required parameters.
f_start_chirpup = 2500;  
f_end_chirpup = 500;
f_start_chirpdown = 500;
f_end_chirpdown = 2500;
dur = 2.0;  
Fs = 1/0.001;
phi = 0;

% Define the time vector.
t = 0:0.001:dur;

% Calculate the value of mu parameter.
mu_chirpup = (f_end_chirpup - f_start_chirpup) / (2 * dur);
mu_chirpdown = (f_end_chirpdown - f_start_chirpdown) / (2 * dur);

% Define the chirp signal wave formula
chirpup_signal = cos(2 * pi * (mu_chirpup * t.^2 + f_start_chirpup * t) + phi);
chirpdown_signal = cos(2 * pi * (mu_chirpdown * t.^2 + f_start_chirpdown * t) + phi);

% Plot the chirpup signal.
figure;
plot(t, chirpup_signal);
xlabel('Time (in seconds).');
ylabel('Amplitude.');
title('Plot of the defined chirpup signal with frequency modulation.');
grid on;

% Plot the chirpdown signal.
figure;
plot(t, chirpdown_signal);
xlabel('Time (in seconds).');
ylabel('Amplitude.')
title('Plot of the defined chirpdown signal with frequency modulation.');

% Listen to the generated chirp signal.
soundsc(chirpup_signal, Fs);
pause(2);
soundsc(chirpdown_signal, Fs);
pause(2);

% Display the calculated value of lambda
disp(['The value of mu for chirpup is: ' num2str(mu_chirpup)]); 
disp(['The value of mu for chirpdown is: ' num2str(mu_chirpdown)]);

% Define the required parameters for puzzle.
puzzle_f_start = 3000;
puzzle_f_end = -2000;
puzzle_dur = 3.0;
puzzle_sampling_interval = 1/0.001;

% Define the puzzle time vector.
puzzle_t = 0:0.001:puzzle_dur;

% Calculate the mu value for puzzle.
puzzle_mu = (puzzle_f_end - puzzle_f_start) / (2 * puzzle_dur);

% Define the puzzle chirp signal.
puzzle_chirp = cos(2 * pi * (puzzle_mu * puzzle_t.^2 + puzzle_f_start * puzzle_t) + phi);

% Plot the puzzle chirp signal.
figure;
plot(puzzle_t, puzzle_chirp);
xlabel('Time (in seconds).');
ylabel('Amplitude.')
title('Plot of the puzzle chirp signal with frequency modulation.');

% Listen to the generated puzzle chirp signal.
soundsc(puzzle_chirp, puzzle_sampling_interval);

% Display the calculated value of lambda
disp(['The value of mu for puzzle chirp is: ' num2str(puzzle_mu)]); 
