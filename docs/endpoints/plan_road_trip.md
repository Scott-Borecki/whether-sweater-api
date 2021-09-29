<div align="center">
  <h1>Plan a Road Trip</h1>

  <p>
    <img src='/docs/wireframes/road_trip_wireframe.png' alt='Sweater Weather Road Trip Wireframe' width='80%'>
  </p>
</div>

Retrieve the weather at the destination based on the ETA at the destination.

```
GET /api/v1/road_trip
```

### Parameters

Name       | Data Type    | In    | Required/Optional | Description
-----------|--------------|-------|-------------------|------------
`origin`   | String       | Body  | Required | Specify the origin city, in the format of `city,state`.
`destination` | String    | Body  | Required | Specify the destination city, in the format of `city,state`.
`api_key`  | String       | Body  | Required | Specify the user's API key.

### Example Request

```
GET http://localhost:3000/api/v1/road_trip
```

With the following example request body:

```
{
    "origin": "Denver,CO",
    "destination": "Pueblo,CO",
    "api_key": "2f346fe33cb949b030ffe2637ab9c29c"
}
```

### Example Response

```
Status: 200 OK
```

```
{
    "data": {
        "id": null,
        "type": "roadtrip",
        "attributes": {
            "start_city": "Denver, CO",
            "end_city": "Pueblo, CO",
            "travel_time": "1 hour, 58 minutes",
            "weather_at_eta": {
                "conditions": "clear sky",
                "temperature": 84.7
            }
        }
    }
}
```
