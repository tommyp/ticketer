# Ticketer

## Installation

```
gem install bundler
bundle install
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
