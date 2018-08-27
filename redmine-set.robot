*** Settings ***
Resource            keywords.robot
#Suite Setup         Go to Redmine
#Suite Teardown      Close Application
Test Teardown       Close Application
Test Setup          Go to Redmine
Documentation       A test suite for Redmine


*** Test Cases ***
User story: As a user I can get to the password restore page
    [Tags]    ClickForgotPasswordLink
    Given user is at Redmine
    When user clicks Redmine Sign in link
    And user is redirected to authentication
    And user clicks forgot password link
    Then user is directed into password restore page

User story: As an user I cannot restore my forgotten password with unknown e-mail
    [Tags]    RestorePasswordWithUnknownEmail
    Given user is at the password restore page
    When user fills in email field with "abd@abc.fi"
    And user clicks submit button
    Then page contains text that no valid login detail is not found with given address

User story: I can log into Redmine
    [Tags]    LogIntoRedmine
    Given user is at Redmine
    When user clicks Redmine Sign in link
    And user is redirected to authentication
    And user fills in valid username and valid password
    And user clicks login button
    Then user is redirected to Redmine as a logged in user

User story: I can view installed plugins
    [Tags]    ViewInstalledPlugins
    [Setup]   Run Keywords    Go to Redmine
                              Login
    Given user is at Redmine
    When user clicks Redmine administration link
    And user clicks plugins link
    Then user is redirected to Plugin page

User story: I can view the user list
    [Tags]    ViewUserList
    [Setup]   Run Keywords    Go to Redmine
                              Login
    Given user is at Redmine
    When user clicks Redmine administration link
    And user clicks users link
    Then user is directed to user page
    And user can see a valid user page

User story: I can add a new user
   [Tags]    AddUser
   [Setup]   Run Keywords    Go to Redmine
                             Login
   Given user is at user page
   When user clicks New user button
   And user is redirected to New user page
   And user creates new user
   Then user can see a new user has been created
   [Teardown]   Run Keywords  Delete User And Close Browser

User story: I can create a group
   [Tags]    CreateGroup
   [Setup]   Run Keywords    Go to Redmine
                             Login
   Given user is at user page
   When user clicks groups link
   And user is redirected to Groups page
   And user clicks New group link
   And user is redirected to New group page
   And user creates a new group
   Then user should be redirected to Groups page
   And page should contain the new group name
   [Teardown]   Delete Group And Close Browser

User story: I can add a user to a group
   [Tags]    AddUserToGroup
   [Setup]   Run Keywords    Go to Redmine
                             Login
                             Create User
                             Create Group
   Given user is at user page
   When user clicks groups link
   And user is redirected to Groups page
   And user adds a new user to the group
   Then group table contains the new user
   [Teardown]   Delete User And Delete Group And Close Browser

User story: I can remove a user from a group
   [Tags]    RemoveUserFromGroup
   [Setup]   Run Keywords    Go to Redmine
                             Login
                             Create User
                             Create Group
                             Add User To Group
   Given user is at user page
   When user clicks groups link
   And user is redirected to Groups page
   And user deletes a user from the group
   Then the group member page should not contain the user
   [Teardown]   Delete User And Delete Group And Close Browser

User story: I can delete a user
   [Tags]    DeleteUser
   [Setup]   Run Keywords    Go to Redmine
                             Login
                             Create User
   Given user is at user page
   When user deletes a user from the users page
   Then users page should not contain the user

User story: I can delete a group
   [Tags]    DeleteGroup
   [Setup]   Run Keywords     Go to Redmine
                              Login
                              Create Group
   Given user is at user page
   When user clicks groups link
   And user is redirected to Groups page
   And user deletes a group from the Groups page
   Then the Groups page should not contain the group
