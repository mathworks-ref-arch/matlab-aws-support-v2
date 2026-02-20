## ☁️ 6.11 Systems Manager (SSM)

MATLAB client for AWS Systems Manager Parameter Store and Documents.

```matlab
ssm = aws.ssm.Client();
```

### 🔧 6.11.1 List of Available Methods

- [putParameter](AWSSDKAPI.md#awsssmclientputparameter)  
- [getParameter](AWSSDKAPI.md#awsssmclientgetparameter)  
- [deleteParameter](AWSSDKAPI.md#awsssmclientdeleteparameter)  
- [createDocument](AWSSDKAPI.md#awsssmclientcreatedocument)  
- [deleteDocument](AWSSDKAPI.md#awsssmclientdeletedocument)  

### 🧩 6.11.2 Examples

Put and get a parameter
```matlab
ssm = aws.ssm.Client();
ssm.putParameter(name="/matlab/demo", value="42", type="String", overwrite=true);
gr = ssm.getParameter(name="/matlab/demo");
disp(gr.parameter);
```

### 📘 6.11.3 Method Reference (Summary)

#### 🔸 `putParameter`
```matlab
pp = ssm.putParameter(name="<name>", value="<value>", type="String", overwrite=true);
```
*   Returns: `aws.ssm.model.PutParameterResponse`

#### 🔸 `getParameter`
```matlab
gp = ssm.getParameter(name="<name>");
```
*   Returns: `aws.ssm.model.GetParameterResponse`

#### 🔸 `deleteParameter`
```matlab
dp = ssm.deleteParameter(name="<name>");
```
*   Returns: `aws.ssm.model.DeleteParameterResponse`

#### 🔸 `createDocument`
```matlab
cd = ssm.createDocument(name="<name>", content="<json>", documentType="Command");
```
*   Returns: `aws.ssm.model.CreateDocumentResponse`

#### 🔸 `deleteDocument`
```matlab
dd = ssm.deleteDocument(name="<name>");
```
*   Returns: `aws.ssm.model.DeleteDocumentResponse`

```{seealso}
🔗 Data Models: PutParameterResponse, GetParameterResponse, DeleteParameterResponse, CreateDocumentResponse, DocumentDescription
```
