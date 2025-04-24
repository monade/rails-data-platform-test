# README

#### Setup

Required ruby version: 3.3.x

```bash
# Install dependencies
bundle install

# Prepare the database
rails db:create db:migrate db:seed

# Start the app
foreman start
```

The app runs on port 3000 by default.

#### Tests

```bash
# Run all tests
bundle exec rspec
```

#### Scenario

A junior developer started working on a BI app for a company. The database schema was
defined,
and the developer was given a task to implement a few features.
The developer spent a few hours working on the app, achieving some progress,
but then was assigned to another project.

Your task is to finish the work left undone and clean up the mess
the junior developer left behind.

- [ ] All tests green
- [ ] All the stubs in data_points/index are implemented
- [ ] Cleanup and refactor models and controllers

Extra mile:

- [ ] Test the frontend features
- [ ] Implement filtering for all reasonable fields and relations