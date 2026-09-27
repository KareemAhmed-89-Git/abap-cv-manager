@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CV Experience'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZKA_I_Exper as select from zka_exper
association to parent ZKA_I_Profile as _Profile
    on $projection.ParentUuid = _Profile.ProfileUuid
{
    key exper_uuid as ExperUuid,
    parent_uuid as ParentUuid,
    date_from as DateFrom,
    date_to as DateTo,
    is_current as IsCurrent,
    role_de as RoleDe,
    role_en as RoleEn,
    company as Company,
    city as City,
    country as Country,
    text_de as TextDe,
    text_en as TextEn,
    duration_months as DurationMonths,
    sort_order as SortOrder,
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
