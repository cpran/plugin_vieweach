include ../../plugin_testsimple/procedures/more.proc

selection$ = preferencesDirectory$ + "/plugin_selection/scripts/"
strutils$  = preferencesDirectory$ + "/plugin_strutils/scripts/"
utils$     = preferencesDirectory$ + "/plugin_utils/scripts/"

@hasGUI()
has_editor = hasGUI.return

@no_plan()

runScript: "make_objects.praat"
runScript: selection$ + "save_selection.praat"
selection = selected("Table")

procedure view_each.after_editor ()
  .good = if numberOfSelected("Sound")    = 1 and
    ...      numberOfSelected("TextGrid") = 1 then 1 else 0 fi

  myeditor += 1
  good_editor += if .good then 1 else 0 fi
endproc

procedure view_each.no_editor ()
  .good = if numberOfSelected("Sound")    = 1 and
    ...      numberOfSelected("TextGrid") = 1 then 1 else 0 fi

  noneditor += 1
  good_noneditor += if .good then 1 else 0 fi
endproc

@reset()
include ../../plugin_vieweach/procedures/view_each.proc
@view_each()

if has_editor
  @is: noneditor,  0, "objects have editor with GUI"
  @is: myeditor , 16, "iterated well over each object with editor"
else
  @is: noneditor, 16, "iterated well over each object without editor"
  @is: myeditor ,  0, "no editor without GUI"
endif

selectObject: selection
runScript: selection$ + "restore_selection.praat"
runScript: selection$ + "select_types.praat", "Sound", "yes"
runScript: selection$ + "save_selection.praat"
sounds = selected("Table")

selectObject: selection
runScript: selection$ + "restore_selection.praat"
runScript: selection$ + "select_types.praat", "TextGrid", "yes"
runScript: selection$ + "save_selection.praat"
textgrids = selected("Table")

selectObject: sounds, textgrids
@reset()
@view_each()

if has_editor
  @is: noneditor, 0, "objects have editor with GUI"
  @is: myeditor,  8, "iterated well over sets with editor"
else
  @is: noneditor, 8, "iterated well over sets without editor"
  @is: myeditor,  0, "no editor without GUI"
endif

selectObject: selection
runScript: selection$ + "restore_selection.praat"
plusObject: selection, sounds, textgrids
Remove

@ok_selection()

@done_testing()

procedure reset ()
  myeditor = 0
  good_editor = 0
  noneditor = 0
  good_noneditor = 0
endproc
