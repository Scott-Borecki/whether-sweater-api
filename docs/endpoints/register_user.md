<div align="center">
  <h1>User Registration</h1>

  <p>
    <img src='/docs/wireframes/registration_wireframe.png' alt='Sweater Weather User Registration Wireframe' width='80%'>
  </p>
</div>


Register a new user and generate a unique API key.

```
POST /api/v1/users
```

### Parameters

Name       | Data Type    | In    | Required/Optional | Description
-----------|--------------|-------|-------------------|------------
`email`    | String       | Body  | Required | Specify the new user's email.
`password` | String       | Body  | Required | Specify the new user's password.
`password_confirmation` | String       | Body  | Required | Confirm the new user's password.

### Example Request

```
POST http://localhost:3000/api/v1/users
```

With the following example request body:

```
{
    "email": "whatever@example.com",
    "password": "password",
    "password_confirmation": "password"
}
```

### Example Response

```
Status: 201 Created
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
