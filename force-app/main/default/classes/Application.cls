/**
 * Created by scott on 2/24/22.
 */

public class Application {
    // Configure and create the ServiceFactory for this Application
    public static final fflib_Application.ServiceFactory SERVICE =
        new fflib_Application.ServiceFactory(
            new Map<Type, Type> {
                ILogger.class => LoggerImpl.class
            });


    // Configure and create the UnitOfWorkFactory for this Application
    public static final fflib_Application.UnitOfWorkFactory UNITOFWORK =
        new fflib_Application.UnitOfWorkFactory(
            new List<SObjectType> {
                Log__c.SObjectType,
                Log_Event__e.SObjectType
            });

}