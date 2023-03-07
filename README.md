# README

## Learning Goals
- Expose an API that aggregates data from several external APIs
- Expose an API that requires an authorization token
- Test API consumption/exposure using VCR
- Implement basic authentication using BCrypt


## Set up instructions
1. fork and clone the repo
1. run `bundle install`
1. run `bundle exec figaro install`
1. Add api keys to `application.yml`
 ```
RECIPE_APP_ID: <edamam app id>
RECIPE_API_KEY: <edamam api key>
YOUTUBE_API_KEY: <google api key>
PEXELS_API_KEY: <pexels api key>
 ```
 5. run `rails s` to start the server on `http://localhost:3000/`

_Note: if you are having an issue when running the server locally, but have passing tests you may want to delete the cassettes so you can test the actual API response_


## Endpoints

### Get recipes for a given country
`GET '/api/v1/recipes?country=<country name>'`

### Get recipes for a random country
`GET '/api/v1/recipes'`

### Get learning resources for a given country
`GET '/api/v1/learning_resources?country=<country name>'`

### User registration
```
POST '/api/v1/users'
Content-Type: application/json
Accept: application/json

{
  "name": "John Wick",
  "email": "JohnWick@syndicate.com"
}
```

### Add recipe to user favorite
```
POST '/api/v1/favorites'
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
GET '/api/v1/favorites?api_key=7da41fb7382a5f875ca0cdba958e7eb6'
Content-Type: application/json
Accept: application/json
```

## Database design
![Users- name:string, email:string, api_key:string. Favorites- country:string, recipe_link:string, recipe_title:string, user_id:references](https://i.ibb.co/tqbNbh5/Screen-Shot-2023-03-05-at-10-55-20-AM.png "DB Diagram")


## APIs used
Random country functionality uses [REST Countries Documentation](https://restcountries.com/#api-endpoints-v3-all)
No API key needed

Recipes provided by [Edamam Recipe API Documentation](https://developer.edamam.com/edamam-docs-recipe-api)
Get your key [here](https://developer.edamam.com/edamam-recipe-api)

Videos provided by YouTube via [Google's Youtube API](https://developers.google.com/youtube/v3/getting-started)
Instructions for getting an API key are listed in the above link

Images provided by [Pexel's Image API](https://www.pexels.com/api/)
Get your key [here](https://www.pexels.com/api/register/)

![Edamam Logo](https://i.ibb.co/0fRzNsv/white.png)
