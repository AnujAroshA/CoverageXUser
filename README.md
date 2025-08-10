# CoverageXUser

SwiftUI iOS sample app showing a list of users fetched from https://randomuser.me using MVVM.

## Features
- MVVM architecture
- Combine-based networking
- Pull-to-refresh
- Search filter
- Loading & error UI states
- Localized strings
- Unit tests (network service + ViewModel)
- UI tests (checks main views existence)

## Developed and Tested on
- Xcode 16.4
- iOS 18.5

## How to run
1. Clone the project to a Mac
2. Open the project in Xcode
3. Build and run the application targetting a emulator
4. (Optional) If you want to run targetting a real device you may need to change the Team and Bundle Identifier

## Notes on approach
- Networking implemented using `URLSession` and `Combine`'s `dataTaskPublisher`.
- ViewModel exposes `@Published` properties for the view to react to.
- Pull-to-refresh uses `.refreshable` (iOS 15+).
- Images are loaded using AsyncImage.

## Tests
- Unit tests to cover Networking functionalities and ViewModel funtions.
- UI tests verify that once user tap on a list item it will navigate to Details view and it has necessary widgets to show data.
- Tests has 95% code coverage
