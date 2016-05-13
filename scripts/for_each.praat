# This script is part of the vieweach CPrAN plugin for Praat.
# The latest version is available through CPrAN or at
# <http://cpran.net/plugins/vieweach>
#
# The vieweach plugin is free software: you can redistribute it
# and/or modify it under the terms of the GNU General Public
# License as published by the Free Software Foundation, either
# version 3 of the License, or (at your option) any later version.
#
# The vieweach plugin is distributed in the hope that it will be
# useful, but WITHOUT ANY WARRANTY; without even the implied warranty
# of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with vieweach. If not, see <http://www.gnu.org/licenses/>.
#
# Copyright 2015 Jose Joaquin Atria

include ../../plugin_utils/procedures/check_filename.proc

## Uncomment to enable tracing
# include ../../plugin_utils/procedures/trace.proc
# trace.enable = 1
# trace.cleared = 1
# trace.output$ = ""

form Execute for each...
  sentence Script_path
  optionmenu Bundle: 1
    option Don't bundle
    option Per type
    option Use sets
endform

selection$ = preferencesDirectory$ + "/plugin_selection/scripts/"
selection.restore_nocheck = 1

@checkFilename: script_path$, "Select script to execute..."
action$ = checkFilename.name$

if !fileReadable(action$)
  exitScript: "Could not read file at " + action$
endif

runScript: selection$ + "save_selection.praat"
Rename: "foreach_iterator_sets"
selection = selected("Table")

if bundle$ = "Don't bundle"
  # Execute once each for every object,
  # regardless of what object it is.
elsif bundle$ = "Per type"
  # Execute a number of times equal to the largest number of
  # objects of the same type, with a selection made of one
  # object of each selected type. If sets of objects are of
  # unequal length, the shorter set(s) will loop.

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
  runScript: selection$ + "restore_selection.praat"
endif

procedure for_each.before_iteration ()
  @createEmptySelectionTable()
  foreach.final_selection = createEmptySelectionTable.table
  selectObject: foreach.final_selection
  Rename: "foreach_final_selection"
endproc

procedure for_each.action ()
  @trace: "For each: Execute " + action$
  runScript: action$
  @trace: "For each: adding to final selection"
  for .i to numberOfSelected()
    @addToSelectionTable: foreach.final_selection, selected(.i)
  endfor
endproc

procedure for_each.finally ()
  @restoreSavedSelection(foreach.final_selection)
  if !numberOfSelected()
    @restoreSavedSelection(selection)
  endif
  removeObject: foreach.final_selection
endproc

include ../../plugin_vieweach/procedures/for_each.proc
@for_each()

removeObject: selection
if bundle$ = "Don't bundle"
elsif bundle$ = "Per type"
  for i to Object_'objects'.nrow
    removeObject: set[i]
  endfor
  removeObject: objects
elsif bundle$ = "Use sets"
endif
