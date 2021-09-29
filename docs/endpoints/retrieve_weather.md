<div align="center">
  <h1>Retrieve Weather for a City</h1>

  <p>
    <img src='/docs/wireframes/root_wireframe.png' alt='Sweater Weather Root Wireframe' width='80%'>
  </p>
</div>

Retrieve the weather forecast for a given city.

```
GET /api/v1/forecast
```

### Parameters

Name       | Data Type    | In    | Required/Optional | Description
-----------|--------------|-------|-------------------|------------
`location` | String | Query | Required | Specify the city of which to return the weather, in the format of `city,state`.

### Example Request

```
GET http://localhost:3000/api/v1/forecast?location=denver,co
```

### Example Response

```
Status: 200 OK
```

```
{
    "data": {
        "id": null,
        "type": "forecast",
        "attributes": {
            "current_weather": {
                "datetime": "2021-09-28 01:19:10 UTC",
                "sunrise": "2021-09-27 12:52:30 UTC",
                "sunset": "2021-09-28 00:49:02 UTC",
                "temperature": 76.05,
                "feels_like": 74.34,
                "humidity": 21,
                "uvi": 0,
                "visibility": 10000,
                "conditions": "broken clouds",
                "icon": "04n"
            },
            "daily_weather": [
                {
                    "date": "2021-09-27",
                    "sunrise": "2021-09-27 12:52:30 UTC",
                    "sunset": "2021-09-28 00:49:02 UTC",
                    "max_temp": 86.54,
                    "min_temp": 65.84,
                    "conditions": "clear sky",
                    "icon": "01d"
                },
                {
                    "date": "2021-09-28",
                    "sunrise": "2021-09-28 12:53:27 UTC",
                    "sunset": "2021-09-29 00:47:23 UTC",
                    "max_temp": 80.37,
                    "min_temp": 64.92,
                    "conditions": "scattered clouds",
                    "icon": "03d"
                },
                {
                    "date": "2021-09-29",
                    "sunrise": "2021-09-29 12:54:24 UTC",
                    "sunset": "2021-09-30 00:45:45 UTC",
                    "max_temp": 72.77,
                    "min_temp": 52.03,
                    "conditions": "heavy intensity rain",
                    "icon": "10d"
                },
                {
                    "date": "2021-09-30",
                    "sunrise": "2021-09-30 12:55:21 UTC",
                    "sunset": "2021-10-01 00:44:07 UTC",
                    "max_temp": 62.2,
                    "min_temp": 52.11,
                    "conditions": "light rain",
                    "icon": "10d"
                },
                {
                    "date": "2021-10-01",
                    "sunrise": "2021-10-01 12:56:19 UTC",
                    "sunset": "2021-10-02 00:42:29 UTC",
                    "max_temp": 70.43,
                    "min_temp": 54.34,
                    "conditions": "clear sky",
                    "icon": "01d"
                },
                {
                    "date": "2021-10-02",
                    "sunrise": "2021-10-02 12:57:16 UTC",
                    "sunset": "2021-10-03 00:40:52 UTC",
                    "max_temp": 74.26,
                    "min_temp": 57.81,
                    "conditions": "clear sky",
                    "icon": "01d"
                },
                {
                    "date": "2021-10-03",
                    "sunrise": "2021-10-03 12:58:15 UTC",
                    "sunset": "2021-10-04 00:39:15 UTC",
                    "max_temp": 62.44,
                    "min_temp": 50.79,
                    "conditions": "clear sky",
                    "icon": "01d"
                },
                {
                    "date": "2021-10-04",
                    "sunrise": "2021-10-04 12:59:13 UTC",
                    "sunset": "2021-10-05 00:37:39 UTC",
                    "max_temp": 57.76,
                    "min_temp": 48.83,
                    "conditions": "overcast clouds",
                    "icon": "04d"
                }
            ],
            "hourly_weather": [
                {
                    "time": "01:00",
                    "temperature": 76.05,
                    "conditions": "broken clouds",
                    "icon": "04n"
                },
                {
                    "time": "02:00",
                    "temperature": 76.57,
                    "conditions": "broken clouds",
                    "icon": "04n"
                },
                {
                    "time": "03:00",
                    "temperature": 76.28,
                    "conditions": "broken clouds",
                    "icon": "04n"
                },
                {
                    "time": "04:00",
                    "temperature": 75.27,
                    "conditions": "broken clouds",
                    "icon": "04n"
                },
                {
                    "time": "05:00",
                    "temperature": 74.03,
                    "conditions": "overcast clouds",
                    "icon": "04n"
                },
                {
                    "time": "06:00",
                    "temperature": 72.34,
                    "conditions": "overcast clouds",
                    "icon": "04n"
                },
                {
                    "time": "07:00",
                    "temperature": 71.11,
                    "conditions": "overcast clouds",
                    "icon": "04n"
                },
                {
                    "time": "08:00",
                    "temperature": 69.91,
                    "conditions": "broken clouds",
                    "icon": "04n"
                },
                {
                    "time": "09:00",
                    "temperature": 69.51,
                    "conditions": "broken clouds",
                    "icon": "04n"
                },
                {
                    "time": "10:00",
                    "temperature": 69.06,
                    "conditions": "broken clouds",
                    "icon": "04n"
                },
                {
                    "time": "11:00",
                    "temperature": 69.78,
                    "conditions": "overcast clouds",
                    "icon": "04n"
                },
                {
                    "time": "12:00",
                    "temperature": 68.41,
                    "conditions": "overcast clouds",
                    "icon": "04n"
                },
                {
                    "time": "13:00",
                    "temperature": 67.41,
                    "conditions": "few clouds",
                    "icon": "02d"
                },
                {
                    "time": "14:00",
                    "temperature": 67.75,
                    "conditions": "few clouds",
                    "icon": "02d"
                },
                {
                    "time": "15:00",
                    "temperature": 70.14,
                    "conditions": "few clouds",
                    "icon": "02d"
                },
                {
                    "time": "16:00",
                    "temperature": 72.97,
                    "conditions": "scattered clouds",
                    "icon": "03d"
                },
                {
                    "time": "17:00",
                    "temperature": 75.85,
                    "conditions": "scattered clouds",
                    "icon": "03d"
                },
                {
                    "time": "18:00",
                    "temperature": 78.01,
                    "conditions": "scattered clouds",
                    "icon": "03d"
                },
                {
                    "time": "19:00",
                    "temperature": 79.32,
                    "conditions": "overcast clouds",
                    "icon": "04d"
                },
                {
                    "time": "20:00",
                    "temperature": 80.19,
                    "conditions": "overcast clouds",
                    "icon": "04d"
                },
                {
                    "time": "21:00",
                    "temperature": 80.33,
                    "conditions": "broken clouds",
                    "icon": "04d"
                },
                {
                    "time": "22:00",
                    "temperature": 80.37,
                    "conditions": "broken clouds",
                    "icon": "04d"
                },
                {
                    "time": "23:00",
                    "temperature": 78.13,
                    "conditions": "overcast clouds",
                    "icon": "04d"
                },
                {
                    "time": "00:00",
                    "temperature": 73.87,
                    "conditions": "overcast clouds",
                    "icon": "04d"
                },
                {
                    "time": "01:00",
                    "temperature": 70.43,
                    "conditions": "overcast clouds",
                    "icon": "04n"
                },
                {
                    "time": "02:00",
                    "temperature": 66.42,
                    "conditions": "overcast clouds",
                    "icon": "04n"
                },
                {
                    "time": "03:00",
                    "temperature": 65.3,
                    "conditions": "overcast clouds",
                    "icon": "04n"
                },
                {
                    "time": "04:00",
                    "temperature": 64.92,
                    "conditions": "overcast clouds",
                    "icon": "04n"
                },
                {
                    "time": "05:00",
                    "temperature": 65.53,
                    "conditions": "overcast clouds",
                    "icon": "04n"
                },
                {
                    "time": "06:00",
                    "temperature": 64.8,
                    "conditions": "overcast clouds",
                    "icon": "04n"
                },
                {
                    "time": "07:00",
                    "temperature": 64.45,
                    "conditions": "overcast clouds",
                    "icon": "04n"
                },
                {
                    "time": "08:00",
                    "temperature": 64.2,
                    "conditions": "broken clouds",
                    "icon": "04n"
                },
                {
                    "time": "09:00",
                    "temperature": 63.9,
                    "conditions": "overcast clouds",
                    "icon": "04n"
                },
                {
                    "time": "10:00",
                    "temperature": 64.06,
                    "conditions": "overcast clouds",
                    "icon": "04n"
                },
                {
                    "time": "11:00",
                    "temperature": 63.81,
                    "conditions": "overcast clouds",
                    "icon": "04n"
                },
                {
                    "time": "12:00",
                    "temperature": 63.59,
                    "conditions": "overcast clouds",
                    "icon": "04n"
                },
                {
                    "time": "13:00",
                    "temperature": 62.31,
                    "conditions": "few clouds",
                    "icon": "02d"
                },
                {
                    "time": "14:00",
                    "temperature": 62.1,
                    "conditions": "few clouds",
                    "icon": "02d"
                },
                {
                    "time": "15:00",
                    "temperature": 62.83,
                    "conditions": "clear sky",
                    "icon": "01d"
                },
                {
                    "time": "16:00",
                    "temperature": 64.8,
                    "conditions": "clear sky",
                    "icon": "01d"
                },
                {
                    "time": "17:00",
                    "temperature": 66.92,
                    "conditions": "clear sky",
                    "icon": "01d"
                },
                {
                    "time": "18:00",
                    "temperature": 69.15,
                    "conditions": "clear sky",
                    "icon": "01d"
                },
                {
                    "time": "19:00",
                    "temperature": 71.37,
                    "conditions": "few clouds",
                    "icon": "02d"
                },
                {
                    "time": "20:00",
                    "temperature": 72.77,
                    "conditions": "broken clouds",
                    "icon": "04d"
                },
                {
                    "time": "21:00",
                    "temperature": 72.14,
                    "conditions": "light rain",
                    "icon": "10d"
                },
                {
                    "time": "22:00",
                    "temperature": 59.2,
                    "conditions": "moderate rain",
                    "icon": "10d"
                },
                {
                    "time": "23:00",
                    "temperature": 56.03,
                    "conditions": "heavy intensity rain",
                    "icon": "10d"
                },
                {
                    "time": "00:00",
                    "temperature": 55.51,
                    "conditions": "light rain",
                    "icon": "10d"
                }
            ]
        }
    }
}
```
