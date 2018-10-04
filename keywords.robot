*** Settings ***
Library                 Selenium2Library

*** Variables ***
${REDMINE}                http://localhost
${BROWSER}                chrome
${VALID USERNAME}         user
${VALID PASSWORD}         bitnami1
${INVALID USERNAME}       notvalid@notvalid.fi
${INVALID PASSWORD}       notvalid
${USER_PAGE}              http://localhost/users
${NEW_USER_PAGE}          http://localhost/users/new
${NEW_GROUP_PAGE}         http://localhost/groups/new

${GROUPS_PAGE}            http://localhost/groups
${PLUGIN_PAGE}            http://localhost/admin/plugins
${PASSWORDRESTORE_PAGE}   http://localhost/account/lost_password

${TEST_USER_LOGIN}        Johnny
${TEST_USER_FIRST_NAME}   John
${TEST_USER_LAST_NAME}    Doe
${TEST_USER_FULL_NAME}    John Doe
${TEST_USER_EMAIL}        john.doe@example.com
${TEST_USER_PASSWORD}     123password
${TEST_GROUP}             Ticket reporters

${USER_PAGE_LOGIN}        Login
${USER_PAGE_FIRST_NAME}   First name
${USER_PAGE_LAST_NAME}    Last name
${USER_PAGE_EMAIL}        Email
${USER_PAGE_ADMINISTRATOR}  Administrator
${USER_PAGE_CREATED}      Created
${USER_PAGE_LAST_CONNECTION}    Last connection

*** Keywords ***


### Keywords used in setup and teardown ###

Go to Redmine
    ${chrome_options} =  Evaluate             sys.modules['selenium.webdriver'].ChromeOptions()   sys, selenium.webdriver
    Call Method          ${chrome_options}    add_argument    headless
    Call Method          ${chrome_options}    add_argument    disable-gpu
    Create Webdriver     Chrome               chrome_options=${chrome_options}
    Set Window Size      1500                 1500
    Go To                ${REDMINE}

Close Application
    Close Browser

Login
    Go to   ${REDMINE}
    Click Element     class=login
    Input text      name=username         ${VALID USERNAME}
    Input text      name=password      ${VALID PASSWORD}
    Click button   id=login-submit

Create User
    user is at user page
    user clicks New user button
    user is redirected to New user page
    user fills in new user creation form with login "Johnny"
    user fills in new user creation form with first name "John"
    user fills in new user creation form with last name "Doe"
    user fills in new user creation form with mail "john.doe@example.com"
    user fills in new user creation form with password "123password"
    user confirms in new user creation form password "123password"
    user clicks create button

Delete User
    user is at user page
    user clicks user "Johnny" link
    user clicks delete button
    user confirms the alert

Create Group
    user is at user page
    user clicks groups link
    user is redirected to Groups page
    user clicks New group link
    user is redirected to New group page
    user types in new group name "Ticket reporters"
    user clicks create button

Add User To Group
    user is at user page
    user clicks groups link
    user is redirected to Groups page
    user selects group "Ticket reporters"
    user selects Users tab
    user clicks New user button
    a modal window opens
    user types in user "John Doe"
    user selects checkbox with user name "John Doe"
    user clicks modal Add button

Delete Group
    user is at user page
    user clicks groups link
    user is redirected to Groups page
    user clicks the delete link for the group "Ticket reporters"
    user confirms the alert

Delete User And Delete Group And Close Browser
    Delete User
    Delete Group
    Close Browser

Delete User And Close Browser
    Delete User
    Close Browser

Delete Group And Close Browser
    Delete Group
    Close Browser




### Starting locations ###

user is at Redmine
    Go to   ${REDMINE}
    Wait Until Page Contains    Redmine

user is at the password restore page
    Go to   ${PASSWORDRESTORE_PAGE}
    Wait Until Page Contains    Lost password

user is at user page
    Go to  ${USER_PAGE}
    Wait Until Page Contains     New user


### Interactions with buttons ###

user clicks submit button
    Click Button   name=commit

