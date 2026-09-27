@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CV Certtifecat Expiring'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZKA_A_CertExpiring as select from ZKA_I_Cert
{
    key CertUuid,
    ParentUuid,
    Title,
    Issuer,
    IssueDate,
    ExpiryDate,
    dats_days_between( $session.system_date, ExpiryDate ) as DaysUntilExpiry
    
}where ExpiryDate between $session.system_date
    and dats_add_days( $session.system_date, 90, 'INITIAL' )
