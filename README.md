# GitHub-Pocket-Explorer

Swift-UI example application showing popular repositories from GitHub sort by stars. In this app a user can also search the repositories, it contains a searchbar at the top. 

Paging is also implemented, when scrolling to the bottom, next entries for list are loaded. This also work when keyboard is shown up.

The goal was to get an idea how SwiftUI can work in a "somehow real world project" in a bigger context and with some kind of "real life questions". My resume is, SwifUI is a new great opportunity to develop apps but it takes some time to learn it and to understand it. One beautiful aspect is, it is simple to make an application looking good on a normal appearence and also when dark appearence is active. And also simple to make it look great on an ipad.

To create a network throttler I read this great article here: https://www.craftappco.com/blog/2018/5/30/simple-throttling-in-swift

Also great 'normal swift code' (which is not SwiftUI or Combine) can be (re-)used and integrate.

![](git-trending.gif)

## Features of the app:
- List Swift Repos
- Browse GitHub without running in Github API rate limits
- Repo Detail page, displaying a few information about the repo, the forks and also possiblity to open the detail page as webpage in an inapp-webview
- Possiblity to connect Github account to increase the number of available Github API requests
- Handling and persisting of the auth token
- Listener to also check if user revokes the access for our application during app is in the background
- Sharing a link to a repository discovered
- Works on iPhone and iPad
- Error handling, display errors to the user
- Pagination, possible to load max 5 pages of GitHub repos for the search of forks for a repo
- Display loading
- Customize navigation bar items

## Open TODOs:
- extend unit test suite for the project
- finish appstore upload

## License 

This project is published under the Apache 2.0 license
