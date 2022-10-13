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
      make_block_visible IMPORTING marker TYPE c.
ENDCLASS.                    "lcl_visibility_dispenser DEFINITION

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
*       CLASS lcl_action_handler DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_action_handler DEFINITION.
  PUBLIC SECTION.
    METHODS: constructor IMPORTING i_o_action TYPE REF TO lif_action,
      decide_action.
  PRIVATE SECTION.
    DATA: lo_customer_inserter TYPE REF TO lcl_customer_inserter.
ENDCLASS.                    "lcl_action_handler DEFINITION