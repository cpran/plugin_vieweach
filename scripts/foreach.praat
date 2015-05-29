form Execute for each...
  sentence Script_path 
endform

@checkFilename: script_path$, "Select script to execute..."
action$ = checkFilename.name$

procedure foreach.before_iteration ()
  @createEmptySelectionTable()
  foreach.final_selection = selected()
endproc

procedure foreach.action ()
  runScript: action$
  for .i to numberOfSelected()
    @addToSelectionTable: foreach.final_selection, selected(.i)
  endfor
endproc

procedure foreach.finally ()
  @restoreSavedSelection(foreach.final_selection)
  removeObject: foreach.final_selection
endproc

include ../procedures/foreach.proc
@foreach()
