% Define the required parameters.
Ts = 0.01;
a_values = [0, 0.05, 0.10, 0.25, 0.5];
n = 0:50;

% Define the input sequences.
u_n = @(n) double(n >= 0);
x1 = 8 * (u_n(n) - u_n(n-4)) - 4 * (u_n(n-4) - u_n(n-13));
x2 = (0.3) .^ n .* u_n(n);

% Preallocate the arrays for storage.
y1 = zeros(length(a_values), length(n));
y2 = zeros(length(a_values), length(n));

for i = 1:length(a_values)
    a = a_values(i);
    h_n = zeros(1, length(n));
    
    if a == 0
        % Discrete approximation of an integrator.
        h_n = cumsum(Ts * ones(1, length(n)));
    else
        % Impulse response for the system with exponential decay
        h_n = exp(-a * (0:length(n)-1) * Ts) .* u_n(0:length(n)-1);
    end
    
    % Compute the output sequences by convolution
    y1(i, :) = conv(x1, h_n, 'same');
    y2(i, :) = conv(x2, h_n, 'same');
end

% Plotting code remains the same


% Plot the results for y1
figure;
for i = 1:length(a_values)
    subplot(length(a_values), 1, i);
    stem(n, y1(i, :));
    title(['Output y1[n] for a = ', num2str(a_values(i))]);
    xlabel('n');
    ylabel('Amplitude');
end

% Plot the results for y2
figure;
for i = 1:length(a_values)
    subplot(length(a_values), 1, i);
    stem(n, y2(i, :));
    title(['Output y2[n] for a = ', num2str(a_values(i))]);
    xlabel('n');
    ylabel('Amplitude');
end

% Initialize arrays to hold the differences
E1 = zeros(size(y1));
E2 = zeros(size(y2));

% Calculate the differences for each value of a, excluding a=0 (the first row)
for i = 2:length(a_values)
    E1(i, :) = abs(y1(1, :) - y1(i, :));
    E2(i, :) = abs(y2(1, :) - y2(i, :));
end

% Plot the results for E1
figure;
for i = 2:length(a_values)  % Start from 2 since the first row is for a=0
    subplot(length(a_values)-1, 1, i-1); 
    stem(n, E1(i, :));
    title(['Difference E1[n] for a = ', num2str(a_values(i))]);
    xlabel('n');
    ylabel('|y_{ideal1}[n] - y1[n]|');
end

% Plot the results for E2
figure;
for i = 2:length(a_values)  % Start from 2 since the first row is for a=0
    subplot(length(a_values)-1, 1, i-1);  
    stem(n, E2(i, :));
    title(['Difference E2[n] for a = ', num2str(a_values(i))]);
    xlabel('n');
    ylabel('|y_{ideal2}[n] - y2[n]|');
end