% Load the voice recording. 
[my_voice, fs_my_voice] = audioread('id_num.flac');
[total_voice, fs_total_voice] = audioread('TotalNumber.flac');

% Load n1.flac and n2.flac.
[n1, fs_n1] = audioread('2.flac');
[n2, fs_n2] = audioread('6.flac');

% Create time axis for the voice recording. 
voice_time_axis = (0:length(my_voice)-1) / fs_my_voice;
total_voice_time_axis = (0:length(total_voice)-1) /fs_total_voice;
time_orig_n1 = (0:length(n1)-1) / fs_n1;

% Extract n1 from the speech signal.
start_time_n1 = 1.05334; 
end_time_n1 = 1.45379; 

% Convert time to indices to extract.
start_index_n1 = round(start_time_n1 * fs_my_voice) + 1;
end_index_n1 = round(end_time_n1 * fs_my_voice);

% Extract one instance of n1. 
n1_instance = my_voice(start_index_n1:end_index_n1);

% Create a time array for n1. 
time_n1 = (0:length(n1_instance)-1) / fs_n1;

% Save n1 instance as a new .flac file. 
audiowrite('n1_instance.flac', n1_instance, fs_my_voice);

% Perform cross-correlation using the ConvFUNC. 
psi = CrossCorrFUNC(n1_instance, my_voice);

time_psi = (0:length(psi)-1) / fs_my_voice;

% Plot the whole speech signal and n1 for comparison. 
figure;
subplot(2, 1, 1);
plot(voice_time_axis, my_voice);
title('Recorded ID Speech Signal');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(2, 1, 2);
plot(time_n1, n1_instance);
title('Cropped N1.');
xlabel('Time (s)');
ylabel('Amplitude');

% Plot cross-correlation on recorded model.
figure;
subplot(3, 1, 1);
plot(time_psi, abs(psi));
title('|ψ[n]| of recording.');
xlabel('Time (s)');
ylabel('Magnitude');


subplot(3, 1, 2);
plot(time_psi, abs(psi).^2);
title('|ψ[n]|^2 of recording.');
xlabel('Time (s)');
ylabel('Magnitude');


subplot(3, 1, 3);
plot(time_psi, abs(psi).^4);
title('|ψ[n]|^4 of recording.');
xlabel('Time (s)');
ylabel('Magnitude');

% Perform cross-correlation using the ConvFUNC. 
psi_orig = CrossCorrFUNC(n1, total_voice);

time_psi_orig = (0:length(psi_orig)-1) / fs_total_voice;

% Plot the whole speech signal and n1 obtained from Python for comparison. 
figure;
subplot(2, 1, 1);
plot(total_voice_time_axis, total_voice);
title('Recorded ID Speech Signal from Speech Model.');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(2, 1, 2);
plot(time_orig_n1, n1);
title('N1 from Speech Model.');
xlabel('Time (s)');
ylabel('Amplitude');

% Plot cross-correlation on speech model.
figure;
subplot(3, 1, 1);
plot(time_psi_orig, abs(psi_orig));
title('|ψ[n]| of speech model.');
xlabel('Time (s)');
ylabel('Magnitude');


subplot(3, 1, 2);
plot(time_psi_orig, abs(psi_orig).^2);
title('|ψ[n]|^2 of speech model.');
xlabel('Time (s)');
ylabel('Magnitude');


subplot(3, 1, 3);
plot(time_psi_orig, abs(psi_orig).^4);
title('|ψ[n]|^4 of speech model.');
xlabel('Time (s)');
ylabel('Magnitude');



% Perform cross-correlation using the ConvFUNC. 
psi_model_vs_self_n1 = CrossCorrFUNC(n1_instance, total_voice);

time_psi_model_vs_self_n1 = (0:length(psi_model_vs_self_n1)-1) / fs_total_voice;

% Plot the signal from speech model and n1 recorded for comparison. 
figure;
subplot(2, 1, 1);
plot(total_voice_time_axis, total_voice);
title('Recorded ID Speech Signal from Speech Model.');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(2, 1, 2);
plot(time_n1, n1_instance);
title('N1 from Self Record');
xlabel('Time (s)');
ylabel('Amplitude');

% Plot cross-correlation on speech model.
figure;
subplot(3, 1, 1);
plot(time_psi_model_vs_self_n1, abs(psi_model_vs_self_n1));
title('|ψ[n]| of speech model vs N1 recorded.');
xlabel('Time (s)');
ylabel('Magnitude');


subplot(3, 1, 2);
plot(time_psi_model_vs_self_n1, abs(psi_model_vs_self_n1).^2);
title('|ψ[n]|^2 of speech model vs N1 recorded.');
xlabel('Time (s)');
ylabel('Magnitude');


subplot(3, 1, 3);
plot(time_psi_model_vs_self_n1, abs(psi_model_vs_self_n1).^4);
title('|ψ[n]|^4 of speech model vs N1 recorded.');
xlabel('Time (s)');
ylabel('Magnitude');




% Perform cross-correlation using the ConvFUNC. 
psi_self_vs_model_n1 = CrossCorrFUNC(n1, my_voice);

time_psi_self_vs_model_n1 = (0:length(psi_self_vs_model_n1)-1) / fs_my_voice;

% Plot the signal from speech model and n1 recorded for comparison. 
figure;
subplot(2, 1, 1);
plot(voice_time_axis, my_voice);
title('Recorded ID Speech Signal by self.');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(2, 1, 2);
plot(time_orig_n1, n1);
title('N1 from Speech Model.');
xlabel('Time (s)');
ylabel('Amplitude');

% Plot cross-correlation on speech model.
figure;
subplot(3, 1, 1);
plot(time_psi_self_vs_model_n1, abs(psi_self_vs_model_n1));
title('|ψ[n]| of recorded speech vs N1 from model.');
xlabel('Time (s)');
ylabel('Magnitude');


subplot(3, 1, 2);
plot(time_psi_self_vs_model_n1, abs(psi_self_vs_model_n1).^2);
title('|ψ[n]|^2 of recorded speech vs N1 from model.');
xlabel('Time (s)');
ylabel('Magnitude');


subplot(3, 1, 3);
plot(time_psi_self_vs_model_n1, abs(psi_self_vs_model_n1).^4);
title('|ψ[n]|^4 of recorded speech vs N1 from model.');
xlabel('Time (s)');
ylabel('Magnitude');
