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
DATA(lo_inv_applier) = NEW lcl_inv_applier( ).
lo_inv_applier->make_all_blocks_inv( ).