user clicks login button
    Click button    id=login-submit
#    Click button   name=login

user clicks New user button
    Click Element  class=icon-add

user clicks create button
    Click button   name=commit

user clicks modal Add button
    Click Button    xpath://div[@id="ajax-modal"]//input[@type="submit"]

user clicks delete button
    Click Element    class=icon-del



### Checkboxes ###

user selects checkbox with user name "${USER_NAME}"
    Select Checkbox   xpath://div[@id="ajax-modal"]//div[@id="users"]//label[contains(text(), "${USER_NAME}")]//input[@type="checkbox"]



### Clicking links ###

user clicks Redmine Sign in link
    Click Element     class=login

user clicks forgot password link
    Click link      xpath=(//a)[2]

user clicks Redmine administration link
    Wait Until Page Contains     Administration
    Click Element    class=administration

user clicks plugins link
    Wait Until Page Contains    Plugins
    Click Element    class=plugins

user clicks users link
    Wait Until Page Contains    Users
    Click Element    class=users
    Wait Until Page Contains     New user

user clicks groups link
    Wait Until Page Contains    Groups
    Click Element    class=groups
    Wait Until Page Contains     New group

user clicks New group link
    Click Element   css:a.icon-add

user selects group "${group}"
    Click Link    xpath://a[contains(text(), '${group}')]

user selects Users tab
    Click link    xpath://a[@id="tab-users"]

user deletes user "${user}" in table
    Click link    xpath:(//table//tr[ * = '${user}']//td[@class="buttons"]/a[contains(text(), "Delete")])

user clicks user "${username}" link
    Click Element        xpath://a[text()='${username}']

user clicks the delete link for the group "${GROUP_NAME}"
    Click Element   xpath://table//tr[*='${GROUP_NAME}']//a[contains(text(), "Delete")]




### Redirections ###

user is redirected to authentication
    Wait Until Page Contains    Login

user is directed into password restore page
    Go to   ${PASSWORDRESTORE_PAGE}
    Wait Until Page Contains    Lost password

user is redirected to Redmine as a logged in user
    Wait Until Page Contains     Logged in as

user is redirected to Plugin page
    Wait Until Page Contains    Plugins
    Location Should Be  ${PLUGIN_PAGE}

user is redirected to New user page
    Wait Until Page Contains    New user
    Location Should Be  ${NEW_USER_PAGE}

user is redirected to Groups page
    Wait Until Page Contains    Groups
    Location Should Be  ${GROUPS_PAGE}

user should be redirected to Groups page
    Wait Until Page Contains    Groups
    Location Should Be  ${GROUPS_PAGE}

user is redirected to New group page
    Wait Until Page Contains    New group
    Location Should Be  ${NEW_GROUP_PAGE}


### Text inputs ###

user fills in email field with "${EMAIL}"
    Input text      name=mail       ${EMAIL}

user fills in valid username and valid password
    Input text      name=username      ${VALID USERNAME}
    Input text      name=password      ${VALID PASSWORD}

user fills in new user creation form with login "${NEW_USER_LOGIN}"
    Input text  name=user[login]      ${NEW_USER_LOGIN}

user fills in new user creation form with first name "${NEW_USER_FIRSTNAME}"
    Input text  name=user[firstname]  ${NEW_USER_FIRSTNAME}

user fills in new user creation form with last name "${NEW_USER_LASTNAME}"
    Input text  name=user[lastname]   ${NEW_USER_LASTNAME}

user fills in new user creation form with mail "${NEW_USER_MAIL}"
    Input text  name=user[mail]       ${NEW_USER_MAIL}

user fills in new user creation form with password "${NEW_USER_PASSWORD}"
    Input text  name=user[password]    ${NEW_USER_PASSWORD}

user confirms in new user creation form password "${NEW_USER_PASSWORD}"
    Input text  name=user[password_confirmation]    ${NEW_USER_PASSWORD}

user types in user "${user}"
    Wait Until Page Contains     Search for user:
    Input text   name=user_search   ${user}
    # sleep is required in order for typing to complete before
    # starting actions that come after it
    Sleep   0.5s

user types in new group name "${GROUP_NAME}"
    Input text  id=group_name   ${GROUP_NAME}



### Page contains ###

page contains text that no valid login detail is not found with given address
    Wait Until Page Contains    Unknown user

user is directed to user page
    Wait Until Page Contains  New user

user can see login name "${login_name}"
    Wait Until Page Contains     ${login_name}
    #   error=${login_name} does not exist/nimistä käyttäjää ei ole !

user can see table heading "${table_heading}"
    Wait Until Page Contains     ${table_heading}    error=${table_heading} does not exist/nimistä käyttäjää ei ole !

user can see new user "${NEW_USER_LOGIN}" is created
    Wait Until Page Contains   User ${NEW_USER_LOGIN} created.

# TODO
group table contains user "${user}"
    Page Should Contain   ${user}
# above is actually wrong, because does not check the table, why below no work ???
#    Page Should Contain Element  xpath://table//tr[ * ="${user}"]     error=${user} does not exist/nimistä käyttäjää ei ole !

group member page should not contain user "${user}"
    Wait Until Page Does Not Contain   ${user}

users page should not contain "${user}"
    Location Should Be  ${USER_PAGE}
    Wait Until Page Does Not Contain   ${user}

page should contain group with name "${GROUP_NAME}"
    Wait Until Page Contains    ${GROUP_NAME}

page should not contain group with name "${GROUP_NAME}"
    Location Should Be        ${GROUPS_PAGE}
    Page Should Not Contain   ${GROUP_NAME}

a modal window opens
    Page Should Contain Element   xpath://div[@id="ajax-modal"]


### Alerts ###

user confirms the alert
    Confirm Action

### Aggregate actions ###

user creates new user
    user fills in new user creation form with login "${TEST_USER_LOGIN}"
    user fills in new user creation form with first name "${TEST_USER_FIRST_NAME}"
    user fills in new user creation form with last name "${TEST_USER_LAST_NAME}"
    user fills in new user creation form with mail "${TEST_USER_EMAIL}"
    user fills in new user creation form with password "${TEST_USER_PASSWORD}"
    user confirms in new user creation form password "${TEST_USER_PASSWORD}"
    user clicks create button

user can see a new user has been created
    user can see new user "${TEST_USER_LOGIN}" is created

user creates a new group
    user types in new group name "${TEST_GROUP}"
    user clicks create button

page should contain the new group name
    page should contain group with name "${TEST_GROUP}"

user can see a valid user page
    user can see login name "user"
    user can see table heading "Login"
    user can see table heading "${USER_PAGE_FIRST_NAME}"
    user can see table heading "${USER_PAGE_LAST_NAME}"
    user can see table heading "${USER_PAGE_EMAIL}"
    user can see table heading "${USER_PAGE_ADMINISTRATOR}"
    user can see table heading "${USER_PAGE_CREATED}"
    user can see table heading "${USER_PAGE_LAST_CONNECTION}"

user adds a new user to the group
    user selects group "${TEST_GROUP}"
    user selects Users tab
    user clicks New user button
    a modal window opens
    user types in user "${TEST_USER_FULL_NAME}"
    user selects checkbox with user name "${TEST_USER_FULL_NAME}"
    user clicks modal Add button

group table contains the new user
    group table contains user "${TEST_USER_FULL_NAME}"

user deletes a user from the group
    user selects group "${TEST_GROUP}"
    user selects Users tab
    user deletes user "${TEST_USER_FULL_NAME}" in table
    user confirms the alert

the group member page should not contain the user
    group member page should not contain user "${TEST_USER_FULL_NAME}"

user deletes a user from the users page
    user clicks users link
    user clicks delete button
    user confirms the alert

users page should not contain the user
    users page should not contain "${TEST_USER_LOGIN}"

user deletes a group from the Groups page
    user clicks the delete link for the group "${TEST_GROUP}"
    user confirms the alert

the Groups page should not contain the group
    page should not contain group with name "${TEST_GROUP}"
