
public inherited sharing abstract class ApplicationDomainHandler extends fflib_SObjectDomain {
    public ApplicationDomainHandler(List<SObject> records) {
        super(records);
        Configuration.disableTriggerCRUDSecurity();
    }
}