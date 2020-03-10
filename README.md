# Ticketer

## Installation

```
gem install bundler
bundle install
```

## Background Jobs

This App uses `sidekiq` for background jobs, so you'll need redis in order for this to work.

```
brew install redis
```

## Database

This App requires Postgres. Once that's installed:

```
bundle exec rake db:create
bundle exec rake db:migrate
```

And to populate the database with 5 tickets

```
bundle exec rake db:seed
```

## Local domain

This App uses puma-dev to support a local domain. Once puma is installed, symlink the directory.

```
puma-dev link -n ticketer
```

## Running

```
foreman start
```

Visit [ticketer.test](https://ticketer.test).

## Testing

```
bundle exec rspec
```

## Edgecases

- If an error happens during the Worker cleanup task, or if the webhook fails, then the ticket will have a corresponding Stripe charge but the ticket will get reallocated to available.
- There is a race condition, that if someone doesn't checkout until the 5 minutes are nearly up, then the cleanup worker could make the ticket available again while they are checking out through stripe.
