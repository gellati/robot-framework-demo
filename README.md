# Robot Framework demo

## Introduction

This setup demonstrates [Robot Framework](http://robotframework.org) tests run against a [Redmine](http://www.redmine.org) application running in a [Docker](https://www.docker.com) container.

## Setup

Initial requirements for this to work are Docker and Robot Framework installed on the computer. Robot Framework can be installed from the `requirements.txt` file with

    pip install -r requirements.txt

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

The test framework has been configured to run in headless mode according to [these instructions](https://spage.fi/headless-selenium-rf).

In the file `keywords.robot`, these lines make Robot Framework run Chrome in headless mode:

    Go to Redmine
        ${chrome_options} =  Evaluate             sys.modules['selenium.webdriver'].ChromeOptions()   sys, selenium.webdriver
        Call Method          ${chrome_options}    add_argument    headless
        Call Method          ${chrome_options}    add_argument    disable-gpu
        Create Webdriver     Chrome               chrome_options=${chrome_options}
        Set Window Size      1500                 1500
        Go To                ${REDMINE}

Similar options for running headless Chromium and Firefox also exist in commented form in the `keywords.robot` file.

To run the test in normal mode, replace the lines above with the following:

    Go to Redmine
        Open Browser       ${REDMINE}           ${BROWSER}


## Running in headless mode from container

The tests can be run from a Docker container. Once the Redmine service is running with `docker-compose up`, a container containing the Robot Framework tests can be created with

    docker build -f robotubuntu.dev -t robot .

This creates a container based on Ubuntu. After being built the container will immediately be shut down because there is no process running inside the container. Therefore, in order to keep the container running, the following can be executed:

    docker run <container name or id> /bin/sleep 1000

This will keep the container running for 1000 seconds.

Names of the container images can be found with

    docker images

Check if container is running with

    docker ps

The container contains the script `run.sh` which can be run with the following:

    docker exec -it <container name> ./run.sh

This will run the tests inside the container, without any need to install the required programs on our own machine.

The container can be logged into with

    docker exec -it <container name> /bin/bash

## Environment variables

It might be necessary to set the DISPLAY environment variable:

    export DISPLAY=localhost:0.0


## Shell

Make sure you are using the bash shell and not sh. Check the system shell with

    echo $0

If the result is `bash`, you are ok. Otherwise please change to bash. Ubuntu usually has a `bash` shell, but other more minimal distributions (e.g. alpine)  might be using something else.

## MacOS

To run tests on a local Mac, the path to the driver binaries should be set to a local user bin path, e.g.

    ln -s /path/to/geckodriver  /Users/username/bin/geckodriver

In Robot Framework's keyword file, the binary location can be set as

    ${firefox_options.binary_location}     Set Variable     /Applications/Firefox.app/Contents/MacOS/firefox-bin


## Drivers

Chrome/Chromium drivers from [here](http://chromedriver.chromium.org) and Firefox drivers from [here](https://github.com/mozilla/geckodriver/releases). The drivers have to be set in `drivers` folder. Ensure that the drivers correspond to the operating system used, and that they have been added to the executable path. They can be added to the system PATH with symbolic links:

    ln -s /path/to/binary /usr/bin/binaryname
