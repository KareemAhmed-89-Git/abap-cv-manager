@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Skill Count'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZKA_A_SkillCount as select from ZKA_I_Skill
{
    key ParentUuid,
    key Category,
    count(* ) as SkillCount

}
group by
    ParentUuid,
    Category
