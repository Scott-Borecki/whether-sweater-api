# Retrieve a Background Image for a City

Retrieve a background image for a given city.

```
GET /api/v1/backgrounds
```

### Parameters

Name       | Data Type    | In    | Required/Optional | Description
-----------|--------------|-------|-------------------|------------
`location` | String | Query | Required | Specify the city of which to return the weather, in the format of `city,state`.

### Example Request

```
GET http://localhost:3000/api/v1/backgrounds?location=denver,co
```

### Example Response

```
Status: 200 OK
```

```
{
    "data": {
        "id": null,
        "type": "image",
        "attributes": {
            "image": {
                "location": "LoDo, Denver, CO, USA",
                "image_url": "https://images.unsplash.com/photo-1584289537662-27851fd5ab5b?crop=entropy&cs=srgb&fm=jpg&ixid=MnwyNjMyMDd8MHwxfHJhbmRvbXx8fHx8fHx8fDE2MzI3OTIwOTY&ixlib=rb-1.2.1&q=85",
                "credit": {
                    "source": "https://unsplash.com/@sebbykurps",
                    "author": "sebbykurps"
                }
            }
        }
    }
}
```
