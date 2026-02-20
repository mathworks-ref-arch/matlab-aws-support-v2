## ☁️ 6.5 Lambda

MATLAB client for AWS Lambda. Create, invoke, and delete functions.

```matlab
lambda = aws.lambda.Client();
```

### 🔧 6.5.1 List of Available Methods

- [createFunction](AWSSDKAPI.md#awslambdaclientcreatefunction)  
- [invokeFunction](AWSSDKAPI.md#awslambdaclientinvokefunction)
- [deleteFunction](AWSSDKAPI.md#awslambdaclientdeletefunction)

### 🧩 6.5.2 Examples

Create and invoke a function (simplified)
```matlab
lambda = aws.lambda.Client();

code = aws.lambda.model.FunctionCode(zipFile="/path/to/function.zip");
resp = lambda.createFunction(functionName="matlab-demo", runtime="python3.12", role="<role-arn>", handler="index.handler", code=code);

ir = lambda.invokeFunction(functionName="matlab-demo", payload=aws.core.model.SdkBytes.fromUtf8String("{}"));
disp(ir.statusCode);
```

### 📘 6.5.3 Method Reference (Summary)

#### 🔸 `createFunction`
```matlab
resp = lambda.createFunction(functionName="<name>", runtime="<runtime>", role="<role-arn>", handler="<handler>", code=<FunctionCode>);
```
*   Returns: `aws.lambda.model.CreateFunctionResponse`

#### 🔸 `invokeFunction`
```matlab
resp = lambda.invokeFunction(functionName="<name>", payload=<SdkBytes>, invocationType="RequestResponse");
```
*   Returns: `aws.lambda.model.InvokeFunctionResponse`

#### 🔸 `deleteFunction`
```matlab
resp = lambda.deleteFunction(functionName="<name>");
```
*   Returns: `aws.lambda.model.DeleteFunctionResponse`

```{seealso}
🔗 Data Models: FunctionCode, CreateFunctionResponse, InvokeFunctionResponse, DeleteFunctionResponse
```
