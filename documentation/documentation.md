# Customer Management Service Documentation

---
# The flow of program's logic

---
Initially the user sees two blocks in the selection-screen - the one with radiobuttons for the program's mode's selection and the one associated with the "New customer's insertion" mode. This is because this is the default mode of the program.

In the **INITIALIZATION** event block the method **_make_all_blocks_inv_** is called on the object of **_lcl_visibility_dispenser_** class in order to make all screen elements invisible by default.
 
Changing the program's mode results in the change of the second block. **AT SELECTION-SCREEN OUTPUT** event block contains the **_adjust_screen_** method of **_lcl_screen_adjuster_** class which takes in the objects of **_lcl_element_remover_** and **_lcl_visibility_dispenser_** classes as parameters to its constructor. Firstly, the **_hide_onli_** method of the **_lcl_element_remover_** class is called on its respective field to hide the standard F8 button of SAP applications that will not be used by the program. Secondly, **_make_block_visible_** of the **_lcl_visibility_dispenser_** is called in the same manner while also taking in a parameter of the type **_string_** provided by the private **_decide_the_marker_** method of the **_lcl_screen_adjuster_** class.
