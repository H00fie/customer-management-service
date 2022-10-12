*&---------------------------------------------------------------------*
*&  Include           CUSTOMER_MANAGEMENT_SERVICE_SEL
*&---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK bk1 WITH FRAME TITLE TEXT-001.
  PARAMETERS: rbut1 RADIOBUTTON GROUP gr1 DEFAULT 'X' USER-COMMAND uc1,
              rbut2 RADIOBUTTON GROUP gr1.
SELECTION-SCREEN END OF BLOCK bk1.

SELECTION-SCREEN BEGIN OF BLOCK bk2 WITH FRAME TITLE TEXT-002.
  PARAMETERS: p_kunnr TYPE kna1-kunnr,
              p_land1 TYPE kna1-land1,
              p_name1 TYPE kna1-name1,
              p_ort01 TYPE kna1-ort01,
              p_pstlz TYPE kna1-pstlz.
SELECTION-SCREEN END OF BLOCK bk2.

SELECTION-SCREEN BEGIN OF BLOCK bk3 WITH FRAME TITLE t3.
  SELECT-OPTIONS: sl_kunnr FOR kna1-kunnr NO-EXTENSION MODIF ID id1.
SELECTION-SCREEN END OF BLOCK bk3.

*TEXT ELEMENTS TO BE INCLUDED IN "TEXTS".
*-----------Text Symbols Sheet-----------
*001 - Program mode
*002 - New client's data
*----------Selection Texts Sheet---------
*RBUT1 - New client's insertion
*RBUT2 - Orders
*p_kunnr - Customer number
*p_land1 - Country
*p_name1 - Name
*p_ort01 - City
*p_pstlz - Postal code