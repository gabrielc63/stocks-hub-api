# The Stocks Hub API

### Setup

```
bundle install
rails server
```

### Tests

```
bundle exec rspec
```

### Endpoints

| URL / ENDPOINT | VERB   | DESCRIPTION      |
| -------------- | ------ | ---------------- |
| /auth/login    | POST   | Generate token   |
| /users         | POST   | Create user      |
| /users         | GET    | Return all users |
| /users/{id}    | GET    | Return user      |
| /users/{id}    | PUT    | Update user      |
| /users/{id}    | DELETE | Destroy user     |
