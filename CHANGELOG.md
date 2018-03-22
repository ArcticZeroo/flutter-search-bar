# Changelog

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