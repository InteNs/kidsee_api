# KidseeApi

## Database
Production database credentials
* host: `174.138.7.193`
* db: `kidsee_api_prod`
* username: `postgres`
* password: `postgres`

Staging database credentials (yes only the host differs!)
* host: `128.199.32.227`
* db: `kidsee_api_prod`
* username: `postgres`
* password: `postgres`

## API endpoints

In order to succsfully call endpoints you need the following:

  * header with key: `content-type`,  value: `application/vnd.api+json`
  * header with key: `authorization`, value: `Bearer <token>`

### current endpoints:

  * visit our documentation at `http://174.138.7.193/api/swagger`
  * most endpoints expect [json_api document structure](http://jsonapi.org/format/#document-structure)
  * current hostname for the server is: `174.138.7.193`

### user avatar upload/download

  * do a normal `PATCH` request to `/api/users/:id`
  * make sure the request body contains `data[attributes][avatar] = <file>`
  * the avatar will be a url like `/uploads/test_pic.png?v=63692587436`
  * you can make a `GET` request to this url to retrieve the image

## Deployment
  * on master run `mix edeliver upgrade production`

## Authentication

In order to authenticate yourself with the server you should do the following:

  * Register a new user `POST /users` including a bcrypt hashed password
  * do a POST request to `/api/tokens` with `email` or `username` and `password` params
  * if the login was succesful the server returns your `token`

## Development

  * Install Elixir 1.6 and Erlang 20.2
  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.


## Troubleshooting
 ```
 tail -f ~/app_release/kidsee_api/var/log/erlang.log.4
  ```

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
