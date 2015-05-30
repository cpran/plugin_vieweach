include ../../plugin_utils/procedures/check_filename.proc

form Execute for each...
  sentence Script_path 
endform

@checkFilename: script_path$, "Select script to execute..."
action$ = checkFilename.name$

procedure for_each.before_iteration ()
  @createEmptySelectionTable()
  foreach.final_selection = selected()
endproc

procedure for_each.action ()
  runScript: action$
  for .i to numberOfSelected()
    @addToSelectionTable: foreach.final_selection, selected(.i)
  endfor
endproc

procedure for_each.finally ()
  @restoreSavedSelection(foreach.final_selection)
  removeObject: foreach.final_selection
endproc

include ../procedures/for_each.proc
@for_each()
