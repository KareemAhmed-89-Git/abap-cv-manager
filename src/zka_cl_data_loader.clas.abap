CLASS zka_cl_data_loader DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .

  PROTECTED SECTION.
  PRIVATE SECTION.

    TYPES tt_exper  TYPE STANDARD TABLE OF zka_exper WITH EMPTY KEY.
    TYPES tt_edu   TYPE STANDARD TABLE OF zka_edu WITH EMPTY KEY.
    TYPES tt_skill TYPE STANDARD TABLE OF zka_skill WITH EMPTY KEY.
    TYPES tt_lang TYPE STANDARD TABLE OF zka_lang WITH EMPTY KEY.
    TYPES tt_cert TYPE STANDARD TABLE OF zka_cert WITH EMPTY KEY.

    " Administrative data - filled once, copied into every row
    DATA ms_admin TYPE zka_s_admin.

    METHODS set_admin_data.

    METHODS new_uuid
        RETURNING VALUE(rv_uuid) TYPE sysuuid_x16
        RAISING cx_uuid_error.

    METHODS delete_all_data.

    METHODS insert_profile
      RETURNING VALUE(rv_profile_uuid) TYPE zka_profile-profile_uuid
      RAISING   cx_uuid_error.

    METHODS insert_experience
      IMPORTING iv_parent_uuid  TYPE zka_exper-parent_uuid
      RETURNING VALUE(rv_count) TYPE i
      RAISING   cx_uuid_error.

    METHODS insert_education
      IMPORTING iv_parent_uuid  TYPE zka_edu-parent_uuid
      RETURNING VALUE(rv_count) TYPE i
      RAISING   cx_uuid_error.

    METHODS insert_skills
      IMPORTING iv_parent_uuid  TYPE zka_skill-parent_uuid
      RETURNING VALUE(rv_count) TYPE i
      RAISING   cx_uuid_error.

    METHODS insert_languages
      IMPORTING iv_parent_uuid  TYPE zka_lang-parent_uuid
      RETURNING VALUE(rv_count) TYPE i
      RAISING   cx_uuid_error.

    METHODS insert_certificates
      IMPORTING iv_parent_uuid  TYPE zka_cert-parent_uuid
      RETURNING VALUE(rv_count) TYPE i
      RAISING   cx_uuid_error.


  ENDCLASS.



