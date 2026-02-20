## ☁️ 6.1 Athena

A MATLAB client for the Amazon Athena service. Use it to run SQL queries on data in Amazon S3 via Athena's serverless engine.

```matlab
athena = aws.athena.Client('region', 'us-east-1');
```

```{note}
Athena queries require a valid S3 output location and access to a database in your AWS Glue Data Catalog.
```

### 🔧 6.1.1 List of Available Methods

- [getQueryExecution](AWSSDKAPI.md#awsathenaclientgetqueryexecution)
- [getQueryResults](AWSSDKAPI.md#awsathenaclientgetqueryresults)
- [startQueryExecution](AWSSDKAPI.md#awsathenaclientstartqueryexecution)
- [stopQueryExecution](AWSSDKAPI.md#awsathenaclientstopqueryexecution)

### 🧩 6.1.2 Examples

Start a simple query:
```matlab
queryString = "SELECT 1 AS test_col";
rc = aws.athena.model.ResultConfiguration(outputLocation = "s3://your-bucket/results/");
qc = aws.athena.model.QueryExecutionContext(database = "your-database");

resp = athena.startQueryExecution( ...
    queryString = queryString, ...
    queryExecutionContext = qc, ...
    resultConfiguration = rc);

disp(resp.queryExecutionId);
```

Wait for completion:
```matlab
maxWait = 60;
tStart = tic;
while true
    statusResp = athena.getQueryExecution(queryExecutionId = resp.queryExecutionId);
    state = string(statusResp.status.state);
    if state == "SUCCEEDED"
        break;
    elseif state == "FAILED" || state == "CANCELLED"
        error("Query failed or was cancelled: %s", state);
    elseif toc(tStart) > maxWait
        error("Query timed out after %d seconds", maxWait);
    end
    pause(2);
end
```

Fetch results:
```matlab
resultResp = athena.getQueryResults(queryExecutionId = resp.queryExecutionId);
disp(resultResp.resultSet);
```

Stop a running query:
```matlab
stopResp = athena.stopQueryExecution(queryExecutionId = resp.queryExecutionId);
disp(stopResp.statusCode);
```

### 📘 6.1.3 Method Reference (Summary)

#### 🔸 `startQueryExecution`
```matlab
response = athena.startQueryExecution( ...
    queryString = "<SQL>", ...
    queryExecutionContext = <QueryExecutionContext>, ...
    resultConfiguration = <ResultConfiguration>);
```
*   Returns: `aws.athena.model.StartQueryExecutionResponse` (includes `queryExecutionId`)

#### 🔸 `getQueryExecution`
```matlab
statusResp = athena.getQueryExecution(queryExecutionId = "<id>");
```
*   Returns: `aws.athena.model.GetQueryExecutionResponse`

#### 🔸 `getQueryResults`
```matlab
resultResp = athena.getQueryResults(queryExecutionId = "<id>", maxResults = <int>);
```
*   Returns: `aws.athena.model.GetQueryResultsResponse`

#### 🔸 `stopQueryExecution`
```matlab
stopResp = athena.stopQueryExecution(queryExecutionId = "<id>");
```
*   Returns: `aws.athena.model.StopQueryExecutionResponse`

```{seealso}
🔗 Data Models:
- [ResultConfiguration](AWSSDKAPI.md#aws-athena-model-resultconfiguration)
- [QueryExecutionContext](AWSSDKAPI.md#aws-athena-model-queryexecutioncontext)
- [StartQueryExecutionResponse](AWSSDKAPI.md#aws-athena-model-startqueryexecutionresponse)
- [StopQueryExecutionResponse](AWSSDKAPI.md#aws-athena-model-stopqueryexecutionresponse)
- [GetQueryExecutionResponse](AWSSDKAPI.md#aws-athena-model-getqueryexecutionresponse)
- [GetQueryResultsResponse](AWSSDKAPI.md#aws-athena-model-getqueryresultsresponse)
```
