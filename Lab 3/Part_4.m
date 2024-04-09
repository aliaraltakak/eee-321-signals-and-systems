% Define a sample input sequence.
n = -10:10; 
x = [zeros(1,10), 1, zeros(1,10)]; 
Ts = 0.001;

% Define the input sequences.
u_n = @(n) double(n >= 0);
x1 = 8 * (u_n(n) - u_n(n-4)) - 4 * (u_n(n-4) - u_n(n-13));
x2 = (0.3).^n .* u_n(n);

% Initialize the output sequences.
y1 = zeros(1, length(n));
y2 = zeros(1, length(n));


% Plot the sample input sequence. 
figure;
stem(n, x);
title('Defined sample input sequence.');
xlabel('Sample indices.');
ylabel('Amplitude.');
ylim([-10,10]);

% Implement the second-order difference equation.
y = zeros(1,length(n));
for i = 3:length(n)
    y(i) = x(i) - 2*x(i-1) + x(i-2);
end


% Plot the impulse response.
figure;
stem(n, y);
title('Impulse Response of the Second-Order Differentiation System.');
xlabel('Sample indices.');
ylabel('Amplitude.');
ylim([-10,10]);


% Compute the output sequence for x1[n].
for i = 3:length(n)
    y1(i) = x1(i) - 2 * x1(i-1) + x1(i-2);
end

% Plot the output sequence for x1[n].
figure;
stem(n, y1);
title('Output Sequence y1[n] for Input x1[n]');
xlabel('n');
ylabel('Amplitude');

% Compute the output sequence for x2[n].
for i = 3:length(n)
    y2(i) = x2(i) - 2 * x2(i-1) + x2(i-2);
end

% Plot the output sequence for x2[n].
figure;
stem(n, y2);
title('Output Sequence y2[n] for Input x2[n]');
xlabel('n');
ylabel('Amplitude');


% Using sumElements function for BIBO stability check.
N_range = 0:6;
sum_array = sumElements(y, N_range);

% Plot the summation values.
figure;
stem(N_range, sum_array);
title('Summation Results for Impulse Response.');
xlabel('Sample indices.');
ylabel('Summation Value.');
ylim([-10,10]);

% Implement the inverse system. 
x_recovered = zeros(1, length(n));
for i = 3:length(n)
    sum = 0;
    for k = 1:(i-1)
        sum = sum + (k-1) * y(i-k+1);
    end
    x_recovered(i) = sum;
end

x_recovered = [x_recovered(2:end), 0];


% Plot the recovered input sequence.
figure;
stem(n, x_recovered);
title('Recovered Input Sequence.');
xlabel('Sample indices.');
ylabel('Amplitude.');
ylim([-10, 10]);


% Initialize the recovered input sequences.
x1_recovered = zeros(1, length(n));
x2_recovered = zeros(1, length(n));

% Apply the inverse system to recover x1 from y1.
for i = 3:length(n)
    sum = 0;
    for k = 1:(i-1)
        sum = sum + (k-1) * y1(i-k+1);
    end
    x1_recovered(i) = sum;
end

% Plot the recovered input sequence for x1.
figure;
stem(n, x1_recovered);
title('Recovered Input Sequence from y1[n]');
xlabel('n');
ylabel('Amplitude');

% Apply the inverse system to recover x2 from y2..
for i = 3:length(n)
    sum = 0;
    for k = 1:(i-1)
        sum = sum + (k-1) * y2(i-k+1);
    end
    x2_recovered(i) = sum;
end

% Plot the recovered input sequence for x2.
figure;
stem(n, x2_recovered);
title('Recovered Input Sequence from y2[n]');
xlabel('n');
ylabel('Amplitude');



sum_array_1 = sumElements(x_recovered, N_range + 11); 

% Plot the summation values of the recovered input.
figure;
stem(N_range, sum_array_1);
title('Summation Results for the Recovered Input.');
xlabel('Sample indices.');
ylabel('Summation Value.');
ylim([-10, 10]);

% Convolve the two systems.
convsig = conv(y, x_recovered);

% Generate index for the time axis, adjusted for the length of the convolution result.
idx = 1:length(convsig);

% Create a figure and plot the convolution result using stem.
figure;
stem(idx, convsig);
title('Convolution of the Two Systems');
xlabel('Index');
ylabel('Amplitude');