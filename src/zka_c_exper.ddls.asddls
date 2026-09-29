@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CV Experience - Projection'
@Metadata.allowExtensions: true
define view entity ZKA_C_Exper 
    as projection on ZKA_I_Exper
{
    key ExperUuid,
    ParentUuid,
    DateFrom,
    DateTo,
    IsCurrent,
    RoleDe,
    RoleEn,
    Company,
    City,
    Country,
    TextDe,
    TextEn,
    DurationMonths,
    SortOrder,
    CreatedBy,
    CreatedAt,
    LocalLastChangedBy,
    LocalLastChangedAt,
    LastChangedAt,
    /* Associations */
    _Profile : redirected to parent ZKA_C_Profile
}
