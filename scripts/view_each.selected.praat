# View each selected object, pairing Sound and TextGrid objects
# in turn if available
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

selection.restore_nocheck = 1
@restoreSavedSelection: original_selection
removeObject: original_selection