CLASS zka_cl_data_loader IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    DATA lv_profile_uuid TYPE zka_profile-profile_uuid.
    DATA lv_count TYPE i.

    delete_all_data( ).
    set_admin_data( ).
    out->write( |Data deleted.| ).

    TRY.
        lv_profile_uuid = insert_profile( ).
        out->write( |Profile created 1 row.| ).

        out->write( |Experience:     { lv_count } rows | ).
        out->write( |{ insert_experience( lv_profile_uuid ) } Experiences created.| ).

        out->write( |education:     { lv_count } rows | ).
        out->write( |{ insert_education( lv_profile_uuid ) } Education created.| ).

        out->write( |skills:     { lv_count } rows | ).
        out->write( |{ insert_skills( lv_profile_uuid ) } Skills created.| ).

        out->write( |languages:     { lv_count } rows | ).
        out->write( |{ insert_languages( lv_profile_uuid ) } language created. | ).

        out->write( |certificates:     { lv_count } rows | ).
        out->write( |{ insert_certificates( lv_profile_uuid ) } certificates created.| ).

      CATCH cx_uuid_error INTO DATA(lx_uuid).

        out->write( |Error: { lx_uuid->get_text( ) }| ).
        out->write( |Run the loader again - it deletes everything first.| ).

    ENDTRY.

  ENDMETHOD.

  METHOD delete_all_data.
    DELETE FROM zka_exper.
    DELETE FROM zka_edu.
    DELETE FROM zka_skill.
    DELETE FROM zka_lang.
    DELETE FROM zka_cert.
    DELETE FROM zka_profile.
  ENDMETHOD.

  METHOD new_uuid.
    rv_uuid = cl_system_uuid=>create_uuid_x16_static( ).
  ENDMETHOD.

  METHOD set_admin_data.
    " Same user and same timestamp for every row of this run
    ms_admin-created_by = cl_abap_context_info=>get_user_technical_name( ).
    GET TIME STAMP FIELD ms_admin-created_at.

    ms_admin-local_last_changed_by = ms_admin-created_by.
    ms_admin-local_last_changed_at = ms_admin-created_at.
    ms_admin-last_changed_at = ms_admin-created_at.
  ENDMETHOD.

    METHOD insert_profile.

    DATA ls_profile TYPE zka_profile.

    ls_profile = VALUE #(
    profile_uuid = new_uuid( )
    profile_no = '0001'
    first_name = 'Kareem'
    last_name = 'Ahmed'
    headline_de = 'SAP ABAP Cloud Back-End Entwickler'
    headline_en = 'ABAP Cloud Backend Developer'
    city = 'Hamburg'
    country = 'DE'
    email = 'kareemsayed.ahmed@outlook.com'
    phone = '+49 1629819188'
    website = 'https://kareemahmed-89-git.github.io/'
    summary_de = ''
    summary_en = ''
    status = 'DRF' ).

    MOVE-CORRESPONDING ms_admin TO ls_profile.

    INSERT zka_profile FROM @ls_profile.

    rv_profile_uuid = ls_profile-profile_uuid.

  ENDMETHOD.

  METHOD insert_certificates.

  DATA lt_cert TYPE tt_cert.

    lt_cert = VALUE #(
    ( cert_uuid = new_uuid(  )
      parent_uuid = iv_parent_uuid
      title = 'SAP Certified Associate - Back-End Developer - ABAP Cloud'
      issuer = 'SAP'
      issue_date = '20260922'
     expiry_date = '20270922'
     credential_id = ''
     credential_url = ''
    ) ).
    LOOP AT lt_cert ASSIGNING FIELD-SYMBOL(<ls_cert>).
        MOVE-CORRESPONDING ms_admin TO <ls_cert>.
    ENDLOOP.

    INSERT zka_cert FROM TABLE @lt_cert.
    rv_count = sy-dbcnt.
  ENDMETHOD.

  METHOD insert_education.

  DATA lt_edu TYPE tt_edu.

  lt_edu = VALUE #(
    ( edu_uuid = new_uuid(  )
      parent_uuid = iv_parent_uuid
      date_from = '20060901'
      date_to = '20101001'
      degree_de = 'Bachelor Systeminformatiker — Information Systems'
      degree_en = 'BSc Information Systems'
      institution = 'Higher Institute for Specific Studies'
      city = 'Giza'
      country = 'EG') ).

    LOOP AT lt_edu ASSIGNING FIELD-SYMBOL(<ls_edu>).
       MOVE-CORRESPONDING ms_admin TO <ls_edu>.
    ENDLOOP.

    INSERT zka_edu FROM TABLE @lt_edu.

    rv_count = sy-dbcnt.
  ENDMETHOD.

  METHOD insert_experience.

    DATA lt_exper TYPE tt_exper.

    lt_exper = VALUE #( (
      exper_uuid = new_uuid(  )
      parent_uuid = iv_parent_uuid
      date_from   = '20180701'
      date_to     = '20180930'        " empty = still running
      is_current  = abap_false
      role_de     = 'Praktikum Systeminformatiker'
      role_en     = 'Internship, systems informatics'
      company     = 'LOGIN EDV'
      city        = 'Bremerhaven'
      country     = 'DE'
      text_de     = 'Praktikum als Systeminformatiker in Bremerhaven.'
      text_en     = 'Internship as systems informatics in Bremerhaven.'
     )
     ( exper_uuid = new_uuid(  )
      parent_uuid = iv_parent_uuid
      date_from   = '20181101'
      date_to     = '20190630'        " empty = still running
      is_current  = abap_false
      role_de     = 'Junior Java Programmierer'
      role_en     = 'Junior Java Developer'
      company     = 'Die Prozessberater GmbH'
      city        = 'Bremen'
      country     = 'DE'
      text_de     = 'Entwicklung im Java-Umfeld.'
      text_en     = 'Development in the Java stack.'
     ) ).

    LOOP AT lt_exper ASSIGNING FIELD-SYMBOL(<ls_exper>).
       MOVE-CORRESPONDING ms_admin TO <ls_exper>.
    ENDLOOP.

    INSERT zka_exper FROM TABLE @lt_exper.

    rv_count = sy-dbcnt.

  ENDMETHOD.

  METHOD insert_languages.

  DATA lt_lang TYPE tt_lang.
  lt_lang = VALUE #(

    ( lang_uuid = new_uuid(  )
      parent_uuid = iv_parent_uuid
      language_code = 'DE'
      language_name = 'Deutsche'
      lang_level = 'B2'
     )
     ( lang_uuid = new_uuid(  )
      parent_uuid = iv_parent_uuid
      language_code = 'EN'
      language_name = 'English'
      lang_level = 'B2'
     )
     ( lang_uuid = new_uuid(  )
      parent_uuid = iv_parent_uuid
      language_code = 'AR'
      language_name = 'Arabic'
      lang_level = 'NATIVE'
     )

  ).

  LOOP AT lt_lang ASSIGNING FIELD-SYMBOL(<ls_lang>).
       MOVE-CORRESPONDING ms_admin TO <ls_lang>.
    ENDLOOP.

    INSERT zka_lang FROM TABLE @lt_lang.

    rv_count = sy-dbcnt.

  ENDMETHOD.


  METHOD insert_skills.
    DATA lt_skill TYPE tt_skill.
    lt_skill = VALUE #(
      ( skill_uuid = new_uuid( ) parent_uuid = iv_parent_uuid
        category = 'SAP'  skill_name = 'ABAP Cloud'  skill_level = 4 is_highlight = abap_true )
      ( skill_uuid = new_uuid( ) parent_uuid = iv_parent_uuid
        category = 'SAP'  skill_name = 'RAP'         skill_level = 3 is_highlight = abap_true )
      ( skill_uuid = new_uuid( ) parent_uuid = iv_parent_uuid
        category = 'SAP'  skill_name = 'CDS'         skill_level = 4 is_highlight = abap_true )
      ( skill_uuid = new_uuid( ) parent_uuid = iv_parent_uuid
        category = 'DB'   skill_name = 'SQL'         skill_level = 3 is_highlight = abap_false )
      ( skill_uuid = new_uuid( ) parent_uuid = iv_parent_uuid
        category = 'TOOL' skill_name = 'Git'         skill_level = 3 is_highlight = abap_false ) ).
      " TODO: add the rest (about 25 in total)
    LOOP AT lt_skill ASSIGNING FIELD-SYMBOL(<ls_skill>).
       MOVE-CORRESPONDING ms_admin TO <ls_skill>.
    ENDLOOP.

    INSERT zka_skill FROM TABLE @lt_skill.

    rv_count = sy-dbcnt.

  ENDMETHOD.



ENDCLASS.
