# Bucket Budget Change Log

All notable changes to bucketBudget will be documented in this file.

## [v0.1.0] - 2024-01-10

### Added

- added TabView functionality
- added Income List for all income’s added thus far
- added image labels to sort options
- added confirmation message when deleting a bucket
- added completely new addTransaction screen
- added textfield to ask for the source of the income when adding income
- added detail view for all saved income
- added income storing functionality so now all income will be saved!!

### Changed

- changed default Navigation Stack to custom List View with progress bar
- changed add transaction to be started from toolbar
- changed bucket deleting to be within the bucketDetailView instead of the swipe to delete in ContentView()
- changed sort transactions button to change to delete bucket button when editing
- changed percents to only work as integers
- changed “Add Bucket” to be on top bar instead of the main body
- changed bucketDetailView to function off of an edit button in the toolbar

### Removed

- removed edit button from ContentView()

### Known Issues

- listView() still does not handle negative numbers as hoped

## [v0.0.1] - 2024-01-03

### Added

- added a changelog file to keep track of changes directly within the project
- added spendingPercentage computed property to Bucket.swift to keep a percentage of available spending left for the month
- added allowedAmount to Bucket.swift to keep track of monthly spending allotments
- added default values of 0 to amount and percent in Buckets
- added dummy extensions to Bucket and Transaction for previews
- added notes section to transactionDetailView for user to fill out
- added default values of 0 to amount and percent in Buckets
- added dummy extensions to Bucket and Transaction for previews

### Changed

- changed ContentView to new progress bar style listView() instead of basic iOS style
- changed the initializer in Bucket.swift to accommodate new variable
- changed the dummy data in Bucket.swift to match new properties.

### Removed

- removed @FocusState from the project completely for simplicity at this point
- removed additional keyboard toolbar buttons to move from one field to the next

### Fixed

- previews now work as expected
- changed minor wording throughout
- fixed sortedTransactionView() and NavigationLinks
- changed amount to reset to ‘nil’ when transaction is saved, so that addTransaction section in bucketDetailView() completely resets upon save button press

### Known Issues

- listView() still does not handle negative numbers as hoped
