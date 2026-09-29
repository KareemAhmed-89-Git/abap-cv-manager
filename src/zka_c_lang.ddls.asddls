@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CV Language Projection'
@Metadata.allowExtensions: true
define view entity ZKA_C_Lang 
    as projection on ZKA_I_Lang
{
    key LangUuid,
    ParentUuid,
    LanguageCode,
    LanguageName,
    LangLevel,
    CreatedBy,
    CreatedAt,
    LocalLastChangedBy,
    LocalLastChangedAt,
    LastChangedAt,
    /* Associations */
    _Profile : redirected to parent ZKA_C_Profile
}
