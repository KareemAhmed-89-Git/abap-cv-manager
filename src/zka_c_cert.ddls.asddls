@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CV certifcation Projection'
@Metadata.allowExtensions: true
define view entity ZKA_C_Cert 
    as projection on ZKA_I_Cert
{
    key CertUuid,
    ParentUuid,
    Title,
    Issuer,
    IssueDate,
    ExpiryDate,
    CredentialId,
    CredentialUrl,
    CreatedBy,
    CreatedAt,
    LocalLastChangedBy,
    LocalLastChangedAt,
    LastChangedAt,
    /* Associations */
    _Profile : redirected to parent ZKA_C_Profile
}
