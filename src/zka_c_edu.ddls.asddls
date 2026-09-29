@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CV Education Projection'
@Metadata.allowExtensions: true
define view entity ZKA_C_Edu 
    as projection on ZKA_I_Edu
{
    key EduUuid,
    ParentUuid,
    DateFrom,
    DateTo,
    DegreeDe,
    DegreeEn,
    Institution,
    City,
    Country,
    CreatedBy,
    CreatedAt,
    LocalLastChangedBy,
    LocalLastChangedAt,
    LastChangedAt,
    /* Associations */
    _Profile : redirected to parent ZKA_C_Profile
}
