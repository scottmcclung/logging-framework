public without sharing class Logger {

    /**
     * @description Add a message to the buffer without publishing it.
     * Assumes a null severity
     * @param messageToLog The string message to add to the buffer.
     */
    public static void add( String messageToLog ) {
        service().add( messageToLog );
    }

    /**
     * @description Add a message to the buffer without publishing it.
     * @param messageToLog The string message to add to the buffer.
     * @param severity LogSeverity enum
     */
    public static void add( String messageToLog, LogMessage.SeverityLevel severity ) {
        service().add( messageToLog, severity );
    }

    /**
     * @description Add an formatted exception message to the buffer without
     * publishing it. Assumes a null Severity
     * @param exceptionToLog Exception to format and log
     */
    public static void add( Exception exceptionToLog ) {
        service().add( exceptionToLog );
    }

    /**
     * @description Add an formatted exception message to the buffer without
     * publishing it.
     * @param exceptionToLog Exception to format and log
     * @param severity LogSeverity enum
     */
    public static void add( Exception exceptionToLog, LogMessage.SeverityLevel severity ) {
        service().add( exceptionToLog, severity );
    }

    /**
     * @description Publish any messages currently in the buffer, without adding
     * any new ones.
     */
    public static void publish() {
        service().publish();
    }

    /**
     * @description Auto-format exception details, add it to the log buffer,
     * and then publish the current buffer. Use the equivelent add
     * method if you intend to add multiple messages rapidly to minimize DML
     * usage.
     * @param exceptionToLog exception to format and log
     */
    public static void publish( Exception exceptionToLog ) {
        service().publish( exceptionToLog );
    }

    /**
     * @description Auto-format a custom log message string, add it to the log
     * buffer, and then publish the current buffer. Use the equivelent add
     * method if you intend to add multiple messages rapidly to minimize DML
     * usage.
     * @param messageToLog String to log
     */
    public static void publish( String messageToLog ) {
        service().publish( messageToLog );
    }

    /**
     * @description Auto-format a custom log message string, add it to the log
     * buffer, and then publish the current buffer. Use the equivelent add
     * method if you intend to add multiple messages rapidly to minimize DML
     * usage.
     * @param logMessage LogMessage object to log
     */
    public static void publish( LogMessage logMessage ) {
        service().publish( logMessage );
    }

    /**
     * @description Stores the log entry events in the Log__c object
     * @param events List<Log_Event__e>
     */
    public static void saveAllEvents(List<Log_Event__e> events) {
        service().saveAllEvents(events);
    }


    private static ILogger service() {
        return ( ILogger ) Application.SERVICE.newInstance( ILogger.class );
    }
}