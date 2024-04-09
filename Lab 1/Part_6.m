notename = ["A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#"];

song = ["E", "D#", "E", "D#", "E", "B", "D", "C", "A", "C", "E", "A", "B", "E", "G#", "B", "C", "E";
        "E", "D#", "E", "D#", "E", "B", "D", "C", "A", "C", "E", "A", "B", "E", "C", "B", "A", "B";
        "C", "D", "E", "G", "F", "E", "D", "F", "E", "D", "C", "E", "D", "C", "B", "E", "D#", "E";
        "D#", "E", "B", "D", "C", "A", "C", "E", "A", "B", "E", "G#", "B", "C", "E", "E", "D#", "E";
        "D#", "E", "B", "D", "C", "A", "C", "E", "A", "B", "E", "C", "B", "A"];

songidx = zeros(1, length(song));

for k1 = 1:length(song)
    idx = strcmp(song(k1), notename);
    songidx(k1) = find(idx);
end

dur = 0.25 * 8192;
songnote = [];

for k1 = 1:length(songidx)
    note = [notecreate(songidx(k1), dur), zeros(1, 75)];
    songnote = [songnote, note];
end

soundsc(songnote, 8192);

audiowrite('für-elise-matlab.wav', songnote, 8192)
