# KidseeApi

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## API endpoints

In order to succsfully call endpoints you need the following:

  * header with key: `content-type`,  value: `application/vnd.api+json`
  * header with key: `authorization`, value: `Bearer <token>`

### current endpoints:

  * most endpoints expect [json_api document structure](http://jsonapi.org/format/#document-structure)
  * current hostname for the server is: `174.138.7.193`

  ```
  POST    /api/users
  POST    /api/users/sign-in
  GET     /api/users
  GET     /api/users/:id
  PATCH   /api/users/:id
  PUT     /api/users/:id
  DELETE  /api/users/:id
  ```

## Deployment

## Authentication

In order to authenticate yourself with the server you should do the following:

  * Register a new user `POST /users` including a bcrypt hashed password
  * do a POST request to `/api/users/sign-in` with `email` and `password` params
  * if the login was succesful the server returns your `token`

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
