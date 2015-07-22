include ../../plugin_utils/procedures/check_filename.proc

form Execute for each...
  sentence Script_path 
  optionmenu Bundle: 1
    option Don't bundle
    option Per type
    option Use sets
endform

selection$ = preferencesDirectory$ - "con" + "/plugin_selection/scripts/"

@checkFilename: script_path$, "Select script to execute..."
action$ = checkFilename.name$

if bundle$ = "Don't bundle"
  # Execute once each for every object,
  # regardless of what object it is.

  runScript: selection$ + "save_selection.praat"
  selection = selected("Table")
elsif bundle$ = "Per type"
  # Execute a number of times equal to the largest number of
  # objects of the same type, with a selection made of one
  # object of each selected type. If sets of objects are of
  # unequal length, the shorter set(s) will loop.

  runScript: selection$ + "save_selection.praat"
  selection = selected("Table")
  objects = Collapse rows: "type", "n", "", "", "", ""
  for i to Object_'objects'.nrow
    type$ = Object_'objects'$[i, "type"]
    selectObject: selection
    runScript: selection$ + "restore_selection.praat"
    runScript: selection$ + "select_one_type.praat",
      ... type$, "yes"
    runScript: selection$ + "save_selection.praat"
    set[i] = selected("Table")
    Rename: type$
  endfor
  nocheck selectObject: undefined
  for i to Object_'objects'.nrow
    plusObject: set[i]
  endfor
elsif bundle$ = "Use sets"
  # Like with "Per type", but without automatic bundling:
  # You must provide the sets, either as selection tables, or as
  # Strings with fully specified paths (either relative or not)
endif

procedure for_each.before_iteration ()
  @createEmptySelectionTable()
  foreach.final_selection = createEmptySelectionTable.table
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

if bundle$ = "Don't bundle"
  removeObject: selection
elsif bundle$ = "Per type"
  for i to Object_'objects'.nrow
    removeObject: set[i]
  endfor
  removeObject: objects, selection
elsif bundle$ = "Use sets"
endif
