include ../../plugin_selection/procedures/selection.proc
include ../../plugin_utils/procedures/check_filename.proc

form Execute for each...
  sentence Script_path 
endform

@checkFilename: script_path$, "Select script to execute..."
action$ = checkFilename.name$

selection_scripts$ = preferencesDirectory$ + "/plugin_selection/scripts/"

total_sets = numberOfSelected("Table") + numberOfSelected("Strings")

if total_sets
  runScript: selection_scripts$ + "save_selection.praat"
  sets = selected("Table")

  max_items = 0
  for set to total_sets
    selectObject: Object_'sets'[set, "id"]
    type$ = Object_'sets'$[set, "type"]
    items = do("Get number of " +
      ... if type$ = "Table" then "rows" else "strings" fi)
    max_items = if items > max_items then items else max_items fi
  endfor
  total_items = max_items

#   appendInfoLine: "There are ", total_sets, " total sets of objects"
#   appendInfoLine: "And up to ", total_items, " to iterate upon"

  nocheck selectObject: undefined
  for item to total_items
    @createEmptySelectionTable()
    selection = selected()

    @createEmptySelectionTable()
    remove = selected()

#     appendInfoLine: "Processing selection number ", item

    for s to total_sets
      set = Object_'sets'[s, "id"]
      type$ = Object_'sets'$[s, "type"]
      selectObject: set
      items = do("Get number of " +
        ... if type$ = "Table" then "rows" else "strings" fi)

      i = ((item - 1) mod items) + 1
      if type$ = "Table"
        id = Object_'set'[i, "id"]
      else
        selectObject: set
        filename$ = Get string: i
        id = Read from file: filename$

        @addToSelectionTable: remove, id
      endif
      @addToSelectionTable: selection, id
    endfor

    selectObject: selection
    runScript: selection_scripts$ + "restore_selection.praat"

    runScript: action$

    selectObject: remove
    runScript: selection_scripts$ + "restore_selection.praat"
    nocheck Remove
    removeObject: selection, remove
  endfor

  selectObject: sets
  runScript: selection_scripts$ + "restore_selection.praat"
  removeObject: sets
endif
