*&---------------------------------------------------------------------*
*&  Include           CUSTOMER_MANAGEMENT_SERVICE_DEF
*&---------------------------------------------------------------------*

*----------------------------------------------------------------------*
*       CLASS lcl_params_validator DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_params_validator DEFINITION.
  PUBLIC SECTION.
    METHODS: check_if_initial.
  PRIVATE SECTION.
    METHODS: check_kunnr
	         check_land1,
			 check_name1,
			 check_ort01.
ENDCLASS.                    "lcl_params_validator DEFINITION

*----------------------------------------------------------------------*
*       CLASS lcl_inv_applier DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_inv_applier DEFINITION.
  PUBLIC SECTION.
    METHODS: make_all_blocks_inv.
ENDCLASS.                    "lcl_inv_applier DEFINITION