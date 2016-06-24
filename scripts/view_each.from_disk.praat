# View specified objects from disk, pairing Sound and TextGrid
# objects in turn if available
#
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
# Copyright 2012-2015 Jose Joaquin Atria

include ../../plugin_vieweach/procedures/view_each.proc
include ../../plugin_utils/procedures/check_directory.proc
include ../../plugin_strutils/procedures/file_list_full_path.proc
include ../../plugin_strutils/procedures/extract_strings.proc

strutils$ = preferencesDirectory$ + "/plugin_strutils/scripts/"

form View each (from disk)...
  sentence Read_from
  sentence Filename_regex (wav|TextGrid)$
endform

@checkDirectory: read_from$, "Read files from..."
path$ = checkDirectory.name$

@fileListFullPath: "files", path$, "*", 0
files = fileListFullPath.id

@extractStrings_regex: filename_regex$, 1
removeObject: files
files = extractStrings_regex.id

total_files = Get number of strings

runScript: strutils$ + "extract_strings.praat", "wav$", "matches", 1
sounds = selected("Strings")
total_sounds = Get number of strings

selectObject: files
runScript: strutils$ + "extract_strings.praat", "TextGrid$", "matches", 1
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
