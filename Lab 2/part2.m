% Define the input sequence x[n].
n = 0:11;
x = zeros(size(n));
x([0, 1, 5, 6, 7, 11]+1) = 0;
x([2, 3, 4, 8, 9, 10]+1) = 1;

% Use ConvFUNC function to compute convolution. 
y = ConvFUNC(x, x);

% Plot the discrete input signal and it's convolution. 
figure;
subplot(2, 1, 1);
stem(n, x, "r", "filled", "LineWidth", 1.5);
title('Input signal x[n].');
xlabel('n');
ylabel('Amplitude');

ylim([0,1.5])

subplot(2, 1, 2);
stem(0:length(y)-1, y, "r", "filled", "LineWidth", 1.5);
title('Convolution operation y[n]=x[n]*x[n].');
xlabel('n');
ylabel('Amplitude');

ylim([-10,10])
xlim([0,20])
