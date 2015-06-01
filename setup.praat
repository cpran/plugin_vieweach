# Setup script for vieweach
#
# Find the latest version of this plugin at
# https://gitlab.com/cpran/plugin_vieweach
#
# Written by Jose Joaquín Atria
#
# This script is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# A copy of the GNU General Public License is available at
# <http://www.gnu.org/licenses/>.

## Static commands:

# Uncomment next line to run tests at startup
# runScript: "run_tests.praat"

# Base menu
Add menu command: "Objects", "Praat", "vieweach", "CPrAN", 1, ""

Add menu command: "Objects", "Praat", "Execute for each...",   "vieweach", 2, "scripts/for_each.praat"
Add menu command: "Objects", "Praat", "View each (selected)",  "vieweach", 2, "scripts/view_each.selected.praat"
Add menu command: "Objects", "Praat", "View each (from disk)", "vieweach", 2, "scripts/view_each.from_disk.praat"

Add action command: "Sound", 0, "TextGrid", 0, "", 0, "View each as pairs", "", 0, "scripts/view_each.selected.praat"

# Dynamic menu

Add action command: "AmplitudeTier", 0, "", 0, "", 0, "View each", "", 0, "scripts/view_each.selected.praat"
Add action command: "Artword",       0, "", 0, "", 0, "View each", "", 0, "scripts/view_each.selected.praat"
Add action command: "DurationTier",  0, "", 0, "", 0, "View each", "", 0, "scripts/view_each.selected.praat"
Add action command: "FormantGrid",   0, "", 0, "", 0, "View each", "", 0, "scripts/view_each.selected.praat"
Add action command: "IntensityTier", 0, "", 0, "", 0, "View each", "", 0, "scripts/view_each.selected.praat"
Add action command: "LongSound",     0, "", 0, "", 0, "View each", "", 0, "scripts/view_each.selected.praat"
Add action command: "Manipulation",  0, "", 0, "", 0, "View each", "", 0, "scripts/view_each.selected.praat"
Add action command: "OTGrammar",     0, "", 0, "", 0, "View each", "", 0, "scripts/view_each.selected.praat"
Add action command: "Pitch",         0, "", 0, "", 0, "View each", "", 0, "scripts/view_each.selected.praat"
Add action command: "PitchTier",     0, "", 0, "", 0, "View each", "", 0, "scripts/view_each.selected.praat"
Add action command: "PointProcess",  0, "", 0, "", 0, "View each", "", 0, "scripts/view_each.selected.praat"
Add action command: "Sound",         0, "", 0, "", 0, "View each", "", 0, "scripts/view_each.selected.praat"
Add action command: "Spectrogram",   0, "", 0, "", 0, "View each", "", 0, "scripts/view_each.selected.praat"
Add action command: "Spectrum",      0, "", 0, "", 0, "View each", "", 0, "scripts/view_each.selected.praat"
Add action command: "Strings",       0, "", 0, "", 0, "View each", "", 0, "scripts/view_each.selected.praat"
Add action command: "Table",         0, "", 0, "", 0, "View each", "", 0, "scripts/view_each.selected.praat"
Add action command: "TextGrid",      0, "", 0, "", 0, "View each", "", 0, "scripts/view_each.selected.praat"
