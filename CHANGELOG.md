# Changelog

## 2.1.0
- Updated dart sdk to the range currently default through flutter
- Added OnCleared callback which does as expected -- called when the user clears their input
- Explicitly disabled all borders, and fixes some flickering problems
- Some minor code improvements (remove `new`, remove some ignored files)

## 2.0.7
- Added SearchBar.onClosed handler for closing of the search bar (it doesn't fire when submitted, only cancelled)

## 2.0.6
- Updated to Dart 2

## 2.0.5 
- SearchBar's app bar callback is now less strict, and allows any widget to be returned.
- Many variables are now final
- isSearching is a new property on SearchBar, and it's a ValueNotifier. Don't change the value on it yourself or things might be screwed up.

## 2.0.4
- Added SearchBar.onChanged event which can be set in search bar initialization

## 2.0.3
- SearchBar.hintText is no longer final or required so you can now assign it values after initialization (e.g. for i18n)

## 2.0.2
- Add SearchBar.isSearching property to tell whether search is currently active

## 2.0.1

- Remove a bunch of extra debug. Whoops!
- Adds support for RTL automagically using Directionality

## 2.0.0

- Add a clear button option to the search bar, which will obviously clear all text when pressed. It's greyed out when there is no text in the bar.
- Replace the named 'hideDivider' property with 'border' to support the newest version of flutter

## 1.0.4

- Add support for controller in the TextField

## 1.0.3

- Fix an issue where calling `Navigator.pop` methods inside `onSubmitted` would cause a NPE and throw a really gnarly error that doesn't even print to console.

## 1.0.2

- Fix an issue where a null backgroundColor in appBar caused a white back button. Also, change to `flutter_search_bar` because I'm a genius and locked myself out of `search_bar` until I buy gapps for `spencer@frozor.io`.

## 1.0.1

- Compile documentation, whoops.

## 1.0.0

- Initial version