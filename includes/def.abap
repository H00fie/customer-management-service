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
             issue_deletion_warning  RETURNING VALUE(chosen_option) TYPE string,
             issue_updation_warning  RETURNING VALUE(chosen_option) TYPE string.
ENDCLASS.                    "lcl_warner

*----------------------------------------------------------------------*
*       INTERFACE lif_action
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
INTERFACE lif_action.
    METHODS: carry_out_action IMPORTING i_lo_warner TYPE REF TO lcl_warner.
ENDINTERFACE.                "lif_action

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
*       CLASS lcl_salv DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_salv DEFINITION.
  PUBLIC SECTION.
    METHODS: display_alv IMPORTING i_mode TYPE string
                         CHANGING c_lt_tab TYPE ANY TABLE.
  PRIVATE SECTION.
    METHODS: prepare_data CHANGING c_lt_tab TYPE ANY TABLE,
             change_columns_customer,
             change_columns_orders,
             change_column_header IMPORTING i_columnname  TYPE c
                                            i_long_text   TYPE c
                                            i_medium_text TYPE c
                                            i_short_text  TYPE c.
    DATA: alv_table   TYPE REF TO cl_salv_table,
          alv_columns TYPE REF TO cl_salv_columns_table,
          alv_column  TYPE REF TO cl_salv_column.
ENDCLASS.                    "lcl_salv DEFINITION

*----------------------------------------------------------------------*
*       CLASS lcl_xml_creator DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_xml_creator DEFINITION.
  PUBLIC SECTION.
    METHODS: create_xml IMPORTING i_customer TYPE zbmierzwi_tt_kna1.
ENDCLASS.                    "lcl_xml_creator DEFINITION

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
    METHODS: constructor     IMPORTING i_lo_salv            TYPE REF TO lcl_salv
                                       i_lo_xml_creator     TYPE REF TO lcl_xml_creator,
             get_mt_customer RETURNING VALUE(r_mt_customer) TYPE zbmierzwi_tt_kna1,
             set_mt_customer IMPORTING i_mt_customer        TYPE STANDARD TABLE.
  PRIVATE SECTION.
    METHODS: gather_data,
             alv_or_xml,
             prepare_alv,
             prepare_xml.
    DATA: mt_customer    TYPE zbmierzwi_tt_kna1,
          lo_salv        TYPE REF TO lcl_salv,
          lo_xml_creator TYPE REF TO lcl_xml_creator.
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
             update_customer,
             set_gv_dis_panel IMPORTING i_flag TYPE boolean.
ENDCLASS.                    "lcl_customer_updater

*----------------------------------------------------------------------*
*       CLASS lcl_orders_provider DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_orders_provider DEFINITION.
  PUBLIC SECTION.
    INTERFACES: lif_action.
    METHODS: constructor IMPORTING i_lo_salv TYPE REF TO lcl_salv,
             get_mt_orders RETURNING VALUE(r_mt_orders) TYPE zbmierzwi_tt_orders.
  PRIVATE SECTION.
    METHODS: gather_data,
             display_the_contents.
    DATA: mt_orders TYPE zbmierzwi_tt_orders,
          lo_salv TYPE REF TO lcl_salv.
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