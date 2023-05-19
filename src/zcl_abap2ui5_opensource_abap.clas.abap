CLASS zcl_abap2ui5_opensource_abap DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES z2ui5_if_app.

    DATA user TYPE string.
    DATA date TYPE string.
    DATA check_initialized TYPE abap_bool.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA internal_date TYPE d.
ENDCLASS.



CLASS zcl_abap2ui5_opensource_abap IMPLEMENTATION.
  METHOD z2ui5_if_app~main.
    IF check_initialized = abap_false.
      check_initialized = abap_true.
      user = 'Wises Keshom'.
      date = sy-datlo.
    ENDIF.

    CASE client->get( )-event.
      WHEN 'BUTTON_POST'.
        internal_date = date.
        client->popup_message_toast( |App executed on { internal_date date = USER } by { user }| ).
      WHEN 'BACK'.
        client->nav_app_leave( client->get_app( client->get( )-id_prev_app_stack  ) ).
    ENDCASE.

    client->set_next( VALUE #( xml_main = z2ui5_cl_xml_view=>factory(
        )->shell(
        )->page(
                title          = 'SAP Developer Code Challenge'
                navbuttonpress = client->_event( 'BACK' )
                shownavbutton  = abap_true
            )->header_content(

                )->link(
                    text = 'Source_Code'
                    href = z2ui5_cl_xml_view=>hlp_get_source_code_url( app = me get = client->get( ) )
                    target = '_blank'
            )->get_parent(
            )->simple_form( title = 'Open-Source ABAP (Week 2) - abap2UI5 ' editable = abap_true
                )->content( 'form'
                    )->title( 'Input'
                    )->label( 'User:'
                    )->input(
                        value   = user
                        enabled = abap_true
                    )->label( 'Date:'
                    )->date_picker( client->_bind( date )
                    )->button(
                        text  = 'post'
                        press = client->_event( 'BUTTON_POST' )
         )->get_root( )->xml_get( ) ) ).
  ENDMETHOD.

ENDCLASS.
