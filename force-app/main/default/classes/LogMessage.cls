/**
 * @description Wrapper class used for passing parameters from source class
 * @author Deloitte
 * @date 23/02/2022
 */
public class LogMessage {
    /**
     * @description String used to format the governor limits stored in the log
     */
    public static final String GOVERNOR_LIMITS_STRING_FORMAT = '1. SOQL Queries used / SOQL Queries allowed: {0}/{1}\n' +
        '2. Number of records queried so far / Number allowed: {2}/{3}\n' +
        '3. Number of DML statements used so far / Number allowed: {4}/{5}\n' +
        '4. Amount of CPU time (in ms) used so far / CPU usage time (in ms) allowed: {6}/{7}';


    /**
     * @description Generates a new log object based on the message provided.
     * Assumes LOW severity.
     * @param message String error message to capture in the log
     * @return LogMessage object required by Logger.
     */
    public static LogMessage newLog( String message ) {
        String traceString = new DmlException().getStackTraceString().substringAfter( '\n' );
        LogMessage logMessage = new LogMessage( message, traceString, LogMessage.SeverityLevel.LOW );
        return logMessage;
    }

    /**
     * @description Generates a new log object based on the message and severity level provided.
     * @param message String error message to capture in the log
     * @param severityLevel LogMessage.SeverityLevel enum to indicate the level of severity
     * @return LogMessage object required by Logger.
     */
    public static LogMessage newLog( String message, SeverityLevel severityLevel ) {
        String traceString = new DmlException().getStackTraceString().substringAfter( '\n' );
        LogMessage logMessage = new LogMessage( message, traceString, severityLevel );
        return logMessage;
    }

    /**
     * @description Generates a new log object based on the exception provided.
     * Assumes LOW severity
     * @param exceptionObj Any standard or custom exception.
     * @return LogMessage object required by Logger.
     */
    public static LogMessage newExceptionLog( Exception exceptionObj ) {
        String message = exceptionObj.getMessage().left( 131072 );
        String traceString = exceptionObj.getStackTraceString();
        return new LogMessage( message, traceString, SeverityLevel.LOW )
            .withException( exceptionObj );
    }

    /**
     * @description Generates a new log object based on the exception and the severity level provided.
     * @param exceptionObj Any standard or custom exception.
     * @param severityLevel LogMessage.SeverityLevel enum to indicate the level of severity
     * @return LogMessage object required by Logger.
     */
    public static LogMessage newExceptionLog( Exception exceptionObj, SeverityLevel severityLevel ) {
        String message = exceptionObj.getMessage().left( 131072 );
        String traceString = exceptionObj.getStackTraceString();
        return new LogMessage( message, traceString, severityLevel )
            .withException( exceptionObj );
    }

    /**
     * @description Generates a new log object for a batch process error.
     * @param message String error message to capture in the log
     * @param batchJobId String Id of the asynchronous job.
     * @param severityLevel LogMessage.SeverityLevel enum to indicate the level of severity
     * @return LogMessage object required by Logger.
     */
    public static LogMessage newBatchLog( String message, String batchJobId, SeverityLevel severityLevel ) {
        String traceString = new DmlException().getStackTraceString().substringAfter( '\n' );
        return new LogMessage( message, traceString, severityLevel )
            .withBatchJobId( batchJobId );
    }

    /**
     * @description Generates a new log object for a batch process exception.
     * @param exceptionObj Any standard or custom exception.
     * @param batchJobId String Id of the asynchronous job.
     * @param severityLevel LogMessage.SeverityLevel enum to indicate the level of severity
     * @return LogMessage object required by Logger.
     */
    public static LogMessage newBatchLog( Exception exceptionObj, String batchJobId, SeverityLevel severityLevel ) {
        String message = exceptionObj.getMessage().left( 131072 );
        String traceString = exceptionObj.getStackTraceString();
        return new LogMessage( message, traceString, severityLevel )
            .withBatchJobId( batchJobId )
            .withException( exceptionObj );
    }

