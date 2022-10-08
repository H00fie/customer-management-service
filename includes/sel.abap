*&---------------------------------------------------------------------*
*&  Include           CUSTOMER_MANAGEMENT_SERVICE_SEL
*&---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK bk1 WITH FRAME TITLE t1.
  PARAMETERS: rbut1 RADIOBUTTON GROUP gr1 DEFAULT 'X' USER-COMMAND uc1,
              rbut2 RADIOBUTTON GROUP gr1.
SELECTION-SCREEN END OF BLOCK bk1.

SELECTION-SCREEN BEGIN OF BLOCK bk2 WITH FRAME TITLE t2.
  SELECT-OPTIONS: p_kunnr FOR kna1-kunnr NO-EXTENSION MODIF ID id1.
SELECTION-SCREEN END OF BLOCK bk2.