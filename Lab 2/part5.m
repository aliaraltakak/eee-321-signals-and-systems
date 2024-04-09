% Load the speech model audio recording. 
[audio_array, fs_array] = audioread('TotalNumber.flac');
[n1, fs_n1] = audioread('2.flac');

% Determine the length of the audio. 
audio_len = length(audio_array);

% Listen to the audio signal. 
soundsc(audio_array, fs_array);
pause(10);

% Determine the power of the provided audio signal.
p_signal = sum(audio_array.^2) / audio_len;
disp(['Power of the speech model audio: ', num2str(p_signal)]);

% Determine the SNR values.
SNR_val = [10, 0.1, 0.001];

% Calculate the power of noise for each SNR value. 
for snr = SNR_val
    p_noise = p_signal / snr;
    disp(['Power of the noise signal for SNR ', num2str(snr), ': ', num2str(p_noise)]);

    % Generate Additive White Gaussian Noise. 
    rng (5)
    awgn = sqrt(p_noise).*randn([audio_len , 1]);

    % Add the generated noise to the audio signals.
    noisy_audio = audio_array + awgn;

    % Listen to the noisy audio signals generated. 
    soundsc(noisy_audio, fs_array);
    pause(10);
end

% Define the SNR values to iterate through.
SNR_values = 0.01:-0.001:0.001;

figure;

for snrVal = SNR_values
    % Calculate power of noise using SNR and power of the original audio
    % signal.
    p_signal = sum(audio_array.^2) / length(audio_array);
    p_noise = p_signal / snrVal;

    % Generate Additive White Gaussian Noise. 
    rng(5);  
    awgn = sqrt(p_noise) .* randn([length(audio_array), 1]);

    % Add the generated noise to the audio signals.
    noisy_audio = audio_array + awgn;

    % Perform cross-correlation using the ConvFUNC function. 
    output = CrossCorrFUNC(n1, noisy_audio);

    % Plot.
    subplot(5, 2, find(SNR_values == snrVal));
    plot(output);
    title(['SNR: ' num2str(snrVal)]);
end

