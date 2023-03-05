# README

## Learning Goals
- Expose an API that aggregates data from several external APIs
- Expose an API that requires an authorization token
- Test API consumption/exposure using webmock
- Implement caching
- Implement basic authentication using BCrypt


## Set up instructions


## Endpoints

### Get recipes for a given country
`GET /api/v1/recipes?country=<country name>`

### Get learning resources for a given country
`GET /api/v1/learning_resources?country=<country name>`

### User registration
```
POST /api/v1/users
Content-Type: application/json
Accept: application/json

{
  "name": "John Wick",
  "email": "JohnWick@syndicate.com"
}
```

### Add recipe to user favorite
```
POST /api/v1/favorites
Content-Type: application/json
Accept: application/json

{
    "api_key": "f7dd1e79c9292b34ccb1a69f7b84ecbc",
    "country": "thailand",
    "recipe_link": "https://www.tastingtable.com/.....",
    "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)"
}
```

### Get a users favorites
```
GET /api/v1/favorites?api_key=7da41fb7382a5f875ca0cdba958e7eb6
Content-Type: application/json
Accept: application/json
```

## Database design
![Users- name:string, email:string, api_key:string. Favorites- country:string, recipe_link:string, recipe_title:string, user_id:references](https://i.ibb.co/tqbNbh5/Screen-Shot-2023-03-05-at-10-55-20-AM.png "DB Diagram")


## APIs used
[REST Countries Documentation](https://restcountries.com/#api-endpoints-v3-all)
No API key needed

[Edamam Recipe API Documentation](https://developer.edamam.com/edamam-docs-recipe-api)
Get your key [here](https://developer.edamam.com/edamam-recipe-api)
