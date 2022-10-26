*&---------------------------------------------------------------------*
*&  Include           CUSTOMER_MANAGEMENT_SERVICE_TOP
*&---------------------------------------------------------------------*

TABLES: kna1.

TYPES: BEGIN OF t_orders,
  vbeln TYPE likp-vbeln,
  erzet TYPE likp-erzet,
  erdat TYPE likp-erdat,
  route TYPE likp-route,
  btgew TYPE likp-btgew,
END OF t_orders.
DATA: lt_orders TYPE STANDARD TABLE OF t_orders,
      wa_orders TYPE t_orders,
      gv_dis_panel TYPE bool VALUE abap_false.