    /**
     * @description Generates a new log object for an Apex API callout error
     * @param message String error message to capture in the log
     * @param responseStatus The response status value from System.HttpResponse.getStatus()
     * @param responseStatusCode The response status code from System.HttpResponse.getStatusCode()
     * @param requestEndpoint The target url for the callout from System.HttpRequest.getEndpoint()
     * @return LogMessage object required by Logger.
     */
    public static LogMessage newCalloutLog( String message, String responseStatus, String responseStatusCode, String requestEndpoint ) {
        String traceString = new DmlException().getStackTraceString().substringAfter( '\n' );
        return new LogMessage( message, traceString, SeverityLevel.LOW )
            .withCallout( responseStatus, responseStatusCode, requestEndpoint )
            .withLogType( LogCategory.API_CALLOUT_EXCEPTION );
    }

    /**
     * @description Generates a new log object for a list of failed Database.SaveResult objects
     * @param dmlResultList List of Database.SaveResult objects
     * @param dmlRecordList List of SObjects included in the DML transaction
     * @param severityLevel LogMessage.SeverityLevel enum to indicate the level of severity
     * @return LogMessage object required by Logger.
     */
    public static LogMessage newDmlLog( List<Database.SaveResult> dmlResultList, List<SObject> dmlRecordList, SeverityLevel severityLevel ) {
        String traceString = new DmlException().getStackTraceString().substringAfter( '\n' );
        return new LogMessage( '', traceString, severityLevel )
            .withLogType( LogCategory.DML_EXCEPTION )
            .withDmlResults( dmlResultList, dmlRecordList );
    }

    /**
     * @description Generates a new log object for a list of failed Database.UpsertResult objects
     * @param dmlResultList List of Database.UpsertResult objects
     * @param dmlRecordList List of SObjects included in the DML transaction
     * @param severityLevel LogMessage.SeverityLevel enum to indicate the level of severity
     * @return LogMessage object required by Logger.
     */
    public static LogMessage newDmlLog( List<Database.UpsertResult> dmlResultList, List<SObject> dmlRecordList, SeverityLevel severityLevel ) {
        String traceString = new DmlException().getStackTraceString().substringAfter( '\n' );
        return new LogMessage( '', traceString, severityLevel )
            .withLogType( LogCategory.DML_EXCEPTION )
            .withDmlResults( dmlResultList, dmlRecordList );
    }

    /**
     * @description Generates a new log object for a list of failed Database.DeleteResult objects
     * @param dmlResultList List of Database.DeleteResult objects
     * @param dmlRecordList List of SObjects included in the DML transaction
     * @param severityLevel LogMessage.SeverityLevel enum to indicate the level of severity
     * @return LogMessage object required by Logger.
     */
    public static LogMessage newDmlLog( List<Database.DeleteResult> dmlResultList, List<SObject> dmlRecordList, SeverityLevel severityLevel ) {
        String traceString = new DmlException().getStackTraceString().substringAfter( '\n' );
        return new LogMessage( '', traceString, severityLevel )
            .withLogType( LogCategory.DML_EXCEPTION )
            .withDmlResults( dmlResultList, dmlRecordList );
    }

    /**
     * @description Converts the log event into a Log__c record
     * @param event Log_Event__e SObject
     * @return Log__c SObject
     */
    public static Log__c eventToLogRecord( Log_Event__e event ) {
        return new Log__c(
            Batch_Job_ID__c = event.Batch_Job_ID__c,
            Callout_Request_Endpoint__c = event.Callout_Request_Endpoint__c,
            Callout_Status_Code__c = event.Callout_Status_Code__c,
            Class_Line_Number__c = event.Class_Line_Number__c,
            Class_Method_Name__c = event.Class_Method_Name__c,
            Class_Name__c = event.Class_Name__c,
            Detailed_Message__c = event.Detailed_Message__c,
            Failed_Record_Count__c = event.Failed_Record_Count__c,
            Governor_Limits_Logged__c = event.Governor_Limits_Logged__c,
            Log_Type__c = event.Log_Type__c,
            Quiddity__c = event.Quiddity__c,
            Record_Id__c = event.Record_Id__c,
            Request_Id__c = event.Request_Id__c,
            Severity_Level__c = event.Severity_Level__c,
            Stack_Trace__c = event.Stack_Trace__c,
            Status__c = event.Status__c
        );
    }


    /**
     * @description Provides a list of possible categories or log type values
     */
    public enum LogCategory {
        GENERIC_LOG,
        API_CALLOUT_EXCEPTION,
        DML_EXCEPTION
    }

