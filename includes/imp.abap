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
  ENDMETHOD.                    "constructor

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
      IF gv_dis_panel = abap_true.
        ready_marker = 'ID6'.
      ELSE.
        ready_marker = 'ID4'.
      ENDIF.
    ELSEIF rbut5 = 'X'.
      ready_marker = 'ID5'.
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
      IF screen-group1 = 'ID1' OR screen-group1 = 'ID2' OR screen-group1 = 'ID3' OR screen-group1 = 'ID4' OR screen-group1 = 'ID5' OR screen-group1 = 'ID6'.
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
          IF screen-group1 = 'ID2' OR screen-group1 = 'ID3' OR screen-group1 = 'ID4' OR screen-group1 = 'ID5' OR screen-group1 = 'ID6'.
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
          IF screen-group1 = 'ID1' OR screen-group1 = 'ID3' OR screen-group1 = 'ID4' OR screen-group1 = 'ID5' OR screen-group1 = 'ID6'.
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
          IF screen-group1 = 'ID1' OR screen-group1 = 'ID2' OR screen-group1 = 'ID4' OR screen-group1 = 'ID5' OR screen-group1 = 'ID6'.
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
          IF screen-group1 = 'ID1' OR screen-group1 = 'ID2' OR screen-group1 = 'ID3' OR screen-group1 = 'ID5' OR screen-group1 = 'ID6'.
            screen-invisible = '1'.
            screen-input = '0'.
            MODIFY SCREEN.
          ELSE.
            screen-invisible = '0'.
            screen-input = '1'.
            MODIFY SCREEN.
          ENDIF.
        ENDLOOP.
      WHEN 'ID5'.
        LOOP AT SCREEN.
          IF screen-group1 = 'ID1' OR screen-group1 = 'ID2' OR screen-group1 = 'ID3' OR screen-group1 = 'ID4' OR screen-group1 = 'ID6'.
            screen-invisible = '1'.
            screen-input = '0'.
            MODIFY SCREEN.
          ELSE.
            screen-invisible = '0'.
            screen-input = '1'.
            MODIFY SCREEN.
          ENDIF.
        ENDLOOP.
      WHEN 'ID6'.
        LOOP AT SCREEN.
          IF screen-group1 = 'ID1' OR screen-group1 = 'ID2' OR screen-group1 = 'ID3' OR screen-group1 = 'ID4' OR screen-group1 = 'ID5'.
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
    DATA: decision TYPE string.
    decision = i_lo_warner->issue_insertion_warning( ).
    CASE decision.
      WHEN '1'.
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
      WHEN '2'.
        LEAVE LIST-PROCESSING.
    ENDCASE.
  ENDMETHOD.                    "carry_out_action
ENDCLASS.                    "lcl_customer_inserter IMPLEMENTATION

*----------------------------------------------------------------------*
*       CLASS lcl_customer_displayer IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_customer_displayer IMPLEMENTATION.
  METHOD constructor.
    me->lo_salv = i_lo_salv.
  ENDMETHOD.                    "constructor

  METHOD lif_action~carry_out_action.
    gather_data( ).
    DATA: lmao TYPE zbmierzwi_tt_kna1.
    lmao = get_mt_customer( ). "lolz, czy to ma sens? Changing nie przyjmuje gettera... A salv życzy sobie changing a nie importing.
    lo_salv->display_alv( EXPORTING i_mode = 'CUST'
                          CHANGING c_lt_tab = lmao ).     "Czy lepiej tworzyć (NEW) obiekt salv w każdej klasie, gdy jest potrzebny czy klasy powinny mieć pole type ref tego salva i przyjmować stworzony obiekt w konstruktorze?
  ENDMETHOD.                    "carry_out_action

  METHOD gather_data.
    DATA: lt_customer TYPE zbmierzwi_tt_kna1.
    SELECT kunnr land1 name1 ort01 pstlz
      FROM kna1
      INTO CORRESPONDING FIELDS OF TABLE lt_customer
      WHERE kunnr IN sl_kunn2.
      set_mt_customer( EXPORTING i_mt_customer = lt_customer ).
  ENDMETHOD.                    "gather_data

  METHOD get_mt_customer.
    r_mt_customer = mt_customer.
  ENDMETHOD.                    "get_mt_customer

  METHOD set_mt_customer.
    mt_customer = i_mt_customer.
  ENDMETHOD.                    "set_mt_customer

*  METHOD get_m_salv.
*    r_m_salv = m_salv.
*  ENDMETHOD.                    "get_mt_salv
ENDCLASS.                    "lcl_customer_displayer IMPLEMENTATION

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
    ENDCASE.
  ENDMETHOD.                    "carry_out_action
