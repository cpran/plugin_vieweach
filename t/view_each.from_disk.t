include ../../plugin_testsimple/procedures/more.proc
include ../../plugin_utils/procedures/utils.proc
include ../../plugin_utils/procedures/try.proc
include ../../plugin_selection/procedures/tables.proc

selection$ = preferencesDirectory$ + "/plugin_selection/scripts/"
utils$     = preferencesDirectory$ + "/plugin_utils/scripts/"

@mktemp: "test.XXXX"

@no_plan()

runScript: "make_objects.praat"

runScript: utils$ + "save_all.praat", mktemp.return$, "yes"
Remove

select all
@saveSelectionTable()
all = saveSelectionTable.table

call try runScript: "../scripts/view_each.from_disk.praat",
  ... "'mktemp.return$'", "\.(wav|TextGrid)$"

select all
@minusSavedSelection: all
plusObject: all
nocheck Remove

@ok: !try.catch, "run script without error"

list = Create Strings as file list: "files",
  ... mktemp.return$ + "*"
files = Get number of strings
for i to files
  filename$ = Get string: i
  deleteFile: mktemp.return$ + filename$
endfor
deleteFile: mktemp.return$

removeObject: list

@ok: !fileReadable(mktemp.return$),
  ... "removed temporary directory"

@ok_selection()

@done_testing()
