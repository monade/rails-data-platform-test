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

A junior developer started working on a BI app for a company.
The app will be used to visualize data from a PostgreSQL database,
data raging in the order of millions of rows.

The data team defined the database schema to satisfy
as best as possible the required data representation requirements.

The developer spent a few hours working on the app, achieving some progress,
but then was assigned to another project.

Your task is to finish the work left undone and clean up the mess
the junior developer left behind.

Main goals:

- [ ] All tests green
    - Starting from `models/data_point_spec.rb`
- [ ] The stubs in data_points/index are implemented

Side quests:

- [ ] Test the frontend with RSpec
- [ ] Implement filtering for all reasonable fields and relations
- [ ] Prepare the app for deployment in AWS ECS