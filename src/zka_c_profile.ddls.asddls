@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CV Profile - Projection'
@Metadata.allowExtensions: true
define root view entity ZKA_C_Profile 
provider contract transactional_query
as projection on ZKA_I_Profile
{
    key ProfileUuid,
    ProfileNo,
    FirstName,
    LastName,
    HeadlineDe,
    HeadlineEn,
    City,
    Country,
    Email,
    Phone,
    Website,
    SummaryDe,
    SummaryEn,
    Status,
    PublishedAt,
    CreatedBy,
    CreatedAt,
    LocalLastChangedBy,
    LocalLastChangedAt,
    LastChangedAt,
    /* Associations */
    _Cert : redirected to composition child ZKA_C_Cert,
    _Edu : redirected to composition child ZKA_C_Edu,
    _Exper : redirected to composition child ZKA_C_Exper,
    _Lang : redirected to composition child ZKA_C_Lang,
    _Skill : redirected to composition child ZKA_C_Skill
}
