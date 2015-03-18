vieweach
========

Description
-----------

This plugin defines a set of procedures that are designed to serve as a template for iteration over a large number of objects either from disk or from Praat's object list.

The default behaviour of the procedures is to go over each object and open an editor for each, allowing the user to interact with each one. However, the plugin has been written allowing for extensive modification of this behaviour by means of procedure redefinition.

This method makes use of the fact that, once a procedure has been defined, any further definitions are ignored. This feature is exploited to allow the user to change the behaviour of a number of procedures that are called throughout the iteration, which then work as hooks.

This allows the user to make use of a robust and unified interface for looping through objects, while at the same time allowing for practically complete control over what happens during those iterations.

Requirements
------------

* [selection](https://gitlab.com/cpran/plugin_selection)
* [strutils](https://gitlab.com/cpran/plugin_strutils)
* [utils](https://gitlab.com/cpran/plugin_utils)
