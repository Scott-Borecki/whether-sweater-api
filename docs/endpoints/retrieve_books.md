# Retrive Books Based on Your Destination

Retrieve books based on your destination city.

```
GET /api/v1/book-search
```

### Parameters

Name       | Data Type    | In    | Required/Optional | Description
-----------|--------------|-------|-------------------|------------
`location` | String       | Query  | Required | Specify the destination city, in the format of `city,state`.
`quantity` | Integer      | Query  | Optional | Specify the number of books to return.<br>Default: `5`.<br>Must be greater than `0`.

### Example Request

```
GET http://localhost:3000/api/v1/book-search?location=denver,co&quantity=5
```

### Example Response

```
Status: 200 OK
```

```
{
    "data": {
        "id": null,
        "type": "books",
        "attributes": {
            "destination": "denver,co",
            "forecast": {
                "summary": "few clouds",
                "temperature": "86 F"
            },
            "total_books_found": 35990,
            "books": [
                {
                    "title": "Denver, Co",
                    "isbn": [
                        "9780762507849",
                        "0762507845"
                    ],
                    "publisher": [
                        "Universal Map Enterprises"
                    ]
                },
                {
                    "title": "University of Denver Co 2007",
                    "isbn": [
                        "1427401683",
                        "9781427401687"
                    ],
                    "publisher": [
                        "College Prowler"
                    ]
                },
                {
                    "title": "Denver Co Deluxe Flip Map",
                    "isbn": [
                        "9780762557363",
                        "0762557362"
                    ],
                    "publisher": [
                        "Universal Map Enterprises"
                    ]
                },
                {
                    "title": "Photovoltaic safety, Denver, CO, 1988",
                    "isbn": [
                        "9780883183663",
                        "0883183668"
                    ],
                    "publisher": [
                        "American Institute of Physics"
                    ]
                },
                {
                    "title": "Insight Fleximap Denver, CO (Insight Fleximaps)",
                    "isbn": [
                        "9812582622",
                        "9789812582621"
                    ],
                    "publisher": [
                        "American Map Corporation"
                    ]
                }
            ]
        }
    }
}
```
