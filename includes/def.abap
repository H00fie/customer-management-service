*&---------------------------------------------------------------------*
*&  Include           CUSTOMER_MANAGEMENT_SERVICE_DEF
*&---------------------------------------------------------------------*

*----------------------------------------------------------------------*
*       CLASS lcl_params_validator DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_params_validator DEFINITION.
  PUBLIC SECTION.
    METHODS: check_if_initial.
  PRIVATE SECTION.
    METHODS: check_kunnr,
      check_land1,
      check_name1,
      check_ort01,
      check_pstlz.
ENDCLASS.                    "lcl_params_validator DEFINITION

*----------------------------------------------------------------------*
*       CLASS lcl_visibility_dispenser DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_visibility_dispenser DEFINITION.
  PUBLIC SECTION.
    METHODS: make_all_blocks_inv,
             make_block_visible IMPORTING marker TYPE string.
ENDCLASS.                    "lcl_visibility_dispenser DEFINITION

*----------------------------------------------------------------------*
*       CLASS lcl_element_remover DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_element_remover DEFINITION.
  PUBLIC SECTION.
    METHODS: hide_onli.
ENDCLASS.                    "lcl_element_remover DEFINITION

*----------------------------------------------------------------------*
*       CLASS lcl_warner DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_warner DEFINITION.
  PUBLIC SECTION.
    METHODS: issue_insertion_warning RETURNING VALUE(chosen_option) TYPE string,
             issue_deletion_warning  RETURNING VALUE(chosen_option) TYPE string.
ENDCLASS.                    "lcl_warner

*----------------------------------------------------------------------*
*       INTERFACE lif_action DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
INTERFACE lif_action.
    METHODS: carry_out_action IMPORTING i_lo_warner TYPE REF TO lcl_warner.
ENDINTERFACE.                "lif_action DEFINITION

*----------------------------------------------------------------------*
*       CLASS lcl_screen_adjuster DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_screen_adjuster DEFINITION.
  PUBLIC SECTION.
    METHODS: constructor IMPORTING i_lo_element_remover      TYPE REF TO lcl_element_remover
                                   i_lo_visibility_dispenser TYPE REF TO lcl_visibility_dispenser,
             adjust_screen.
  PRIVATE SECTION.
    METHODS: decide_the_marker RETURNING VALUE(ready_marker) TYPE string.
    DATA: lo_element_remover      TYPE REF TO lcl_element_remover,
          lo_visibility_dispenser TYPE REF TO lcl_visibility_dispenser.
ENDCLASS.                   "lcl_screen_adjuster DEFINITION

*----------------------------------------------------------------------*
*       CLASS lcl_customer_inserter DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_customer_inserter DEFINITION.
  PUBLIC SECTION.
    INTERFACES: lif_action.
ENDCLASS.                    "lcl_customer_inserter DEFINITION

*----------------------------------------------------------------------*
*       CLASS lcl_customer_displayer DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_customer_displayer DEFINITION.
  PUBLIC SECTION.
    INTERFACES: lif_action.
    METHODS: get_mt_customer RETURNING VALUE(r_mt_customer) TYPE zbmierzwi_tt_kna1,
             set_mt_customer IMPORTING i_mt_customer TYPE STANDARD TABLE.
  PRIVATE SECTION.
    METHODS: gather_data.
    DATA: mt_customer TYPE zbmierzwi_tt_kna1.
ENDCLASS.                    "lcl_customer_displayer DEFINITION

*----------------------------------------------------------------------*
*       CLASS lcl_customer_remover DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_customer_remover DEFINITION.
  PUBLIC SECTION.
    INTERFACES: lif_action.
ENDCLASS.                    "lcl_customer_remover DEFINITION

*----------------------------------------------------------------------*
*       CLASS lcl_customer_updater DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_customer_updater DEFINITION.
  PUBLIC SECTION.
    INTERFACES: lif_action.
  PRIVATE SECTION.
    METHODS: gather_data,
             set_gv_dis_panel.
ENDCLASS.                    "lcl_customer_updater

*----------------------------------------------------------------------*
*       CLASS lcl_orders_provider DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_orders_provider DEFINITION.
  PUBLIC SECTION.
    INTERFACES: lif_action.
  PRIVATE SECTION.
    METHODS: gather_data,
             display_the_contents.
ENDCLASS.                    "lcl_orders_provider DEFINITION

*----------------------------------------------------------------------*
*       CLASS lcl_action_handler DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_action_handler DEFINITION.
  PUBLIC SECTION.
    METHODS: constructor IMPORTING i_o_action TYPE REF TO lif_action
                                   i_o_warner TYPE REF TO lcl_warner,
             decide_action,
             get_lo_action RETURNING VALUE(r_lo_action) TYPE REF TO lif_action,
             get_lo_warner RETURNING VALUE(r_lo_warner) TYPE REF TO lcl_warner.
  PRIVATE SECTION.
    DATA: lo_action TYPE REF TO lif_action,
          lo_warner TYPE REF TO lcl_warner.
ENDCLASS.                    "lcl_action_handler DEFINITION

*----------------------------------------------------------------------*
*       CLASS lcl_factory DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_factory DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS: provide_object RETURNING VALUE(e_o_action) TYPE REF TO lif_action.
ENDCLASS.                    "lcl_factory DEFINITION

*TO BE INCLUDED WITHIN THE DATA DICTIONARY
*Component    Typing Method   Component Type
*  KUNNR          TYPE            KUNNR
*  LAND1          TYPE           LAND1_GP
*  NAME1          TYPE           NAME1_GP
*  ORT01          TYPE           ORT01_GP
*  PSTLZ          TYPE            PSTLZ