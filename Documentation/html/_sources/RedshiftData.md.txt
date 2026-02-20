## ☁️ 6.7 Redshift Data

MATLAB client for Amazon Redshift Data API. Execute SQL statements and retrieve results.

```matlab
rs = aws.redshiftdata.Client('region', 'us-east-1');
```

### 🔧 6.7.1 List of Available Methods

- [executeStatement](AWSSDKAPI.md#awsredshiftdataclientexecutestatement)  
- [getStatementResult](AWSSDKAPI.md#awsredshiftdataclientgetstatementresult)  

### 🧩 6.7.2 Examples

Execute a statement and fetch results
```matlab
ex = rs.executeStatement(sql="SELECT 1 AS x", workgroupName="<serverless>", database="dev");
gr = rs.getStatementResult(id=ex.id);
tbl = gr.getResultSet();
disp(tbl);

if gr.hasNextToken
    nextPage = rs.getStatementResult(id=ex.id, nextToken=gr.nextToken);
end
```

### 📘 6.7.3 Method Reference (Summary)

#### 🔸 `executeStatement`
```matlab
resp = rs.executeStatement(sql="<SQL>", workgroupName="<serverless>", database="<db>");
```
*   Returns: `aws.redshiftdata.model.ExecuteStatementResponse` containing the statement ID.

#### 🔸 `getStatementResult`
```matlab
resp = rs.getStatementResult(id="<statement-id>");
```
*   Returns: `aws.redshiftdata.model.GetStatementResultResponse` (records, metadata, pagination).