ENDCLASS.                    "lcl_customer_remover IMPLEMENTATION

*----------------------------------------------------------------------*
*       CLASS lcl_customer_updater IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_customer_updater IMPLEMENTATION.
  METHOD lif_action~carry_out_action.
    IF sy-ucomm = 'FC6'.
      DATA: decision TYPE string.
      decision = i_lo_warner->issue_updation_warning( ).
      CASE decision.
        WHEN '1'.
          update_customer( ).
            IF sy-subrc = 0.
              MESSAGE 'The customer updated!' TYPE 'I'.
            ENDIF.
        WHEN '2'.
          LEAVE LIST-PROCESSING.
        ENDCASE.
    ELSE.
       gather_data( ).
       set_gv_dis_panel( ).
    ENDIF.
  ENDMETHOD.                    "carry_out_action

  METHOD gather_data.
    SELECT kunnr land1 name1 ort01 pstlz
      FROM kna1
      INTO (p_kunnr4, p_land12, p_name12, p_ort012, p_pstlz2)
      WHERE kunnr = p_kunnr3.
    ENDSELECT.
  ENDMETHOD.                    "gather_data

  METHOD update_customer.
    DATA: lwa_customer TYPE kna1.
    lwa_customer-kunnr = p_kunnr4.
    lwa_customer-land1 = p_land12.
    lwa_customer-name1 = p_name12.
    lwa_customer-ort01 = p_ort012.
    lwa_customer-pstlz = p_pstlz2.
    UPDATE kna1 FROM lwa_customer.
  ENDMETHOD.                    "update_customer

  METHOD set_gv_dis_panel.
    gv_dis_panel = abap_true.
  ENDMETHOD.                    "set_gv_dis_panel
ENDCLASS.                    "lcl_customer_updater

*----------------------------------------------------------------------*
*       CLASS lcl_warner IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_warner IMPLEMENTATION.
  METHOD: issue_insertion_warning.
    DATA: lv_answer TYPE string.
    CALL FUNCTION 'POPUP_WITH_2_BUTTONS_TO_CHOOSE'
      EXPORTING
        diagnosetext1       = 'Do you really want to insert the customer?'
        textline1           = space
        textline2           = space
        text_option1        = 'Yes'
        text_option2        = 'No'
        titel               = 'The customer is about to be inserted!'
      IMPORTING
        answer              = lv_answer.
    chosen_option = lv_answer.
  ENDMETHOD.                    "issue_insertion_warning

  METHOD: issue_updation_warning.
    DATA: lv_answer TYPE string.
    CALL FUNCTION 'POPUP_WITH_2_BUTTONS_TO_CHOOSE'
      EXPORTING
        diagnosetext1       = 'Do you really want to update the customer?'
        textline1           = space
        textline2           = space
        text_option1        = 'Yes'
        text_option2        = 'No'
        titel               = 'The customer is about to be updated!'
      IMPORTING
        answer              = lv_answer.
    chosen_option = lv_answer.
  ENDMETHOD.                    "issue_updation_warning

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
    IF sy-ucomm = 'FC1' OR sy-ucomm = 'FC2' OR sy-ucomm = 'FC3' OR sy-ucomm = 'FC4' OR sy-ucomm = 'FC5' OR sy-ucomm = 'FC6'.
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
*       CLASS lcl_orders_provider IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_orders_provider IMPLEMENTATION.
  METHOD constructor.
    me->lo_salv2 = i_lo_salv.
  ENDMETHOD.                    "constructor

  METHOD lif_action~carry_out_action.
    gather_data( ).
    display_the_contents( ).
  ENDMETHOD.                    "carry_out_action

  METHOD gather_data.
    SELECT vbeln erzet erdat route btgew gewei
      FROM likp
      INTO CORRESPONDING FIELDS OF TABLE mt_orders
      WHERE kunnr IN sl_kunnr.
  ENDMETHOD.                    "gather_data

  METHOD display_the_contents.
    DATA: lmao TYPE zbmierzwi_tt_orders.
    lmao = get_mt_orders( ).
    lo_salv2->display_alv( EXPORTING i_mode = 'ORDE'
                          CHANGING c_lt_tab = lmao ).
  ENDMETHOD.                    "display_the_contents

  METHOD get_mt_orders.
    r_mt_orders = mt_orders.
  ENDMETHOD.                    "get_mt_orders
