include ../../plugin_testsimple/procedures/test_simple.proc

selection$ = preferencesDirectory$ + "/plugin_selection/scripts/"
strutils$  = preferencesDirectory$ + "/plugin_strutils/scripts/"
utils$     = preferencesDirectory$ + "/plugin_utils/scripts/"

@no_plan()

synth = Create SpeechSynthesizer: "English", "default"
To Sound: "This is a long sample sentence for testing", "yes"
sound = selected("Sound")
textgrid = selected("TextGrid")

Extract non-empty intervals: 3, "no"

total_sounds = numberOfSelected("Sound")

runScript: selection$ + "save_selection.praat"
sounds = selected("Table")
runScript: selection$ + "restore_selection.praat"

To TextGrid: "interval point", "point"
runScript: selection$ + "save_selection.praat"
textgrids = selected("Table")

total_iterations = 0
procedure for_each.action ()
  .good = if numberOfSelected("Sound")    = 1 and
    ...      numberOfSelected("TextGrid") = 1 then 1 else 0 fi

  total_iterations += if .good then 1 else 0 fi
endproc

include ../procedures/for_each.proc
selectObject: sounds, textgrids
@for_each()

@ok_formula: "total_iterations = total_sounds",
  ... "procedure iterated well over all objects"

selectObject: sounds
copy = Copy: "copy"
selectObject: sounds, copy
long = Append
removeObject: copy
selectObject: long, textgrids

total_sounds     *= 2
total_iterations  = 0
@for_each()

@ok_formula: "total_iterations = total_sounds",
  ... "procedure iterated well over unequal sets"

removeObject: long

include ../../plugin_utils/procedures/utils.proc

@mktemp: "test.XXXX"
selectObject: textgrids
runScript: selection$ + "restore_selection.praat"

runScript: utils$ + "save_all.praat", mktemp.return$, "yes"
Remove

runScript: strutils$ + "file_list_full_path.praat",
  ... "full", mktemp.return$, "*TextGrid", 0

removeObject: textgrids
textgrids = selected("Strings")

selectObject: sounds, textgrids
total_sounds     /= 2
total_iterations  = 0
@for_each()

@ok_formula: "total_iterations = total_sounds",
  ... "good iteration with table and strings"

selectObject: textgrids
n = Get number of strings
for i to n
  file$ = Get string: i
  deleteFile: file$
endfor

selectObject: sounds
appendFileLine: mktemp.return$ + "test.praat", "Copy: selected$(""Sound"")"
appendFileLine: mktemp.return$ + "test.praat", "Reverse"
runScript: preferencesDirectory$ + 
  ... "/plugin_vieweach/scripts/for_each.praat",
  ... mktemp.return$ + "test.praat", "Use sets"
total_iterations = numberOfSelected("Sound")
Remove

@ok_formula: "total_iterations = total_sounds",
  ... "good iteration from script"

deleteFile: mktemp.return$

selectObject: sounds
runScript: selection$ + "restore_selection.praat"
Remove

removeObject: synth, sound, textgrid, sounds, textgrids

@done_testing()
