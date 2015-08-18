# View each selected object, pairing Sound and TextGrid objects
# in turn if available
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

@saveSelectionTable()
original_selection = saveSelectionTable.table
selectObject: original_selection
Rename: "original_selection"
@restoreSavedSelection: original_selection

sounds = numberOfSelected("Sound")
textgrids = numberOfSelected("TextGrid")

if sounds and textgrids and sounds + textgrids = numberOfSelected()
  paired = 1
  selectObject: original_selection
  sounds    = nowarn Extract rows where column (text): "type", "is equal to", "Sound"
  selectObject: original_selection
  textgrids = nowarn Extract rows where column (text): "type", "is equal to", "TextGrid"
  selectObject: sounds, textgrids
else
  paired = 0
  selectObject: original_selection
endif

@view_each()

if paired
  removeObject: sounds, textgrids
endif

@restoreSavedSelection: original_selection
removeObject: original_selection
