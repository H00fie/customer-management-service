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
      MESSAGE s000(zbmierzwi_test_msg) DISPLAY LIKE 'E'.
      LEAVE LIST-PROCESSING.
    ENDIF.
  ENDMETHOD.                    "check_kunnr

  METHOD check_land1.
    IF p_land1 IS INITIAL.
      MESSAGE s001(zbmierzwi_test_msg) DISPLAY LIKE 'E'.
      LEAVE LIST-PROCESSING.
    ENDIF.
  ENDMETHOD.                    "check_land1

  METHOD check_name1.
    IF p_name1 IS INITIAL.
      MESSAGE s002(zbmierzwi_test_msg) DISPLAY LIKE 'E'.
      LEAVE LIST-PROCESSING.
    ENDIF.
  ENDMETHOD.                    "check_name1

  METHOD check_ort01.
    IF p_ort01 IS INITIAL.
      MESSAGE s003(zbmierzwi_test_msg) DISPLAY LIKE 'E'.
      LEAVE LIST-PROCESSING.
    ENDIF.
  ENDMETHOD.                    "check_ort01

  METHOD check_pstlz.
    IF p_pstlz IS INITIAL.
      MESSAGE s004(zbmierzwi_test_msg) DISPLAY LIKE 'E'.
      LEAVE LIST-PROCESSING.
    ENDIF.
  ENDMETHOD.                    "check_pstlz
ENDCLASS.                    "lcl_params_validator IMPLEMENTATION

*----------------------------------------------------------------------*
*       CLASS lcl_visibility_dispenser IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_visibility_dispenser IMPLEMENTATION.
  METHOD make_all_blocks_inv.
    LOOP AT SCREEN.
      IF screen-group1 = 'ID1' OR screen-group1 = 'ID2'.
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
          IF screen-group1 = 'ID2'.
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
          IF screen-group1 = 'ID1'.
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
*       CLASS lcl_customer_inserter IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_customer_inserter IMPLEMENTATION.
  METHOD insert_new_customer.
    DATA: lwa_customer TYPE kna1.
    lwa_customer-kunnr = p_kunnr.
    lwa_customer-land1 = p_land1.
    lwa_customer-name1 = p_name1.
    lwa_customer-ort01 = p_ort01.
    lwa_customer-pstlz = p_pstlz.

    INSERT kna1 FROM lwa_customer.
  ENDMETHOD.                    "make_block_visible
ENDCLASS.                    "lcl_customer_inserter IMPLEMENTATION

CLASS lcl_action_handler IMPLEMENTATION.
  METHOD constructor.
    lo_customer_inserter = i_o_customer_inserter.
  ENDMETHOD.

  METHOD decide_action.
    CASE sy-ucomm.
      WHEN 'FC1'.
        lo_customer_inserter->insert_new_customer( ).
        IF sy-subrc = 0.
          MESSAGE 'The customer inserted successfully.' TYPE 'I'.
        ELSE.
          MESSAGE 'The insertion failed.' TYPE 'I'.
        ENDIF.
    ENDCASE.
  ENDMETHOD.
ENDCLASS.

*MESSAGES TO BE INCLUDED IN THE MESSAGE CLASS.
*-----------Attributes Sheet-----------
*Short description - Messages for Customer Management Service.
*---------------Messages---------------
*000 - Please, provide the customer's number.
*001 - Please, provide the customer's country.
*002 - Please, provide the customer's name.
*003 - Please, provide the customer's city.
*004 - Please, provide the customer's postal code.