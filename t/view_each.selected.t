include ../../plugin_testsimple/procedures/more.proc
include ../../plugin_utils/procedures/utils.proc
include ../../plugin_utils/procedures/try.proc
include ../../plugin_selection/procedures/tables.proc

selection$ = preferencesDirectory$ + "/plugin_selection/scripts/"
utils$     = preferencesDirectory$ + "/plugin_utils/scripts/"

@no_plan()

# Make test objects
runScript: "make_objects.praat"
@saveSelectionTable()
objects = saveSelectionTable.table

# Register all existing objects, before trying script
select all
@saveSelectionTable()
all = saveSelectionTable.table

# Restore selection of test objects
@restoreSavedSelection: objects

call try runScript: "../scripts/view_each.selected.praat"

# Remove any objects that might have been left
# from a failed run of the script
select all
@minusSavedSelection: all
minusObject: all
nocheck Remove

@ok: !try.catch, "run script without error"

# Remove test objects
@restoreSavedSelection: objects
Remove

# Remove selection tables
removeObject: all, objects

@ok_selection()

@done_testing()
