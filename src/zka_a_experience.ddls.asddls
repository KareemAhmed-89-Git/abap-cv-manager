@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Experence Duration'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZKA_A_Experience as select from ZKA_A_ExperDuration
{
    key ParentUuid,

    sum ( DurationDays ) as TotalDays,
    
    div( sum ( DurationDays ), 30 ) as TotalMonths,
    
    div( sum ( DurationDays ), 365 ) as TotalYears

}
group by
    ParentUuid

