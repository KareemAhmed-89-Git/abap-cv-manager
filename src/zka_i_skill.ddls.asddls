@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CV Skills'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZKA_I_Skill as select from zka_skill
association to parent ZKA_I_Profile as _Profile
    on $projection.ParentUuid = _Profile.ProfileUuid
{
    key skill_uuid as SkillUuid,
    parent_uuid as ParentUuid,
    category as Category,
    skill_name as SkillName,
    skill_level as SkillLevel,
    is_highlight as IsHighlight,
    @Semantics.user.createdBy: true
    created_by as CreatedBy,
    @Semantics.systemDateTime.createdAt: true
    created_at as CreatedAt,
    @Semantics.user.localInstanceLastChangedBy: true
    local_last_changed_by as LocalLastChangedBy,
    @Semantics.systemDateTime.localInstanceLastChangedAt: true
    local_last_changed_at as LocalLastChangedAt,
    @Semantics.systemDateTime.lastChangedAt: true
    last_changed_at as LastChangedAt,
    _Profile
}
