fs = 8192; % Sampling rate
duration = 10; % Duration of the recording in seconds

% Record your voice
recObj = audiorecorder(fs, 16, 1);
disp('Start speaking...');
recordblocking(recObj, duration);
disp('End of recording.');

% Get the recorded data
audioData = getaudiodata(recObj);

% Save as a .flac file
filename = 'id_num.flac';
audiowrite(filename, audioData, fs);

disp(['Recording saved as ' filename]);
