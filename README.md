# TodoApp

## Design decisions

There are a handful of decisions I made, detailed below:

  * Managers can assign underlings, but underlings cannot choose
    managers.
  * A user can assign themselves as their underling, and can
    then create tasks for themselves.
  * A user can view all of their managers, and their underlings.

Under-the hood design decisions are below:

  * There is an 'authenticated' part of the site, which has its
    own pipeline in the router. If a non-authenticated user tries
    to access any of those routes, they're redirected to the
    login page with a warning message.
  * Anybody can sign up, but an email can only be used once.

## Starting the app

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
