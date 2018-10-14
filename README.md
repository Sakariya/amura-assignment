# Amura Assignment

* This is a rails application that connects with users github account (via [`oauth`](https://github.com/omniauth/omniauth)) and then shows some data about his repositories and once user select a specific repository it will shows selected repository **Name and  Description** also visual commit history via [`D3 graph library`](https://d3js.org/) and allow to select date range to define the duration of the commits that the user is interested in.


## Running locally

First, you'll need a [Register a new OAuth application](https://github.com/settings/applications/new) to generate **Client ID** and **Client Secret**. This should be set as a [`CLIENTID`] and [`CLIENTSECRET`] environment variable as configured in **.env** file at root folder of application.

``` sh
$ git clone https://github.com/poojajk/amura-assignment.git
$ cd githubamura-assignment/
$ bundle install
$ mv .env.example .env
$ rails db:create db:migrate
$ rails s 
```

And visit [http://localhost:3000/](http://localhost:3000/).
 
## Running test cases

For run the test cases follows following command and make sure test cases should be passed.

``` sh
$ bundle exec rspec spec
```

## Structure of this repo
There are a number of branches that reflect progress through the problem:

* `master` - A github default branch and all branches merged into it using [#PR].
* `github-login` - That have a functioning authentication and authorization system, move to GitHub auth through omniauth.
* `github-details` - Fetch list of available repositories of logged in user using [`github_api`](https://github.com/piotrmurach/github) gem.
* `d3-graph` - Called API for get selected repository details and commits history and shows D3 line chart for shown commits history.
* `test-cases` - This branch have Rspec test case for the controller.


## See Also

* [Github's API homepage](https://developer.github.com/v3/)
