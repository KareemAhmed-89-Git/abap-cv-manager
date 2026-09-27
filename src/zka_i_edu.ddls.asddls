@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CV Education'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZKA_I_Edu as select from zka_edu
association to parent ZKA_I_Profile as _Profile
    on $projection.ParentUuid = _Profile.ProfileUuid
{
    key edu_uuid as EduUuid,
    parent_uuid as ParentUuid,
    date_from as DateFrom,
    date_to as DateTo,
    degree_de as DegreeDe,
    degree_en as DegreeEn,
    institution as Institution,
    city as City,
    country as Country,
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
