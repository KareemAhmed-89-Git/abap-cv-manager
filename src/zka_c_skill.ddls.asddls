@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CV Skills Projection'
@Metadata.allowExtensions: true
define view entity ZKA_C_Skill 
    as projection on ZKA_I_Skill
{
    key SkillUuid,
    ParentUuid,
    Category,
    SkillName,
    SkillLevel,
    IsHighlight,
    CreatedBy,
    CreatedAt,
    LocalLastChangedBy,
    LocalLastChangedAt,
    LastChangedAt,
    /* Associations */
    _Profile : redirected to parent ZKA_C_Profile
}
