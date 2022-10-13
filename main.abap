*&---------------------------------------------------------------------*
*& Report CUSTOMER_MANAGEMENT_SERVICE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT CUSTOMER_MANAGEMENT_SERVICE.

INCLUDE Z_BMIERZWINSKI_DEV_TEST2_TOP.
INCLUDE Z_BMIERZWINSKI_DEV_TEST2_SEL.
INCLUDE Z_BMIERZWINSKI_DEV_TEST2_DEF.
INCLUDE Z_BMIERZWINSKI_DEV_TEST2_IMP.

INITIALIZATION.
  DATA(lo_visibility_dispenser) = NEW lcl_visibility_dispenser( ).
  lo_visibility_dispenser->make_all_blocks_inv( ).

AT SELECTION-SCREEN OUTPUT.
  IF rbut1 = 'X'.
    lo_visibility_dispenser->make_block_visible( 'ID1' ).
  ELSEIF rbut2 = 'X'.
    lo_visibility_dispenser->make_block_visible( 'ID2' ).
  ENDIF.

AT SELECTION-SCREEN.
  DATA(lo_customer_inserter) = NEW lcl_customer_inserter( ).
  DATA(lo_action_handler) = NEW lcl_action_handler( i_o_action = lo_customer_inserter ).
  lo_action_handler->decide_action( ).