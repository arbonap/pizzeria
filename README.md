# [![CircleCI](https://circleci.com/gh/arbonap/pizzeria.svg?style=svg)](https://circleci.com/gh/arbonap/pizzeria) Pizzeria 🍕
## Deployed on Heroku: https://secret-harbor-55513.herokuapp.com/orders/

## Set up Pizzeria Locally
  - This runs on Postgres! Assuming you are running on OSX, download the Postgres app [here](https://postgresapp.com/).
  - __Note__: Make sure the elephant icon is in your menubar. If do not see the Postgres elephant running in your menubar, then Postgres __isn't running__.
  - Run `bin/setup` in the terminal
  - Spin up the local server with `bundle exec rails s`

## Sending cURL requests in Development Environment
  - Strongly recommend installing a JSON prettifier, like [this one](https://chrome.google.com/webstore/detail/jsonview/chklaanhfefbnpoihckbnefhakgolnmc?hl=en)
  - Visit `http://localhost:3000/orders` to see JSON of all Orders
  -  cURL request for the index/list of all Orders:
    - `curl -g -H "Content-Type:application/json" -X GET http://localhost:3000/orders`

  - cURL request to create a new user:
    - `curl -g -H "Content-Type:application/json" -X POST --data '{"user": {"email": "me@gmail.com","password": "password","password_confirmation": "password"}}' http://localhost:3000/users`

  - cURL request to sign-in as newly created user:
     ```
    curl -H 'Content-Type: application/json' \
      -H 'Accept: application/json' \
      -X POST http://localhost:3000/users/login \
      -d '{"user" : { "email" : "me@gmail.com", "password" : "password"}}' \
      -c cookie
      ```
  - cURL request to create new Order:
    - `curl -g -H "Content-Type:application/json" -X POST --data '{"order": {"items": [{"quantity":"17","pizza_type":{"name": "Anchovy", "price": "9"}}]}}' http://localhost:3000/orders -b cookie`

  - cURL request to update Order with an ID of 1:
    - `curl -g -H "Content-Type:application/json" -X PUT --data '{"order": {"items": [{"quantity":"2","pizza_type":{"name": "Pineapple", "price": "13"}}]}}' http://localhost:3000/orders/1 -b cookie`

  - cURL request to show Order with an ID of 1:
    - `curl -g -H "Content-Type:application/json" -X GET http://localhost:3000/orders/1 -b cookie`

  - cURL request to delete Order with an ID of 1:
    - `curl -g -H "Content-Type:application/json" -X DELETE http://localhost:3000/orders/1 -b cookie`

## Running Specs Locally
To run tests:
  - In the root of project folder, run `bundle exec rspec spec` to run all of the rspec tests
  - To just run controller tests, type `bundle exec rspec spec/controllers/`
  - To only run model tests, type `bundle exec rspec spec/models/`

## Skip Local Setup
  - If you don't want to set the repo up locally, replace the `http://localhost:3000` parts of the above cURL requests with `https://secret-harbor-55513.herokuapp.com/orders/`
  - Example:
    - `curl -g -H "Content-Type:application/json" -X GET https://secret-harbor-55513.herokuapp.com/orders`
