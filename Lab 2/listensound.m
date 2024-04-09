% Load and play the text-to-speech output
[total_number, fs_total_number] = audioread('TotalNumber.flac');
soundsc(total_number, fs_total_number);
