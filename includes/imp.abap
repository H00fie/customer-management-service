*&---------------------------------------------------------------------*
*&  Include           CUSTOMER_MANAGEMENT_SERVICE_IMP
*&---------------------------------------------------------------------*

*----------------------------------------------------------------------*
*       CLASS lcl_params_validator IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_params_validator IMPLEMENTATION.
  METHOD check_if_initial.
    IF rbut1 = 'X'.
      check_kunnr( ).
      check_land1( ).
      check_name1( ).
      check_ort01( ).
      check_pstlz( ).
    ENDIF.
  ENDMETHOD.                    "check_if_initial

  METHOD check_kunnr.
    IF p_kunnr IS INITIAL.
      MESSAGE s000(customer_management_service) DISPLAY LIKE 'E'.
      LEAVE LIST-PROCESSING.
    ENDIF.
  ENDMETHOD.                    "check_kunnr

  METHOD check_land1.
    IF p_land1 IS INITIAL.
      MESSAGE s001(customer_management_service) DISPLAY LIKE 'E'.
      LEAVE LIST-PROCESSING.
    ENDIF.
  ENDMETHOD.                    "check_land1

  METHOD check_name1.
    IF p_name1 IS INITIAL.
      MESSAGE s002(customer_management_service) DISPLAY LIKE 'E'.
      LEAVE LIST-PROCESSING.
    ENDIF.
  ENDMETHOD.                    "check_name1

  METHOD check_ort01.
    IF p_ort01 IS INITIAL.
      MESSAGE s003(customer_management_service) DISPLAY LIKE 'E'.
      LEAVE LIST-PROCESSING.
    ENDIF.
  ENDMETHOD.                    "check_ort01

  METHOD check_pstlz.
    IF p_pstlz IS INITIAL.
      MESSAGE s004(customer_management_service) DISPLAY LIKE 'E'.
      LEAVE LIST-PROCESSING.
    ENDIF.
  ENDMETHOD.                    "check_pstlz
ENDCLASS.                    "lcl_params_validator IMPLEMENTATION

*----------------------------------------------------------------------*
*       CLASS lcl_screen_adjuster IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_screen_adjuster IMPLEMENTATION.
  METHOD constructor.
    me->lo_element_remover = i_lo_element_remover.
    me->lo_visibility_dispenser = i_lo_visibility_dispenser.
  ENDMETHOD.

  METHOD adjust_screen.
    lo_element_remover->hide_onli( ).
    lo_visibility_dispenser->make_block_visible( decide_the_marker( ) ).
  ENDMETHOD.                    "adjust_screen

  METHOD decide_the_marker.
    IF rbut1 = 'X'.
      ready_marker = 'ID1'.
    ELSEIF rbut2 = 'X'.
      ready_marker = 'ID2'.
    ELSEIF rbut3 = 'X'.
      ready_marker = 'ID3'.
    ELSEIF rbut4 = 'X'.
      ready_marker = 'ID4'.
    ENDIF.
  ENDMETHOD.                    "decide_the_marker
ENDCLASS.                    "lcl_screen_adjuster IMPLEMENTATION