    /**
     * @description Provides a list of possible severity levels values
     */
    public enum SeverityLevel {
        LOW,
        MEDIUM,
        HIGH,
        CRITICAL
    }

    /**
     * @description Public read only property for the request id. Privately set.
     */
    public String requestId {
        get {
            if( requestId == null ) {
                requestId = Request.getCurrent().getRequestId();
            }
            return requestId;
        }
        private set;
    }

    /**
     * @description Public read only property for quiddity. Privately set.
     */
    public Quiddity quiddity {
        get {
            if( quiddity == null ) {
                quiddity = Request.getCurrent().getQuiddity();
            }
            return quiddity;
        }
        private set;
    }

    /**
     * @description Public read only property for platform limits for the current transaction.. Privately set.
     */
    public String governorLimits {
        get {
            return String.format( GOVERNOR_LIMITS_STRING_FORMAT, new String[]{
                String.valueOf( Limits.getQueries() ),
                String.valueOf( Limits.getLimitQueries() ),
                String.valueOf( Limits.getDmlRows() ),
                String.valueOf( Limits.getLimitDmlRows() ),
                String.valueOf( Limits.getDmlStatements() ),
                String.valueOf( Limits.getLimitDmlStatements() ),
                String.valueOf( Limits.getCpuTime() ),
                String.valueOf( Limits.getLimitCpuTime() )
            } );
        }
        private set;
    }

    /**
     * @description Public property for Exception object.
     */
    public Exception exceptionObj {
        get {
            return exceptionObj;
        }
        set {
            this.exceptionObj = value;
            this.lineNumber = value.getLineNumber();
            this.stackTrace = value.getStackTraceString().left( 131072 );
            this.logType = value.getTypeName();
            this.message = value.getMessage();
        }
    }

    /**
     * @description Public message property.
     */
    public String message { get; set; }

    /**
     * @description Public severity property.
     */
    public SeverityLevel severity { get; set; }

    /**
     * @description Public logType property.  Value is derived from the LogCategory name or the Exception type
     */
    public String logType { get; set; }

    /**
     * @description Public class name property.  The class that called the log.
     */
    public String className { get; set; }

    /**
     * @description Public class method name property.  The class method that called the log.
     */
    public String methodName { get; set; }

    /**
     * @description Public record id property.  Contains the record Ids from DmlException logs
     */
    public String recordId { get; set; }

    /**
     * @description Public batch job id property.
     */
    public String batchJobId { get; set; }

    /**
     * @description Public class line number property.
     */
    public Integer lineNumber { get; set; }

    /**
     * @description Public stack trace property.
     */
    public String stackTrace { get; set; }

    /**
     * @description Public callout response status property.
     */
    public String calloutResponseStatus { get; set; }

    /**
     * @description Public callout response status code property.
     */
    public String calloutResponseStatusCode { get; set; }

    /**
     * @description Public callout request endpoint property.
     */
    public String calloutRequestEndpoint { get; set; }

    /**
     * @description Public property for the number of failed records.
     */
    public Integer failedRecordCount { get; set; }


    /**
     * @description Constructor
     * @param trace String stack trace that is used to derive the class name and class method
     */
    public LogMessage( String trace ) {
        this( '', trace );
    }

    /**
     * @description Overloaded constructor
     * @param message String error message to log
     * @param trace String stack trace that is used to derive the class name and class method
     */
    public LogMessage( String message, String trace ) {
        this( message, trace, SeverityLevel.LOW );
    }

    /**
     * @description Overloaded constructor
     * @param exceptionObj Any custom or standard exception object
     * @param severityLevel SeverityLog enum
     */
    public LogMessage( Exception exceptionObj, SeverityLevel severityLevel ) {
        this(
            exceptionObj.getMessage(),
            exceptionObj.getStackTraceString(),
            severityLevel
        );
    }

    /**
     * @description Overloaded constructor
     * @param message String error message to log
     * @param trace String stack trace that is used to derive the class name and class method
     * @param severityLevel SeverityLog enum
     */
    public LogMessage( String message, String trace, SeverityLevel severityLevel ) {
        this.message = message;
        this.className = getClassName( trace );
        this.methodName = getMethodName( trace );
        this.failedRecordCount = 0;
        this.logType = LogCategory.GENERIC_LOG.name();
        this.severity = severityLevel;
    }

