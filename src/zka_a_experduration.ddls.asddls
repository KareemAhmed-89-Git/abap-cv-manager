@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Experence Duration'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZKA_A_ExperDuration as select from ZKA_I_Exper
{
    key ExperUuid,
    ParentUuid,
    DateFrom,
    DateTo,
    IsCurrent,
    
    dats_days_between( DateFrom, 
        case when IsCurrent = 'X'
        then $session.system_date
        else DateTo
        end
         ) as DurationDays,

   
    /* Associations */
    _Profile
}
