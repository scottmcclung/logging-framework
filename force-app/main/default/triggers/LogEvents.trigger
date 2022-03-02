trigger LogEvents on Log_Event__e (after insert) {
    fflib_SObjectDomain.triggerHandler(LogEventHandler.class);
}