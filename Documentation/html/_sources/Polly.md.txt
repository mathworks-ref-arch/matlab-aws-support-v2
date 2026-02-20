## ☁️ 6.6 Polly

MATLAB client for Amazon Polly. Manage lexicons, list voices, and synthesize speech.

```matlab
polly = aws.polly.Client();
```

### 🔧 6.6.1 List of Available Methods

- [describeVoices](AWSSDKAPI.md#awspollyclientdescribevoices)  
- [synthesizeSpeech](AWSSDKAPI.md#awspollyclientsynthesizespeech)  
- [putLexicon](AWSSDKAPI.md#awspollyclientputlexicon)  
- [getLexicon](AWSSDKAPI.md#awspollyclientgetlexicon)  
- [deleteLexicon](AWSSDKAPI.md#awspollyclientdeletelexicon)

### 🧩 6.6.2 Examples

Synthesize speech to bytes
```matlab
resp = polly.synthesizeSpeech(text="Hello from MATLAB", voiceId="Joanna", outputFormat="mp3");
fid = fopen("hello.mp3","w");
fwrite(fid, resp.audioStream, "uint8");
fclose(fid);
```

Upload and retrieve a lexicon
```matlab
xml = fileread("medicalTerms.pls");
polly.putLexicon(name="medicalTerms", content=xml);
lex = polly.getLexicon(name="medicalTerms");
disp(lex.lexiconContent(1:120) + "...");
```

### 📘 6.6.3 Method Reference (Summary)

#### 🔸 `describeVoices`
```matlab
dv = polly.describeVoices(languageCode="en-US");
```
*   Returns: `aws.polly.model.DescribeVoicesResponse`

#### 🔸 `synthesizeSpeech`
```matlab
sr = polly.synthesizeSpeech(text="<text>", voiceId="<voice>", outputFormat="mp3");
```
*   Returns: `aws.polly.model.SynthesizeSpeechResponse`

#### 🔸 `putLexicon`
```matlab
pl = polly.putLexicon(name="<name>", content="<lexicon-xml>");
```
*   Returns: `aws.polly.model.PutLexiconResponse`

#### 🔸 `getLexicon`
```matlab
lx = polly.getLexicon(name="<name>");
```
*   Returns: `aws.polly.model.GetLexiconResponse`

#### 🔸 `deleteLexicon`
```matlab
dl = polly.deleteLexicon(name="<name>");
```
*   Returns: `aws.polly.model.DeleteLexiconResponse`

Data Models: SynthesizeSpeechResponse, DescribeVoicesResponse, GetLexiconResponse, PutLexiconResponse, DeleteLexiconResponse, Voice.
