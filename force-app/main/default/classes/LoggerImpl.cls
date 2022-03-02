public without sharing class LoggerImpl implements ILogger {
    private List<LogMessage> buffer;

    public LoggerImpl() {
        buffer = new List<LogMessage>();
    }

    /**
     * @description Add a message to the buffer without publishing it.
     * Assumes a null severity
     * @param messageToLog The string message to add to the buffer.
     * @return
     */
    public ILogger add( String messageToLog ) {
        this.add( messageToLog, LogMessage.SeverityLevel.LOW );
        return this;
    }

    /**
     * @description Add a message to the buffer without publishing it.
     * @param messageToLog The string message to add to the buffer.
     * @param severity LogSeverity enum
     * @return
     */
    public ILogger add( String messageToLog, LogMessage.SeverityLevel severity ) {
        if( severity != null ) severity = LogMessage.SeverityLevel.LOW;
        buffer.add( LogMessage.newLog( messageToLog, severity ) );
        return this;
    }

    /**
     * @description Add an formatted exception message to the buffer without
     * publishing it. Assumes a null Severity
     * @param exceptionToLog Exception to format and log
     * @return
     */
    public ILogger add( Exception exceptionToLog ) {
        this.add( exceptionToLog, LogMessage.SeverityLevel.LOW );
        return this;
    }

    /**
     * @description Add an formatted exception message to the buffer without
     * publishing it.
     * @param exceptionToLog Exception to format and log
     * @param severity LogSeverity enum
     * @return
     */
    public ILogger add( Exception exceptionToLog, LogMessage.SeverityLevel severity ) {
        if( severity != null ) severity = LogMessage.SeverityLevel.LOW;
        buffer.add( LogMessage.newExceptionLog( exceptionToLog, severity ) );
        return this;
    }

    /**
     * @description Publish any messages currently in the buffer, without adding
     * any new ones.
     */
    public void publish() {
        if( this.buffer.size() == 0 ) return;

        fflib_ISObjectUnitOfWork uow = Application.UNITOFWORK.newInstance();
        for( LogMessage msg : this.buffer ) {
            uow.registerPublishBeforeTransaction( msg.toEvent() );
        }
        uow.commitWork();
        this.buffer.clear();
    }

    /**
     * @description Auto-format exception details, add it to the log buffer,
     * and then publish the current buffer. Use the equivalent add
     * method if you intend to add multiple messages rapidly to minimize DML
     * usage.
     * @param exceptionToLog exception to format and log
     */
    public void publish( Exception exceptionToLog ) {
        this.buffer.add( LogMessage.newExceptionLog( exceptionToLog ) );
        this.publish();
    }

    /**
     * @description Auto-format exception details, add it to the log buffer,
     * and then publish the current buffer. Use the equivalent add
     * method if you intend to add multiple messages rapidly to minimize DML
     * usage.
     * @param exceptionToLog exception to format and log
     * @param severityLevel
     */
    public void publish( Exception exceptionToLog, LogMessage.SeverityLevel severityLevel ) {
        this.buffer.add( LogMessage.newExceptionLog( exceptionToLog, severityLevel ) );
        this.publish();
    }

    /**
     * @description Auto-format a custom log message string, add it to the log
     * buffer, and then publish the current buffer. Use the equivalent add
     * method if you intend to add multiple messages rapidly to minimize DML
     * usage.
     * @param messageToLog String to log
     */
    public void publish( String messageToLog ) {
        this.buffer.add( LogMessage.newLog( messageToLog ) );
        this.publish();
    }

    /**
     * @description Auto-format a custom log message string, add it to the log
     * buffer, and then publish the current buffer. Use the equivalent add
     * method if you intend to add multiple messages rapidly to minimize DML
     * usage.
     * @param messageToLog String to log
     * @param severityLevel
     */
    public void publish( String messageToLog, LogMessage.SeverityLevel severityLevel ) {
        this.buffer.add( LogMessage.newLog( messageToLog, severityLevel ) );
        this.publish();
    }

    /**
     * @description Auto-format a custom log message string, add it to the log
     * buffer, and then publish the current buffer. Use the equivalent add
     * method if you intend to add multiple messages rapidly to minimize DML
     * usage.
     * @param logMessage LogMessage object to log
     */
    public void publish( LogMessage logMessage ) {
        this.buffer.add( logMessage );
        this.publish();
    }

    /**
     * @description Stores the log entry events in the Log__c object
     * @param events List<Log_Event__e>
     */
    public void saveAllEvents( List<Log_Event__e> events ) {
        fflib_ISObjectUnitOfWork uow = Application.UNITOFWORK.newInstance();
        for(Log_Event__e entry : events) {
            uow.registerNew( LogMessage.eventToLogRecord(entry) );
        }
        uow.commitWork();
    }
}