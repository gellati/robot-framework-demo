# Robot Framework demo

## Introduction

This setup demonstrates [Robot Framework](http://robotframework.org) tests run against a [Redmine](http://www.redmine.org) application running in a [Docker](https://www.docker.com) container.

## Setup

Initial requirements for this to work are Docker and Robot Framework installed on the computer.

The file `docker-compose.yml` contains a Dockerized container for Redmine. The dockerfile builds up a small microservice architecture consisting of two services, Redmine and a MariaDB database. Build and start the containers with

    docker-compose up

Once the containers are up and running, the Redmine service can be tested with Robot Framework.

Shut down the containers with

    docker-compose down



## Tests

The tests are based on user stories. Each user story has been divided into steps that are required for that story to be realized.

The tests can be run all at once, or one at a time. The tests have been marked with tags for the user to be able to run them individually.

The file `redmine-set.robot` contains the user stories. Some of the more involved user stories contain `setup` and `teardown` sections with which preconditions are set up prior to the tests and the environment is cleaned up after the test has run.

The `keywords.robot` file contains keywords which make up the test steps. The keywords have been grouped according to the kinds of activities they do (e.g. click buttons, move to urls). The aggregate actions section contains slightly abstracted keywords. If a keyword contains variables that are passed on to other keywords, the variable has to be enclosed in quotations (i.e. "").


## Running tests

After the application is up and running, tests can be run against it.

Run the Robot Framework tests with

    robot redmine-set.robot

The tests have been marked with tags, and each individual test can be run with

    robot -i [tag] redmine-set.robot

Repeat the `-i [tag]` for each additional test to be run in the set.

The script `run.sh` also contains the needed commands to run the tests. Just run it with

    ./run.sh

Make sure that the script is executable, i.e. `chmod +x run.sh`.
