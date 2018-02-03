if praatVersion >= 6036
  synth_language$ = "English (Great Britain)"
  synth_voice$ = "Male1"
else
  synth_language$ = "English"
  synth_voice$ = "default"
endif

synth = Create SpeechSynthesizer: synth_language$, synth_voice$
To Sound: "This is a long sample sentence for testing", "yes"
sound = selected("Sound")
textgrid = selected("TextGrid")

Extract non-empty intervals: 3, "no"

sounds = numberOfSelected("Sound")

for i to sounds
  sound[i] = selected("Sound", i)
endfor

for i to sounds
  selectObject: sound[i]
  textgrid[i] = To TextGrid: "interval point", "point"
endfor

nocheck selectObject: undefined
for i to sounds
  plusObject: sound[i], textgrid[i]
endfor
removeObject: synth, sound, textgrid
