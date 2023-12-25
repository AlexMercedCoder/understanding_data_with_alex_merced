### Getting an Auth Token

```shell
curl -X POST 'http://localhost:9047/apiv2/login' \
--header 'Content-Type: application/json' \
--data-raw '{
"userName": "username",
"password": "password"
}'
```

example response:

```json
{
  "token": "o37sfbrkvuva2nlc3tnc50il72",
  "userName": "alexmerced",
  "firstName": "Alex",
  "lastName": "Merced",
  "expires": 1703549412550,
  "email": "data@alexmerced.com",
  "userId": "4181f938-4a7c-4e4a-9e52-cf98bc0450dc",
  "admin": true,
  "clusterId": "30f59341-f8d6-413d-aa40-d83616b2cf23",
  "clusterCreatedAt": 1703369496672,
  "version": "24.2.6-202311250456170399-68acbe47",
  "permissions": {
    "canUploadProfiles": true,
    "canDownloadProfiles": true,
    "canEmailForSupport": true,
    "canChatForSupport": false,
    "canViewAllJobs": true,
    "canCreateUser": true,
    "canCreateRole": true,
    "canCreateSource": true,
    "canUploadFile": true,
    "canManageNodeActivity": true,
    "canManageEngines": true,
    "canManageQueues": true,
    "canManageEngineRouting": true,
    "canManageSupportSettings": true
  },
  "userCreatedAt": 1703369927940
}
```

