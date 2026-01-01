# GitHub-Pocket-Explorer

 This is aSwift-UI example application showing popular repositories from GitHub sort by stars. In this app a user can also search the repositories, it contains a searchbar at the top. 

Paging is also implemented, when scrolling to the bottom, next entries for list are loaded. This also work when keyboard is shown up. 

Here a small visual overview of the application:

![](App-Screencast.gif)

When this project was initiated in 2019, the goal was to explore how SwiftUI could be applied in a larger, "real-world" project, addressing some practical, real-life challenges. 

Since then, SwiftUI has evolved significantly and has become an industry standard. Today, it represents one of the most powerful and effective approaches for defining user interface code.

Fe. debouncing no longer requires a custom implementation like described [in this Medium article](https://medium.com/@soxjke/property-wrappers-in-swift-5-1-297ae08fc7a0). SwiftUI and Combine provide this functionality out of the box by observing the published query property, filtering out unchanged values, and delaying execution until the user has stopped typing for a short period. This ensures that the action is triggered only once per meaningful input change, significantly reducing unnecessary work such as repeated API calls. 

> [!IMPORTANT]
> To enable GitHub login, a GitHub OAuth App must be created as described in the GitHub documentation [Creating an OAuth app](https://docs.github.com/en/apps/oauth-apps/building-oauth-apps/creating-an-oauth-app). Create a `Secrets.xcconfig` file in the root folder of the project and define the values `CLIENT_ID_GIT_EXPLORER_APP` and `CLIENT_SECRET_GIT_EXPLORER_APP` corresponding to the OAuth app credentials. Details on integrating configuration files can be found in the official Apple docs [Adding a build configuration file to your project](https://developer.apple.com/documentation/xcode/adding-a-build-configuration-file-to-your-project).
> ⚠️ This approach is a pragmatic compromise. `xcconfig` files are intended for environment-specific build settings, not for securely storing secrets. While this is acceptable for local development or non-production builds, it must not be used in production. In production mode, client secrets should never be embedded in the app. They should be ideally provided by a backend API and returned only for authenticated clients.

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

## License 

This project is published under the Apache 2.0 license
