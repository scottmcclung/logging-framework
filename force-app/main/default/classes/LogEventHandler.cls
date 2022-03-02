public class LogEventHandler  extends ApplicationDomainHandler {
    public LogEventHandler( List<Log_Event__e> lstSObjects ) {
        super( lstSObjects );
    }


    public override Schema.SObjectType getSObjectType() {
        return Account.SObjectType;
    }


    public override void onAfterInsert() {
        Logger.saveAllEvents((List<Log_Event__e>) Records);
    }


    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct( List<SObject> sObjectList ) {
            return new LogEventHandler( sObjectList );
        }
    }
}