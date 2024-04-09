from gtts import gTTS

TotalNumber = "2. 2. 0. 0. 1. 7. 5. 8."
Total_audio = gTTS(text=TotalNumber , lang="en", slow=True) 
Total_audio.save("TotalNumber.flac")
for num in range(0, 10):
    strnum = ", " + str(num) + "."
    num_audio = gTTS(text=strnum , lang="en", slow=True) 
    num_audio.save(str(num)+".flac")