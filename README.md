
# Home Assessment

## Description

RESTful API service that enables a simple scheduling system.

## Prerequisites

Ensure you have installed (globally) the following software on your system:

- Ruby 3.2.2 Install it with rbenv or rvm.

## Development Setup

This guide outline the steps needed to start Home Assessment in a development enviroment.

* Clone your forked repository on your development machine.

```bash
git clone https://github.com/ConstVol/home_assessment.git
```

* Install ruby version defined in .ruby-version.

```bash
rbenv install 3.2.2
```

* Install Home Assessment dependencies.

```bash
home_assessment ~> gem install bundler
home_assessment ~> bundle install
```

* Create Home Assessment database.

```bash
home_assessment ~> bundle exec rake db:create
home_assessment ~> bundle exec rake db:seed_all
```

## Usage

* Start service:

```bash
bundle exec rails s -p 3000
```

* Visit swagger endpoint.

SWAGGER: http://localhost:3000/api-docs


## Testing

* To run the RSpec tests:

```bash
bundle exec rspec
```

