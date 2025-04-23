# README

#### Setup

Required ruby version: 3.3.x

```bash
# Install dependencies
bundle install

# Prepare the database
rails db:create db:migrate db:seed

# Start the server
rails s

# If needed start tailwindcss
rails tailwindcss:watch
```

The app runs on port 3000 by default.

#### Tests

```bash
# Run all tests
bundle exec rspec
```

#### Goals

- [ ] All tests pass
- [ ] All the stubs in data_points/index are implemented
- [ ] Cleanup and refactor models and controllers