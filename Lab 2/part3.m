% Define the time array and  sampling interval. 
Si = 0.25;
tau = -10:0.25:10;
tau_double = -20:0.25:20;

% Define signals Xi(t) and Eta(t).
xi_t = (tau >= -5) - (tau >= 5);
eta_t = (tau >= -2.5) - (tau >= 2.5);

% Sample signals to obtain Xi[n] and Eta[n].
xi_n = xi_t;
eta_n = eta_t;

% Calculate convolution ψ[n] = Xi[n] * Eta[n].
psi_n = ConvFUNC(xi_n, eta_n);

% Plotting. 
figure;

for ii = 1:length(psi_n)
    
    subplot(4, 1, 1);
    stem(tau, xi_n,"r", "filled", "LineWidth", 1.5);
    title('Plot of the sequence Xi[n].');
    xlabel('Time (in seconds).');
    ylabel('Amplitude');
    
    xlim([-7,7]);
    ylim([-1.5,1.5]);

    subplot(4, 1, 2);
    stem(tau, eta_n,"r", "filled", "LineWidth", 1.5);
    title('Plot of the sequence Eta[n].');
    xlabel('Time (in seconds).');
    ylabel('Amplitude');
    
    xlim([-7,7]);
    ylim([-1.5,1.5]);

    % Flip and shift Eta[n]
    eta_flipped_shifted = circshift(flip(eta_n), ii - 1);
    subplot(4, 1, 3);
    stem(tau, eta_flipped_shifted,"r", "filled", "LineWidth", 1.5);
    title('Plot of the sequence Eta[n] flipped and shifted.');
    xlabel('Time (in seconds).');
    ylabel('Amplitude');

    xlim([-50,50]);
    ylim([-1.5,1.5]);

    % Plot Psi[n] up to its iith value
    subplot(4, 1, 4);
    stem(tau_double(1:ii), psi_n(1:ii),"r", "filled", "LineWidth", 1.5);
    title('Plot of the convolution sequence Psi[n].');
    xlabel('Time (in seconds).');
    ylabel('Amplitude');
    
    xlim([-50,50]);
    ylim([-25,25]);
    
    % Pause for animation effect
    pause(0.01);
end
