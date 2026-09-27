@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CV Profile'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZKA_I_Profile as select from zka_profile
composition [0..*] of ZKA_I_Exper as _Exper
composition [0..*] of ZKA_I_Edu as _Edu
composition [0..*] of ZKA_I_Skill as _Skill
composition [0..*] of ZKA_I_Lang as _Lang
composition [0..*] of ZKA_I_Cert as _Cert
{
    key profile_uuid as ProfileUuid,
    profile_no as ProfileNo,
    first_name as FirstName,
    last_name as LastName,
    headline_de as HeadlineDe,
    headline_en as HeadlineEn,
    city as City,
    country as Country,
    email as Email,
    phone as Phone,
    website as Website,
    summary_de as SummaryDe,
    summary_en as SummaryEn,
    status as Status,
    published_at as PublishedAt,
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
    _Exper,
    _Edu,
    _Skill,
    _Lang,
    _Cert
}
