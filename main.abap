*&---------------------------------------------------------------------*
*& Report CUSTOMER_MANAGEMENT_SERVICE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT CUSTOMER_MANAGEMENT_SERVICE.

INCLUDE CUSTOMER_MANAGEMENT_SERVICE_TOP.
INCLUDE CUSTOMER_MANAGEMENT_SERVICE_SEL.
INCLUDE CUSTOMER_MANAGEMENT_SERVICE_DEF.
INCLUDE CUSTOMER_MANAGEMENT_SERVICE_IMP.

INITIALIZATION.
  DATA(lo_visibility_dispenser) = NEW lcl_visibility_dispenser( ).
  lo_visibility_dispenser->make_all_blocks_inv( ).

AT SELECTION-SCREEN OUTPUT.
  DATA(lo_element_remover) = NEW lcl_element_remover( ).
  DATA(lo_screen_adjuster) = NEW lcl_screen_adjuster( i_lo_element_remover      = lo_element_remover
                                                      i_lo_visibility_dispenser = lo_visibility_dispenser ).
  lo_screen_adjuster->adjust_screen( ).

AT SELECTION-SCREEN.
  DATA(lo_factory) = NEW lcl_factory( ).
  DATA(lo_warner) = NEW lcl_warner( ).
  DATA(lo_action_handler) = NEW lcl_action_handler( i_o_action = lo_factory->provide_object( )
                                                    i_o_warner = lo_warner ).
  lo_action_handler->decide_action( ).
