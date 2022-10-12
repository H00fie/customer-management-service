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
    ENDIF.
  ENDMETHOD.                    "check_if_initial

  METHOD check_kunnr.
    IF p_kunnr IS INITIAL.
      MESSAGE s000(zbmierzwi_test_msg) DISPLAY LIKE 'E'.
      LEAVE LIST-PROCESSING.
    ENDIF.
  ENDMETHOD.                    "check_kunnr
ENDCLASS.                    "lcl_params_validator IMPLEMENTATION

*----------------------------------------------------------------------*
*       CLASS lcl_inv_applier IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_inv_applier IMPLEMENTATION.
  METHOD make_all_blocks_inv.
    LOOP AT SCREEN.
      IF screen-group1 = 'ID1'.
        screen-invisible = '1'.
        screen-input = '0'.
        MODIFY SCREEN.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.                    "make_all_blocks_inv
ENDCLASS.                    "lcl_inv_applier IMPLEMENTATION