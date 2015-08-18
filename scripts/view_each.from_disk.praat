# View specified objects from disk, pairing Sound and TextGrid
# objects in turn if available
#
# The script allows for easy navigation between selected objects,
# which is particularly useful when comparing specific features
# in each of them. If both TextGrid and Sound objects have been
# selected, they will be paired by name and viewed in unison.
#
# Pairing is done by @foreach(), which takes objects representing
# sets of items and performs actions for corresponding objects in
# each set. If the number of items in each set (ie. Sound and
# TextGrid objects) is different, then the shorter list will loop
# as many times as necessary to provide an entry for the longer list.
#
# Written by Jose J. Atria (October 14, 2012)
# Last revision: May 29, 2015)
#
# This script is free software: you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation, either version 3 of
# the License, or (at your option) any later version.
#
# A copy of the GNU General Public License is available at
# <http://www.gnu.org/licenses/>.

include ../../plugin_vieweach/procedures/view_each.proc
include ../../plugin_utils/procedures/check_directory.proc
include ../../plugin_strutils/procedures/file_list_full_path.proc
include ../../plugin_strutils/procedures/extract_strings.proc

form View each (from disk)...
  sentence Read_from
  sentence Filename_regex (wav|TextGrid)$
endform

@checkDirectory: read_from$, "Read files from..."
path$ = checkDirectory.name$

@fileListFullPath: "files", path$, "*", 0
files = fileListFullPath.id

@extractStrings: filename_regex$
removeObject: files
files = extractStrings.id

total_files = Get number of strings

runScript: preferencesDirectory$ - "con" +
  ... "/plugin_strutils/scripts/extract_strings.praat", "wav$"
sounds = selected("Strings")
total_sounds = Get number of strings

selectObject: files
runScript: preferencesDirectory$ - "con" +
  ... "/plugin_strutils/scripts/extract_strings.praat", "TextGrid$"
textgrids = selected("Strings")
total_textgrids = Get number of strings

if total_sounds and total_textgrids and
    ... total_sounds + total_textgrids = total_files
  paired = 1
  selectObject: sounds, textgrids
else
  paired = 0
  selectObject: files
endif

@view_each()

if paired
  removeObject: sounds, textgrids
endif

removeObject: files
