# User Login

Login a user and retrieve the user's API key.

```
POST /api/v1/sessions
```

### Parameters

Name       | Data Type    | In    | Required/Optional | Description
-----------|--------------|-------|-------------------|------------
`email`    | String       | Body  | Required | Specify the user's email.
`password` | String       | Body  | Required | Specify the user's password.

### Example Request

```
POST http://localhost:3000/api/v1/sessions
```

With the following example request body:

```
{
    "email": "whatever@example.com",
    "password": "password",
}
```

### Example Response

```
Status: 200 OK
```

```
{
    "data": {
        "id": "1",
        "type": "user",
        "attributes": {
            "email": "whatever@example.com",
            "api_key": "2f346fe33cb949b030ffe2637ab9c29c"
        }
    }
}
```
