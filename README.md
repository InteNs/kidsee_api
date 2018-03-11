# KidseeApi

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Deployment

## Authentication

In order to authenticate yourself with the server you should do the following:

  * Have an user account with email and password
  * do a POST request to `/api/users/sign-in` with `email` and `password` params
  * if the login was succesful the server returns a `token`
  * all other requests except `POST /api/users/` (registration) needs an header with
  key: `authorization`, value: `Bearer <token>`

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
