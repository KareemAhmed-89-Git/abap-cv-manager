@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CV certifcation'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZKA_I_Cert as select from zka_cert
association to parent ZKA_I_Profile as _Profile
    on $projection.ParentUuid = _Profile.ProfileUuid

{
    key cert_uuid as CertUuid,
    parent_uuid as ParentUuid,
    title as Title,
    issuer as Issuer,
    issue_date as IssueDate,
    expiry_date as ExpiryDate,
    credential_id as CredentialId,
    credential_url as CredentialUrl,
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
