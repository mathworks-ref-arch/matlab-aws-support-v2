## ☁️ 6.12 STS

MATLAB client for AWS Security Token Service (STS). Retrieve identity details of the caller.

```matlab
sts = aws.sts.Client();
```

### 🔧 6.12.1 List of Available Methods

- [getCallerIdentity](AWSSDKAPI.md#awsstsclientgetcalleridentity)

### 🧩 6.12.2 Examples

Get identity
```matlab
resp = sts.getCallerIdentity();
disp(resp.accountId);
disp(resp.arn);
```

### 📘 6.12.3 Method Reference (Summary)

#### 🔸 `getCallerIdentity`
```matlab
resp = sts.getCallerIdentity();
```
*   Returns: `aws.sts.model.GetCallerIdentityResponse`

Data Models: GetCallerIdentityResponse.
