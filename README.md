# Geocoder challenge

[![CircleCI](https://circleci.com/gh/knlynda/geocoder-challenge.svg?style=svg)](https://circleci.com/gh/knlynda/geocoder-challenge)

### Install dependencies

```bash
gem install bundler
bundle install
```

### Setup credentials

#### Generate credentials
```bash
EDITOR="nano" bundle exec rails credentials:edit
```

#### Update it with your `secret_key_base` and `google_geocoder_api_key`
```yaml
secret_key_base: your_secret_key_base
google_geocoder_api_key: your_google_geocoder_api_key
```

### Setup database

```bash
bundle exec rake db:create db:migrate db:seed
```

### Run server

```bash
bundle exec rails s
```

### Usage examples

#### Authenticate user

```bash
curl -H "Content-Type: application/json" -X POST -d '{"email":"user@test.xx","password":"test1234"}' http://localhost:3000/api/v1/authenticate
```

```json
{"auth_token":"eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1Mzg3NzczODR9.d4Fl0gQ587b1GFaUGh3eoxCWbdDW5Btkq9ABojV509U"}
```

#### Use geocoder

```bash
curl -H "Authorization: eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1Mzg3NzczODR9.d4Fl0gQ587b1GFaUGh3eoxCWbdDW5Btkq9ABojV509U" http://localhost:3000/api/v1/geocode\?address\=checkpoint+charlie
```

```json
{"lat":52.5074434,"lng":13.3903913}
```

### Testing

#### Run rubocop

```bash
bundle exec rubocop
```

#### Run tests

```bash
bundle exec rspec
```
