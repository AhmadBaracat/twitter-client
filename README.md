# twitter-client
## Installation
run `pod install`

##Design decisions and libraries used
- **Alamofire** for making and caching network requests
- **AlamofireImage** for lazy image loading
- **Core Data** to save profile and banner images to disk
- **Argo** to map JSON objects to Swift objects

-
- I have decided to fallback to cached requests only if the user is offline to make sure we have up to date data.
- I am loading the whole followers list which will cause problems like hitting the API limit if the user has large number of followers.
- This shouldn't be a problem from the user's persepctive (network usage) because I am only fetching and caching the JSON response and only requesting the images as needed.

##Todo
###Development
- Change design pattern from MVC to MVVM (reactive)
- Handle the scenario where the user launches the app for the first time and there is no Internet connection
- Handle the scenario where the Internet connection changes state from not connected to connected --> reinitiate the network requests
- When the app hits the API limit, fallback to cached requests
- Display loading indicator when waiting for server response in followers and user screens
- Implement infinite scrolling not to hit the API limit
- Refactor the network requests and parsing functions
- Display not connected alert

###Design
- Add visual indicator that the user is offline
- Change login screen layout
- Add corner radius to images
- Create app icon for Twitter and Xcode
- Change general app description on Twitter