    /**
     * @description Fluent method to apply a LogCategory value to the LogMessage object
     * @param logCategory LogCategory enum
     * @return LogMessage this
     */
    public LogMessage withLogType( LogCategory logCategory ) {
        this.logType = logCategory.name();
        return this;
    }

    /**
     * @description Fluent method to apply a batchJobId value to the LogMessage object
     * @param batchJobId String id of the async apex job
     * @return LogMessage this
     */
    public LogMessage withBatchJobId( String batchJobId ) {
        this.batchJobId = batchJobId;
        return this;
    }

    /**
     * @description Fluent method to apply an Exception object to the LogMessage object
     * @param e Exception object
     * @return LogMessage this
     */
    public LogMessage withException( Exception e ) {
        this.exceptionObj = e;
        return this;
    }

    /**
     * @description Fluent method to apply callout values to the LogMessage object
     * @param responseStatus HttpResponse.getStatus() value
     * @param responseStatusCode HttpResponse.getStatusCode() value
     * @param requestEndpoint HttpRequest.getEndpoint() value
     * @return LogMessage this
     */
    public LogMessage withCallout( String responseStatus, String responseStatusCode, String requestEndpoint ) {
        this.calloutResponseStatus = responseStatus;
        this.calloutResponseStatusCode = responseStatusCode;
        this.calloutRequestEndpoint = requestEndpoint;
        return this;
    }

    /**
     * @description Fluent method to apply Database.SaveResult values to the LogMessage object
     * @param dmlResultList List<Database.SaveResult> objects
     * @param dmlRecordList List<SObject> records in the DML transaction
     * @return LogMessage this
     */
    public LogMessage withDmlResults( List<Database.SaveResult> dmlResultList, List<SObject> dmlRecordList ) {
        if( dmlResultList == null || dmlResultList.isEmpty() ) return this;

        Set<String> errors = new Set<String>();
        Set<String> failedRecordIds = new Set<String>();
        for( Integer i = 0; i < dmlResultList.size(); i++ ) {
            Database.SaveResult result = dmlResultList[i];
            if( result.isSuccess() ) continue;

            SObject record = dmlRecordList[i];
            if( record.Id != null ) failedRecordIds.add( record.Id );

            errors.addAll( serializeErrorMessages( result.getErrors() ) );
        }

        if( errors.size() == 0 ) return this;

        return withDmlResults( errors, failedRecordIds );
    }

    /**
     * @description Fluent method to apply Database.UpsertResult values to the LogMessage object
     * @param dmlResultList List<Database.UpsertResult> objects
     * @param dmlRecordList List<SObject> records in the DML transaction
     * @return LogMessage this
     */
    public LogMessage withDmlResults( List<Database.UpsertResult> dmlResultList, List<SObject> dmlRecordList ) {
        if( dmlResultList == null || dmlResultList.isEmpty() ) return this;

        Set<String> errors = new Set<String>();
        Set<String> failedRecordIds = new Set<String>();
        for( Integer i = 0; i < dmlResultList.size(); i++ ) {
            Database.UpsertResult result = dmlResultList[i];
            if( result.isSuccess() ) continue;

            SObject record = dmlRecordList[i];
            if( record.Id != null ) failedRecordIds.add( record.Id );

            errors.addAll( serializeErrorMessages( result.getErrors() ) );
        }

        if( errors.size() == 0 ) return this;

        return withDmlResults( errors, failedRecordIds );
    }

    /**
     * @description Fluent method to apply Database.DeleteResult values to the LogMessage object
     * @param dmlResultList List<Database.DeleteResult> objects
     * @param dmlRecordList List<SObject> records in the DML transaction
     * @return LogMessage this
     */
    public LogMessage withDmlResults( List<Database.DeleteResult> dmlResultList, List<SObject> dmlRecordList ) {
        if( dmlResultList == null || dmlResultList.isEmpty() ) return this;

        Set<String> errors = new Set<String>();
        Set<String> failedRecordIds = new Set<String>();
        for( Integer i = 0; i < dmlResultList.size(); i++ ) {
            Database.DeleteResult result = dmlResultList[i];
            if( result.isSuccess() ) continue;

            SObject record = dmlRecordList[i];
            if( record.Id != null ) failedRecordIds.add( record.Id );

            errors.addAll( serializeErrorMessages( result.getErrors() ) );
        }

        if( errors.size() == 0 ) return this;

        return withDmlResults( errors, failedRecordIds );
    }

