*&---------------------------------------------------------------------*
*&  Include           CUSTOMER_MANAGEMENT_SERVICE_DEF
*&---------------------------------------------------------------------*

*----------------------------------------------------------------------*
*       INTERFACE lif_action DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
INTERFACE lif_action.
ENDINTERFACE.                "lif_action DEFINITION

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
*       CLASS lcl_inv_applier DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_visibility_dispenser DEFINITION.
  PUBLIC SECTION.
    METHODS: make_all_blocks_inv,
             make_block_visible IMPORTING marker TYPE string.
ENDCLASS.                    "lcl_visibility_dispenser DEFINITION

*----------------------------------------------------------------------*
*       CLASS lcl_inv_applier DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_element_remover DEFINITION.
  PUBLIC SECTION.
    METHODS: hide_onli.
ENDCLASS.                    "lcl_element_remover DEFINITION

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
*       CLASS lcl_client_inserter DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_customer_inserter DEFINITION.
  PUBLIC SECTION.
    INTERFACES: lif_action.
    METHODS: insert_new_customer.
ENDCLASS.                    "lcl_client_inserter DEFINITION

*----------------------------------------------------------------------*
*       CLASS lcl_customer_remover DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_customer_remover DEFINITION.
  PUBLIC SECTION.
    INTERFACES: lif_action.
    METHODS: delete_customer.
ENDCLASS.                    "lcl_customer_remover DEFINITION

*----------------------------------------------------------------------*
*       CLASS lcl_cds_data_selector DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_cds_data_selector DEFINITION.
  PUBLIC SECTION.
    INTERFACES: lif_action.
    METHODS: supply_orders, "IMPORTING i_lt_seltab TYPE STANDARD TABLE.
*             get_seltab RETURNING VALUE(e_lt_seltab) TYPE TABLE selopttab.
             display_the_contents.
  PRIVATE SECTION.
    METHODS: gather_sl_data EXPORTING e_lt_seltab TYPE STANDARD TABLE.
    DATA: lt_seltab TYPE STANDARD TABLE OF selopttab.
ENDCLASS.                    "lcl_cds_data_selector DEFINITION

*----------------------------------------------------------------------*
*       CLASS lcl_action_handler DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_action_handler DEFINITION.
  PUBLIC SECTION.
    METHODS: constructor IMPORTING i_o_action TYPE REF TO lif_action,
             decide_action.
  PRIVATE SECTION.
    DATA: lo_customer_inserter TYPE REF TO lcl_customer_inserter,
          lo_cds_data_selector TYPE REF TO lcl_cds_data_selector,
          lo_customer_remover  TYPE REF TO lcl_customer_remover.
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