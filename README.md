# Scalable Demo github Repo


![Platform](https://img.shields.io/badge/Platform-iOS-orange.svg)
![Languages](https://img.shields.io/badge/Language-Swift-orange.svg)


## Installation
- Need Xcode 12+ & iOS 12+.
- open ScalableDemo.xcodeproj
- Select the iphone simulator or connect device of your choice & run it. 
- Minimum iOS 12.

# Problem Statement

## Task 1 - Connect to the Github API

Connected to the Github API to retrieve the list of public repositories in this specific Github Account. using this account: https://api.github.com/users/mralexgray/repos.

I decided to use TableView to display due to simple data and list of repos, we don't need any grid or complex UI types. So, that's why I choose tableview.

## Task 2 - Asynchronously load the last commit
Initial label text is set to "Loading..."
Used DispatchGroup from GCD for Asynchronously doing API calls. So, that the list is scrollable when data is loading. 

## Task 3 - Build some custom UI

Made a custom UITableViewCell programmatically for TableView, custom views, Layers (corner radius, shadow path etc).

   
# Pattern

## Design Pattern: Model-View-ViewModel (MVVM-C)
is a structural design pattern that separates objects into three distinct groups:
- #### Models 
- hold application data. They’re usually structs or simple classes.
- #### Views 
- display visual elements and controls on the screen. They’re typically subclasses of UIView.
- #### View models
- transform model information into values that can be displayed on a view. They’re usually classes, so they can be passed around as references.
- #### Coordinator
-  Instantiate ViewController’s & ViewModel’s
- Instantiate & Inject dependencies into the ViewController’s and ViewModel’s
- Present or push ViewController’s onto the screen

## Requirements
- Make the simplest chat form between two users.
- We are asking for the simplest solution for receiving, sending, and listening to voice notes between two users.
- Use iOS SDK SendBird for the chat functionality - https://sendbird.com/


## Approach

-  I decided to go with a MVVM with coordinator architecture pattern. I chose this because the app was quite straightforward and didn't need to be over engineered by using an advanced pattern like VIPER. Using Protocol Oriented Programming with MVVM allows more testable code.

- For UI part I've decided to mainly do the UI layout in code (programmaticallly), I decided this as it's much easier to control and reuse the UI layout. 

## Limitation

- Code not fully tested. I tried adding some unit test for Fetch Repos API and Commits API, but didn't have time complete to all the tests.

- UI Design could be improved. I didn't want to spend too much time coming up with the UI so I decided to go with a very basic UI.

## Known Issues

- TableViewCell UI design need to be improved.
- Does not support night mode.
- API rate limit for the current APIs, need to add some sort of user authentication.



## Improvements / Need to be done
- Due to limited time constraints, wrote only few unit Tests and UI tests by using XCTest & XCUITest. Need to cover all unit tests.
- Need to add an authentication for users.
- Add Pagination for fetching network calls for better performance and results.



## Technologies

- iOS 12+
- Xcode 12+
- Swift 5+
- UIKit
- Programmatically UI
- XCTest & XCUITest
- MVVM-C
- Atomic Commits - Git 
- Instrument (Leaks, allocations)
- Memory graph.



