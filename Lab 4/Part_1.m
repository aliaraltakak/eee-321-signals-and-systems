% Define the required parameters.
Ts = 0.001;
t = -1 : Ts : 1 - Ts;
T0 = 2;
k = 30;
N = length(t);

% Define the signal x1(t).
x1 = 8 * cos(10 * pi * t) + 20 * sin(6 * pi * t) - 11 * cos(30 * pi * t);

% Use FSAnalysis function.
coeffs_x1 = FSAnalysis(x1, k);

% Plot the coefficients.
figure;

subplot(2,1,1);
stem(-k : k, real(coeffs_x1), 'filled');
title('Real Part of the FS Coefficients of x1(t).');
xlabel('k')
ylabel('Real Values');

subplot(2,1,2);
stem(-k : k, imag(coeffs_x1), 'filled');
title('Imaginary Parts of the FS Coefficients of x1(t).');
xlabel('k');
ylabel('Imaginary Values');


% Define the signal x2(t).
x2 = exp(-(t));

% Use FSAnalysis function.
coeffs_x2 = FSAnalysis(x2, k);

% Plot the coefficients.
figure;

subplot(2,1,1);
stem(-k : k, real(coeffs_x2), 'filled');
title('Real Part of the FS Coefficients of x2(t).');
xlabel('k')
ylabel('Real Values');

subplot(2,1,2);
stem(-k : k, imag(coeffs_x2), 'filled');
title('Imaginary Parts of the FS Coefficients of x2(t).');
xlabel('k');
ylabel('Imaginary Values');


% Check for Parseval's Relation for x1(t).
% Compute the energy in the time domain.
timeDomainEnergy = Ts * sum(abs(x1).^2);

% Compute the energy in the frequency domain.
frequencyDomainEnergy = sum(abs(coeffs_x1).^2);
frequencyDomainEnergy = 2 .* frequencyDomainEnergy;

% Display the results.
disp(['Energy in the time domain for x1: ', num2str(timeDomainEnergy)]);
disp(['Energy in the frequency domain for x1: ', num2str(frequencyDomainEnergy)]);

% Verify Parseval's theorem.
systemTolerance = 1e-3; 
if abs(timeDomainEnergy - frequencyDomainEnergy) < systemTolerance
    disp('Parseval''s relation holds within the numerical tolerance.');
else
    disp('Parseval''s relation does not hold within the numerical tolerance.');
end

% Check for Parseval's Relation for x2(t).
energyx2 = Ts * sum(abs(x2) .^ 2);
freqEnergyx2 = sum(abs(coeffs_x2) .^ 2);
freqEnergyx2 = 2 .* freqEnergyx2;

disp(['Energy in the time domain for x2: ', num2str(energyx2)]);
disp(['Energy in the frequency domain for x2: ', num2str(freqEnergyx2)]);

if abs(energyx2 - freqEnergyx2) < systemTolerance
    disp('Parseval''s relation holds within the numerical tolerance.');
else
    disp('Parseval''s relation does not hold within the numerical tolerance.');
end

