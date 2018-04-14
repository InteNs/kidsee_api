# KidseeApi

## API endpoints

In order to succsfully call endpoints you need the following:

  * header with key: `content-type`,  value: `application/vnd.api+json`
  * header with key: `authorization`, value: `Bearer <token>`

### current endpoints:

  * most endpoints expect [json_api document structure](http://jsonapi.org/format/#document-structure)
  * current hostname for the server is: `174.138.7.193`

  ```
        user_path  POST    /api/users              KidseeApiWeb.UserController :create
       token_path  POST    /api/tokens             KidseeApiWeb.TokenController :create
    location_path  GET     /api/locations          KidseeApiWeb.LocationController :index
    location_path  GET     /api/locations/:id      KidseeApiWeb.LocationController :show
    location_path  POST    /api/locations          KidseeApiWeb.LocationController :create
    location_path  PATCH   /api/locations/:id      KidseeApiWeb.LocationController :update
                   PUT     /api/locations/:id      KidseeApiWeb.LocationController :update
    location_path  DELETE  /api/locations/:id      KidseeApiWeb.LocationController :delete
      status_path  GET     /api/statuses           KidseeApiWeb.StatusController :index
      status_path  GET     /api/statuses/:id       KidseeApiWeb.StatusController :show
      status_path  POST    /api/statuses           KidseeApiWeb.StatusController :create
      status_path  PATCH   /api/statuses/:id       KidseeApiWeb.StatusController :update
                   PUT     /api/statuses/:id       KidseeApiWeb.StatusController :update
      status_path  DELETE  /api/statuses/:id       KidseeApiWeb.StatusController :delete
content_type_path  GET     /api/content-types      KidseeApiWeb.ContentTypeController :index
content_type_path  GET     /api/content-types/:id  KidseeApiWeb.ContentTypeController :show
content_type_path  POST    /api/content-types      KidseeApiWeb.ContentTypeController :create
content_type_path  PATCH   /api/content-types/:id  KidseeApiWeb.ContentTypeController :update
                   PUT     /api/content-types/:id  KidseeApiWeb.ContentTypeController :update
content_type_path  DELETE  /api/content-types/:id  KidseeApiWeb.ContentTypeController :delete
        post_path  GET     /api/posts              KidseeApiWeb.PostController :index
        post_path  GET     /api/posts/:id          KidseeApiWeb.PostController :show
        post_path  POST    /api/posts              KidseeApiWeb.PostController :create
        post_path  PATCH   /api/posts/:id          KidseeApiWeb.PostController :update
                   PUT     /api/posts/:id          KidseeApiWeb.PostController :update
        post_path  DELETE  /api/posts/:id          KidseeApiWeb.PostController :delete
     comment_path  GET     /api/comments           KidseeApiWeb.CommentController :index
     comment_path  GET     /api/comments/:id       KidseeApiWeb.CommentController :show
     comment_path  POST    /api/comments           KidseeApiWeb.CommentController :create
     comment_path  PATCH   /api/comments/:id       KidseeApiWeb.CommentController :update
                   PUT     /api/comments/:id       KidseeApiWeb.CommentController :update
     comment_path  DELETE  /api/comments/:id       KidseeApiWeb.CommentController :delete
        user_path  GET     /api/users              KidseeApiWeb.UserController :index
        user_path  GET     /api/users/:id          KidseeApiWeb.UserController :show
        user_path  PATCH   /api/users/:id          KidseeApiWeb.UserController :update
                   PUT     /api/users/:id          KidseeApiWeb.UserController :update
        user_path  DELETE  /api/users/:id          KidseeApiWeb.UserController :delete
  ```

## Deployment
  * on master run `mix edeliver upgrade production`

## Authentication

In order to authenticate yourself with the server you should do the following:

  * Register a new user `POST /users` including a bcrypt hashed password
  * do a POST request to `/api/tokens` with `email` or `username` and `password` params
  * if the login was succesful the server returns your `token`
  
## Development

  * Install Elixir 1.6 and Erlang 20.2
  * clone the project
  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.


## Troubleshooting
 ```sh
 tail -f ~/app_release/kidsee_api/var/log/erlang.log.4
  ```

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
