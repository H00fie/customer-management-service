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
  DATA(lo_element_remover) = NEW lcl_element_remover( ).
  lo_element_remover->hide_onli( ).

  IF rbut1 = 'X'.
    lo_visibility_dispenser->make_block_visible( 'ID1' ).
  ELSEIF rbut2 = 'X'.
    lo_visibility_dispenser->make_block_visible( 'ID2' ).
  ENDIF.

START-OF-SELECTION.
  DATA(lo_factory) = NEW lcl_factory( ).
  DATA(lo_action_handler) = NEW lcl_action_handler( i_o_action = lo_factory->provide_object( ) ).
  lo_action_handler->decide_action( ).

*    DATA(lo_customer_inserter) = NEW lcl_customer_inserter( ).
*    DATA(lo_action_handler) = NEW lcl_action_handler( i_o_action = lo_customer_inserter ).
*    lo_action_handler->decide_action( ).
*    DATA(lo_cds_data_selector) = NEW lcl_cds_data_selector( ).
*    lo_cds_data_selector->gather_sl_data( ).
*    lo_cds_data_selector->supply_orders( i_lt_seltab = lt_seltab ).