ENDCLASS.                    "lcl_orders_provider IMPLEMENTATION

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
      DATA(lo_salv) = NEW lcl_salv( ).
      DATA(lo_orders_provider) = NEW lcl_orders_provider( i_lo_salv = lo_salv ).
      e_o_action = lo_orders_provider.
    ELSEIF rbut3 = 'X'.
      DATA(lo_customer_remover) = NEW lcl_customer_remover( ).
      e_o_action = lo_customer_remover.
    ELSEIF rbut4 = 'X'.
      DATA(lo_customer_updater) = NEW lcl_customer_updater( ).
      e_o_action = lo_customer_updater.
    ELSEIF rbut5 = 'X'.
      DATA(lo_salv2) = NEW lcl_salv( ).
      DATA(lo_customer_displayer) = NEW lcl_customer_displayer( i_lo_salv = lo_salv2 ).
      e_o_action = lo_customer_displayer.
    ENDIF.
  ENDMETHOD.                    "provide_object
ENDCLASS.                    "lcl_factory IMPLEMENTATION

*----------------------------------------------------------------------*
*       CLASS lcl_salv IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_salv IMPLEMENTATION.
  METHOD display_alv.
    prepare_data( CHANGING c_lt_tab = c_lt_tab ).
    IF i_mode = 'CUST'.
      change_columns_customer( ).
    ELSEIF i_mode = 'ORDE'.
      change_columns_orders( ).
    ENDIF.
    alv_table->display( ).
  ENDMETHOD.                    "display_alv

  METHOD prepare_data.
    TRY.
        cl_salv_table=>factory(
          IMPORTING
            r_salv_table   = alv_table
          CHANGING
            t_table        = c_lt_tab ).
      CATCH cx_salv_msg .
    ENDTRY.
    alv_table->get_functions( )->set_all( abap_true ).
    alv_table->get_columns( )->set_optimize( abap_true ).
  ENDMETHOD.                    "prepare_data

  METHOD change_columns_customer.
    alv_columns = alv_table->get_columns( ).
    change_column_header( i_columnname = 'KUNNR' i_long_text = 'Customer number'(019) i_medium_text = 'Customer number'(020) i_short_text = 'Cust num'(021) ).
    change_column_header( i_columnname = 'LAND1' i_long_text = 'Country code'(022) i_medium_text = 'Country code'(023) i_short_text = 'Ct code'(024) ).
    change_column_header( i_columnname = 'NAME1' i_long_text = 'Name'(025) i_medium_text = 'Name'(026) i_short_text = 'Name'(027) ).
    change_column_header( i_columnname = 'ORT01' i_long_text = 'City'(028) i_medium_text = 'City'(029) i_short_text = 'City'(030) ).
    change_column_header( i_columnname = 'PSTLZ' i_long_text = 'Postal code'(031) i_medium_text = 'Postal code'(032) i_short_text = 'Post code'(033) ).
  ENDMETHOD.                    "change_columns_customer

  METHOD change_columns_orders.
    alv_columns = alv_table->get_columns( ).
    change_column_header( i_columnname = 'VBELN' i_long_text = 'Delivery'(034) i_medium_text = 'Delivery'(035) i_short_text = 'Delivery'(036) ).
    change_column_header( i_columnname = 'ERZET' i_long_text = 'Time'(037) i_medium_text = 'Time'(038) i_short_text = 'Time'(039) ).
    change_column_header( i_columnname = 'ERDAT' i_long_text = 'Created on'(040) i_medium_text = 'Created on'(041) i_short_text = 'Created on'(042) ).
    change_column_header( i_columnname = 'ROUTE' i_long_text = 'Route'(043) i_medium_text = 'Route'(044) i_short_text = 'Route'(045) ).
    change_column_header( i_columnname = 'BTGEW' i_long_text = 'Total Weight'(046) i_medium_text = 'Total Weight'(047) i_short_text = 'T. Weight'(048) ).
    change_column_header( i_columnname = 'GEWEI' i_long_text = 'Unit'(049) i_medium_text = 'Unit'(050) i_short_text = 'Unit'(051) ).
  ENDMETHOD.                    "change_columns_orders

  METHOD change_column_header.
    TRY.
        alv_column = alv_columns->get_column( columnname = i_columnname ).
        alv_column->set_long_text( value = i_long_text ).
        alv_column->set_medium_text( value = i_medium_text ).
        alv_column->set_short_text( value = i_short_text ).
      CATCH cx_salv_not_found.
    ENDTRY.
  ENDMETHOD.                    "change_column_header.
ENDCLASS.                    "lcl_salv IMPLEMENTATION

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