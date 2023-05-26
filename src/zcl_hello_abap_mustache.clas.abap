CLASS zcl_hello_abap_mustache DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

    TYPES:
      BEGIN OF ty_dev_tools_and_skill,
        tech_stack TYPE string,
        skill      TYPE string,
      END OF ty_dev_tools_and_skill.
    TYPES: ty_t_dev_skills TYPE STANDARD TABLE OF ty_dev_tools_and_skill WITH EMPTY KEY.

    TYPES:
      BEGIN OF ty_sap_dev,
        dev_area  TYPE string,
        dev_tools TYPE ty_t_dev_skills,
      END OF ty_sap_dev.
    TYPES ty_t_sap_dev TYPE STANDARD TABLE OF ty_sap_dev WITH DEFAULT KEY.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_hello_abap_mustache IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA: lo_mustache TYPE REF TO zcl_mustache,
          lv_text type string.

    DATA(lt_my_sap_dev_journey) = VALUE ty_t_sap_dev(
                                  ( dev_area = 'Backend' dev_tools = VALUE ty_t_dev_skills(
                                                                     ( tech_stack = 'ABAP' skill = 'RAP, ABAP Programming, ABAP-CDS, ADT, Odata')
                                                                     ( tech_stack = 'CAP' skill = 'NodeJS, JavaScripts/TypeScripts, CDS, VS Code, Business Studio' ) ) )
                                  ( dev_area = 'Frontend' dev_tools = VALUE ty_t_dev_skills(
                                                                     ( tech_stack = 'SAPUI5' skill = 'SAP Fiori, Fiori Luanchpad, Fiori Element, Business Studio' )
                                                                     ( tech_stack = 'OpenUI5' skill = 'HTML, JavaScripts/TypeScripts, CSS, UI5, Web component, React' ) ) )
                                  ( dev_area = 'Utils and basic skill' dev_tools = VALUE ty_t_dev_skills(
                                                                     ( tech_stack = 'Development env' skill = 'Linux, CLI tools, Terminal, Bash, Markdown, Docker, Dev Container...')
                                                                     ( tech_stack = 'Programming/Development tools' skill = 'Git, Github, ABAPGit, HTTP, REST, SOAP, ...' ) ) )
                                  ).

    TRY.
        lo_mustache = zcl_mustache=>create(
          '=>: {{dev_area}}' && cl_abap_char_utilities=>newline &&
          '{{#dev_tools}}' && cl_abap_char_utilities=>newline &&
          '-> {{tech_stack}} - {{skill}}' && cl_abap_char_utilities=>newline &&
          '{{/dev_tools}}' && cl_abap_char_utilities=>newline && cl_abap_char_utilities=>newline
        ).

        out->write( 'This is my SAP development journey' ).

        lv_text = lo_mustache->render( lt_my_sap_dev_journey ).
        out->write( lv_text ).

      CATCH zcx_mustache_error INTO DATA(lx_error).
        out->write( lx_error->get_text( ) ).
    ENDTRY.

  ENDMETHOD.

ENDCLASS.
