CLASS lhc_skill DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS validateLevel FOR VALIDATE ON SAVE
      keys FOR Skill~validateLevel.

ENDCLASS.

CLASS lhc_skill IMPLEMENTATION.

  METHOD validateLevel.

  READ ENTITIES OF ZKA_I_Profile IN LOCAL MODE
  ENTITY Skill
  FIELDS ( SkillLevel ParentUuid )
  WITH CORRESPONDING #( keys )
  RESULT DATA(lt_skill).

  LOOP AT lt_skill INTO DATA(ls_skill).

  APPEND VALUE #( %tky = ls_skill-%tky
                  %state_area = 'VALDETE_LEVEL' ) to reported-skill.

  if ls_skill-SkillLevel IS NOT INITIAL
    and ls_skill-SkillLevel < 1 or ls_skill-SkillLevel > 5 .

    APPEND VALUE #( %tky = ls_skill-%tky ) to failed-skill.

    APPEND VALUE #( %tky = ls_skill-%tky
                    %state_area = 'VALDETE_LEVEL'
                    %msg = new_message_with_text(
                             severity = if_abap_behv_message=>severity-error
                             text     = 'Skill level must be between 1 and 5'
                           )

                    %element-SkillLevel = if_abap_behv=>mk-on
                    %path = VALUE #( Profile-%is_draft = ls_skill-%is_draft
                                     Profile-profileUuid = ls_skill-ParentUuid    )
                      ) to reported-skill.

    ENDIF.

  ENDLOOP.



  ENDMETHOD.

ENDCLASS.

CLASS lhc_experience DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS validateCurrent FOR VALIDATE ON SAVE
      keys FOR Experience~validateCurrent.

    METHODS validateDates FOR VALIDATE ON SAVE
      keys FOR Experience~validateDates.

ENDCLASS.

CLASS lhc_experience IMPLEMENTATION.

  METHOD validateCurrent.

    READ ENTITIES OF ZKA_I_Profile IN LOCAL MODE
    ENTITY Experience
    FIELDS ( IsCurrent DateTo ParentUuid )
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_Exper).

    LOOP AT lt_Exper INTO DATA(ls_Exper).

       APPEND VALUE #( %tky = ls_exper-%tky
                       %state_area = 'VALIDATE_CURRENT'
        ) TO reported-experience.

        if ls_exper-IsCurrent = abap_true
            and ls_exper-DateTo IS NOT INITIAL.

          APPEND VALUE #( %tky = ls_exper-%tky ) to failed-experience.

          APPEND VALUE #(
                        %tky = ls_exper-%tky
                        %state_area = 'VALIDATE_CURRENT'
                        %msg = new_message_with_text(
                                 severity = if_abap_behv_message=>severity-error
                                 text     = 'A current job must not have an end date'
                               )
                        %element-DateTo = if_abap_behv=>mk-on
                        %path           = VALUE #( Profile-%is_draft   = ls_exper-%is_draft
                                     Profile-ProfileUuid = ls_exper-ParentUuid )

          ) TO reported-experience.

        endif.

    ENDLOOP.




  ENDMETHOD.

  METHOD validateDates.

  " Read only the fields this rule needs
  READ ENTITIES OF ZKA_I_Profile IN LOCAL MODE
  ENTITY Experience
  FIELDS ( DateFrom DateTo ParentUuid )
  WITH CORRESPONDING #( keys )
  RESULT DATA(lt_exper).

  LOOP AT lt_exper INTO DATA(ls_exper).

    " Remove old messages of this rule for this entry
    APPEND VALUE #( %tky = ls_exper-%tky
                    %state_area = 'VALIDATE_DATES'
     ) TO reported-experience.

  if ls_exper-DateTo IS NOT INITIAL
    and ls_exper-DateTo < ls_exper-DateFrom.

    APPEND VALUE #( %tky = ls_exper-%tky ) TO failed-experience.

    APPEND VALUE #(
            %tky = ls_exper-%tky
            %state_area = 'VALIDATE_DATE'
            %msg = new_message_with_text(
                     severity = if_abap_behv_message=>severity-error
                     text     = 'End date must not be earlier than start date'
                   )

            %element-DateTo = if_abap_behv=>mk-on
            %path  = VALUE #( Profile-%is_draft = ls_exper-%is_draft
                              Profile-profileUuid = ls_exper-ParentUuid )

    ) TO reported-experience.

    ENDIF.

  ENDLOOP.

  ENDMETHOD.

ENDCLASS.

CLASS lhc_education DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS validateDates FOR VALIDATE ON SAVE
      keys FOR Education~validateDates.

ENDCLASS.

CLASS lhc_education IMPLEMENTATION.

  METHOD validateDates.

  READ ENTITIES OF ZKA_I_Profile IN LOCAL MODE
  ENTITY Education
  FIELDS ( DateFrom DateTo ParentUuid )
  WITH CORRESPONDING #( keys )
  RESULT DATA(lt_edu).

  LOOP AT lt_edu INTO DATA(ls_edu).

  APPEND VALUE #( %tky = ls_edu-%tky
  %state_area = 'VALDETE_DATES' ) to reported-education.

  if ls_edu-DateTo IS NOT INITIAL
    and ls_edu-DateTo < ls_edu-DateFrom.

  APPEND VALUE #( %tky = ls_edu-%tky ) TO failed-education.

  APPEND VALUE #(
        %tky = ls_edu-%tky
        %state_area     = 'VALIDATE_DATES'
        %msg = new_message_with_text(
                 severity = if_abap_behv_message=>severity-error
                 text     = 'End date must not be earlier than start date'

               )
        %element-DateTo = if_abap_behv=>mk-on
        %path = VALUE #( Profile-%is_draft = ls_edu-%is_draft
                         Profile-profileUuid = ls_edu-ParentUuid )
  ) TO reported-education.

  ENDIF.
  ENDLOOP.


  ENDMETHOD.

ENDCLASS.

CLASS lhc_Profile DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      REQUEST requested_authorizations FOR Profile RESULT result.

ENDCLASS.

CLASS lhc_Profile IMPLEMENTATION.

  METHOD get_global_authorizations.
  ENDMETHOD.

ENDCLASS.