    /**
     * @description Generates the Log_Event__e object to publish
     * @return Log_Event__e
     */
    public Log_Event__e toEvent() {
        return new Log_Event__e(
            Batch_Job_ID__c = this.batchJobId,
            Callout_Request_Endpoint__c = this.calloutRequestEndpoint,
            Callout_Status_Code__c = this.calloutResponseStatusCode,
            Class_Line_Number__c = this.lineNumber,
            Class_Method_Name__c = this.methodName,
            Class_Name__c = this.className,
            Detailed_Message__c = this.message,
            Failed_Record_Count__c = this.failedRecordCount,
            Governor_Limits_Logged__c = this.governorLimits,
            Log_Type__c = this.logType,
            Quiddity__c = this.quiddity.name(),
            Record_Id__c = this.recordId,
            Request_Id__c = this.requestId,
            Severity_Level__c = this.severity.name(),
            Stack_Trace__c = this.stackTrace,
            Status__c = this.calloutResponseStatus
        );
    }

    /**
     * @description Generates the Log__c record to save
     * @return Log__c
     */
    public Log__c toRecord() {
        return new Log__c(
            Batch_Job_ID__c = this.batchJobId,
            Callout_Request_Endpoint__c = this.calloutRequestEndpoint,
            Callout_Status_Code__c = this.calloutResponseStatusCode,
            Class_Line_Number__c = this.lineNumber,
            Class_Method_Name__c = this.methodName,
            Class_Name__c = this.className,
            Detailed_Message__c = this.message,
            Failed_Record_Count__c = this.failedRecordCount,
            Governor_Limits_Logged__c = this.governorLimits,
            Log_Type__c = this.logType,
            Quiddity__c = this.quiddity.name(),
            Record_Id__c = this.recordId,
            Request_Id__c = this.requestId,
            Severity_Level__c = this.severity.name(),
            Stack_Trace__c = this.stackTrace,
            Status__c = this.calloutResponseStatus
        );
    }

    /**
     * @description Summarizes the results of the Database result objects
     * @param errors Set<String> error messages from Database result objects
     * @param failedRecordIds Set<String> record ids that failed in the DML transaction attempt
     * @return
     */
    private LogMessage withDmlResults( Set<String> errors, Set<String> failedRecordIds ) {
        this.failedRecordCount += errors.size();
        this.message = convertSetToString( errors, '\n' );
        this.recordId = convertSetToString( failedRecordIds, ', ' );
        return this;
    }

    /**
     * @description Derives the class name from the string of an Exception stack trace
     * @param trace String stack trace from Exception object
     * @return
     */
    private String getClassName( String trace ) {
        if( trace.startsWith( 'Class.' ) ) {
            trace = trace.substringAfter( 'Class.' );
        }
        return trace.substringBefore( ':' ).substringBeforeLast( '.' );
    }

    /**
     * @description Derives the class method name from the string of an Exception stack trace
     * @param trace String stack trace from Exception object
     * @return
     */
    private String getMethodName( String trace ) {
        return trace.substringBefore( ':' ).substringAfterLast( '.' );
    }

    /**
     * @description Concatenates a list of Database.Errors from a Database result object
     * @param errors List<Database.Error>
     * @return Set<String> concatenated results
     */
    private static Set<String> serializeErrorMessages( List<Database.Error> errors ) {
        Set<String> logMessages = new Set<String>();
        for( Database.Error eachError : errors ) {
            logMessages.add( eachError.getStatusCode() + ' - '
                + eachError.getMessage() + ' - '
                + eachError.getFields() );
        }
        return logMessages;
    }

    /**
     * @description Concatenates a set of string values with a given separator and truncates the final
     * result to fit in a 131072 character long text area field
     * @param objectList Set<String> values to be concatenated
     * @param separator the connecting text between each concatenated value
     * @return
     */
    private static String convertSetToString( Set<String> objectList, String separator ) {
        String concatValues = String.join( ( Iterable<String> ) objectList, separator );
        return concatValues.left( 131069 ) + '...';
    }
}