*----------------------------------------------------------------------*
*       CLASS lcl_visibility_dispenser IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_visibility_dispenser IMPLEMENTATION.
  METHOD make_all_blocks_inv.
    LOOP AT SCREEN.
      IF screen-group1 = 'ID1' OR screen-group1 = 'ID2' OR screen-group1 = 'ID3' OR screen-group1 = 'ID4'.
        screen-invisible = '1'.
        screen-input = '0'.
        MODIFY SCREEN.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.                    "make_all_blocks_inv

  METHOD make_block_visible.
    CASE marker.
      WHEN 'ID1'.
        LOOP AT SCREEN.
          IF screen-group1 = 'ID2' OR screen-group1 = 'ID3' OR screen-group1 = 'ID4'.
            screen-invisible = '1'.
            screen-input = '0'.
            MODIFY SCREEN.
          ELSE.
            screen-invisible = '0'.
            screen-input = '1'.
            MODIFY SCREEN.
          ENDIF.
        ENDLOOP.
      WHEN 'ID2'.
        LOOP AT SCREEN.
          IF screen-group1 = 'ID1' OR screen-group1 = 'ID3' OR screen-group1 = 'ID4'.
            screen-invisible = '1'.
            screen-input = '0'.
            MODIFY SCREEN.
          ELSE.
            screen-invisible = '0'.
            screen-input = '1'.
            MODIFY SCREEN.
          ENDIF.
        ENDLOOP.
      WHEN 'ID3'.
        LOOP AT SCREEN.
          IF screen-group1 = 'ID1' OR screen-group1 = 'ID2' OR screen-group1 = 'ID4'.
            screen-invisible = '1'.
            screen-input = '0'.
            MODIFY SCREEN.
          ELSE.
            screen-invisible = '0'.
            screen-input = '1'.
            MODIFY SCREEN.
          ENDIF.
        ENDLOOP.
      WHEN 'ID4'.
        LOOP AT SCREEN.
          IF screen-group1 = 'ID1' OR screen-group1 = 'ID2' OR screen-group1 = 'ID3'.
            screen-invisible = '1'.
            screen-input = '0'.
            MODIFY SCREEN.
          ELSE.
            screen-invisible = '0'.
            screen-input = '1'.
            MODIFY SCREEN.
          ENDIF.
        ENDLOOP.
    ENDCASE.
  ENDMETHOD.                    "make_block_visible
ENDCLASS.                    "lcl_visibility_dispenser IMPLEMENTATION

*----------------------------------------------------------------------*
*       CLASS lcl_element_remover IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_element_remover IMPLEMENTATION.
  METHOD hide_onli.
    DATA: lt_tab TYPE TABLE OF sy-ucomm.
    APPEND 'ONLI' TO lt_tab.
    CALL FUNCTION 'RS_SET_SELSCREEN_STATUS'
      EXPORTING
        p_status        = sy-pfkey
      TABLES
        p_exclude       = lt_tab.
  ENDMETHOD.                    "hide_onli
ENDCLASS.                    "lcl_element_remover IMPLEMENTATION

*----------------------------------------------------------------------*
*       CLASS lcl_customer_inserter IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_customer_inserter IMPLEMENTATION.
  METHOD lif_action~carry_out_action.
    DATA: lwa_customer TYPE kna1.
    lwa_customer-kunnr = p_kunnr.
    lwa_customer-land1 = p_land1.
    lwa_customer-name1 = p_name1.
    lwa_customer-ort01 = p_ort01.
    lwa_customer-pstlz = p_pstlz.
    INSERT kna1 FROM lwa_customer.
    IF sy-subrc = 0.
      MESSAGE i005(customer_management_service).
    ELSE.
      MESSAGE i006(customer_management_service).
    ENDIF.
  ENDMETHOD.                    "make_block_visible
ENDCLASS.                    "lcl_customer_inserter IMPLEMENTATION

*----------------------------------------------------------------------*
*       CLASS lcl_customer_remover IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_customer_remover IMPLEMENTATION.
  METHOD: lif_action~carry_out_action.
    DATA: decision TYPE string.
    decision = i_lo_warner->issue_deletion_warning( ).
    CASE decision.
      WHEN '1'.
        DELETE FROM kna1 WHERE kunnr = p_kunnr2.
        IF sy-subrc = 0.
          MESSAGE i007(customer_management_service).
        ENDIF.
      WHEN '2'.
        LEAVE LIST-PROCESSING.
      WHEN OTHERS.
    ENDCASE.
  ENDMETHOD.                    "delete_customer
ENDCLASS.                    "lcl_customer_remover IMPLEMENTATION

