# Elevate Kata 
Coding Kata for Elevate Labs

---
### Requirements

Located at the Root of the project

---


# Install

## Dependencies

- [direnv](https://direnv.net/docs/installation.html)
- Docker

# Usage

## Environment Variables

| name | usage |
| ---- | ----- |
| POSTGRES_HOST | Hostname for the postgres instance. |
| POSTGRES_USER | User to login to postgres. |
| POSTGRES_PASSWORD | Password to login to postgres. |
| PRIMARY_EMAIL | Email address used to login to the rails app in development. |
| PRIMARY_PASSWORD | Password used to login to the rails app in development. |
| RAILS_MAX_THREADS | How many threads to run in the app and sidekiq. |
| REDIS_URL | Url used to connect to redis. |
| SUPER_SECRET | JWT encode/decode secret |

## Getting Started

Create and modify the `.envrc.secrets` to have values for the secret vars documented in `.envrc`.

Run `direnv allow` to populate your environment with the env vars configured in `.envrc` and `.envrc.secrets`.

Run postgres and redis in the background:

```sh
docker-compose up -d postgres redis
```

Build the local docker image:

```sh
docker-compose build
```

Cache the ruby gems:

```sh
docker-compose run --rm app bundle install
```

Setup the database:

```sh
docker-compose run --rm app rails db:create db:migrate
```

Seed the database:

```sh
docker-compose run --rm app rails db:seed
```

Start the rails app:

```sh
docker-compose up app
```

Start sidekiq for background jobs:

```sh
docker-compose up sidekiq
```

Start webpack for the frontend:

```sh
docker-compose up webpack
```

Run the Test Suite
```sh
docker-compose run --rm app rake test
```

### Testing

Postman Collection: 

https://www.getpostman.com/collections/455da189904037becc4a

You have to create a user, then add the token returned into headers.

### Reflection on choices
I utilized a docker file from a personal project to cut down on time so that is why there are a few extra moving pieces. I chose to use JWT for my authorization across my API, and just Bcrypt for password encryption into the postgres database for the users. I added the end points required.

I started out by writing out tables and relationships in my notebook as well as a creating a Postman collection with requests that matched the documentation.
Then I generated my migrations and populated my database.

Things I could improve on:

Better validations
Take a closer look at the Rubocop, however some of the errors seemed non applicable or unnecessary or against files that didn't need changed. 
I should have and normally do use smaller incremental commits.