*----------------------------------------------------------------------*
*       CLASS lcl_customer_updater IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_customer_updater IMPLEMENTATION.
  METHOD update_customer.
  ENDMETHOD.                    "update_customer
ENDCLASS.                    "lcl_customer_updater

*----------------------------------------------------------------------*
*       CLASS lcl_warner IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_warner IMPLEMENTATION.
  METHOD: issue_deletion_warning.
    DATA: lv_answer TYPE string.
    CALL FUNCTION 'POPUP_WITH_2_BUTTONS_TO_CHOOSE'
      EXPORTING
        diagnosetext1       = 'Do you really want to delete the customer?'
        textline1           = space
        textline2           = space
        text_option1        = 'Yes'
        text_option2        = 'No'
        titel               = 'The customer is about to be deleted!'
      IMPORTING
        answer              = lv_answer.
    chosen_option = lv_answer.
  ENDMETHOD.                    "issue_deletion_warning
ENDCLASS.                    "lcl_warner

*----------------------------------------------------------------------*
*       CLASS lcl_action_handler IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_action_handler IMPLEMENTATION.
  METHOD constructor.
    lo_action = i_o_action.
    lo_warner = i_o_warner.
  ENDMETHOD.                    "constructor

  METHOD decide_action.
    IF sy-ucomm = 'FC1' OR sy-ucomm = 'FC2' OR sy-ucomm = 'FC3'.
      get_lo_action( )->carry_out_action( get_lo_warner( ) ).
    ENDIF.
  ENDMETHOD.                    "decide_action

  METHOD get_lo_action.
    r_lo_action = lo_action.
  ENDMETHOD.                    "get_lo_action

  METHOD get_lo_warner.
    r_lo_warner = lo_warner.
  ENDMETHOD.                    "get_lo_warner
ENDCLASS.                    "lcl_customer_inserter IMPLEMENTATION

*----------------------------------------------------------------------*
*       CLASS lcl_cds_data_selector IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_cds_data_selector IMPLEMENTATION.
  METHOD lif_action~carry_out_action.
    gather_data( ).
    display_the_contents( ).
  ENDMETHOD.                    "supply_orders

  METHOD gather_data.
    SELECT vbeln erzet erdat route btgew
      FROM likp
      INTO CORRESPONDING FIELDS OF TABLE lt_orders
      WHERE kunnr IN sl_kunnr.
  ENDMETHOD.                    "gather_data

  METHOD display_the_contents.
    cl_demo_output=>new( )->begin_section( 'Orders found' )->write_data( lt_orders )->display( ).
  ENDMETHOD.                    "display_the_contents
ENDCLASS.                    "lcl_cds_data_selector IMPLEMENTATION

*----------------------------------------------------------------------*
*       CLASS lcl_factory IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_factory IMPLEMENTATION.
  METHOD provide_object.
    IF rbut1 = 'X'.
      DATA(lo_customer_inserter) = NEW lcl_customer_inserter( ).
      e_o_action = lo_customer_inserter.
    ELSEIF rbut2 = 'X'.
      DATA(lo_cds_data_selector) = NEW lcl_cds_data_selector( ).
      e_o_action = lo_cds_data_selector.
    ELSEIF rbut3 = 'X'.
      DATA(lo_customer_remover) = NEW lcl_customer_remover( ).
      e_o_action = lo_customer_remover.
    ENDIF.
  ENDMETHOD.
ENDCLASS.                    "lcl_factory IMPLEMENTATION

*MESSAGES TO BE INCLUDED IN THE MESSAGE CLASS.
*-----------Attributes Sheet-----------
*Short description - Messages for Customer Management Service.
*---------------Messages---------------
*000 - Please, provide the customer's number.
*001 - Please, provide the customer's country.
*002 - Please, provide the customer's name.
*003 - Please, provide the customer's city.
*004 - Please, provide the customer's postal code.
*005 - The customer inserted successfully.
*006 - The insertion failed.
*007 - The customer has been deleted successfully.