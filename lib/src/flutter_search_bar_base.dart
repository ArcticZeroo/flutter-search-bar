// Copyright (c) 2017, Spencer. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

typedef AppBar AppBarCallback(BuildContext context);
typedef void TextFieldSubmitCallback(String value);
typedef void SetStateCallback(fn);

class SearchBar {
  /// Whether the search should take place "in the existing search bar",
  /// meaning whether it has the same background or a flipped one.
  /// Defaults to true.
  final bool inBar;

  /// Whether the back button should be colored, if this is false the
  /// back button will be Colors.grey.shade400
  final bool colorBackButton;

  /// Whether or not the search bar should close on submit. Defaults to true.
  final bool closeOnSubmit;

  /// What the hintText on the search bar should be. Defaults to 'Search'.
  final String hintText;

  /// A callback which should return an AppBar that is displayed until search
  /// is started. One of the actions in this AppBar should be a search button
  /// which you obtain from SearchBar.getSearchAction(). This will be called
  /// every time search is ended, etc. (like a build method on a widget)
  final AppBarCallback buildDefaultAppBar;

  /// A void callback which takes a string as an argument, this is fired every
  /// time the search is submitted. Do what you want with the result.
  final TextFieldSubmitCallback onSubmitted;

  /// Since this should be inside of a State class, just pass setState to this.
  final SetStateCallback setState;

  /// The controller to be used in the textField.
  TextEditingController controller;

  /// Whether search is currently active.
  bool _isSearching = false;

  /// Whether a search text is present.
  bool _isSearchTextPresent = false;

  // If this is true the Parent Route will be poped when the Back Button is used
  bool popParentOnBackButton;

  /// The last built default AppBar used for colors and such.
  AppBar _defaultAppBar;

  /// This hides or shows the button on the right site of the text input field
  bool showClearTextButton;

  /// This hides or shows the underline of the search text input field
  bool hideSearchBoxDevider;

  SearchBar(
      {@required this.setState,
      @required this.buildDefaultAppBar,
      this.onSubmitted,
      this.controller,
      this.hintText = 'Search',
      this.inBar = true,
      this.colorBackButton = true,
      this.closeOnSubmit = true,
      this.popParentOnBackButton = false,
      this.showClearTextButton = false,
      this.hideSearchBoxDevider = true}) {
    if (controller == null) controller = new TextEditingController();

    _isSearchTextPresent = controller.text.isNotEmpty;

    controller.addListener(() =>
        setState(() => _isSearchTextPresent = controller.text.isNotEmpty));
  }

  /// Initializes the search bar.
  /// This adds a new route that listens for onRemove (and stops the search
  /// when that happens), and then calls [setState] to rebuild and start
  /// the search.
  void beginSearch(context) {
    if (!popParentOnBackButton) {
      ModalRoute
          .of(context)
          .addLocalHistoryEntry(new LocalHistoryEntry(onRemove: () {
        setState(() {
          _isSearching = false;
        });
      }));
    }

    setState(() {
      _isSearching = true;
    });
  }

  /// Builds, saves and returns the default app bar.
  ///
  /// This calls the [buildDefaultAppBar] provided in the constructor,
  /// and saves it to [_defaultAppBar].
  AppBar buildAppBar(BuildContext context) {
    return _defaultAppBar = buildDefaultAppBar(context);
  }

  /// Builds the search bar!
  ///
  /// The leading will always be a back button.
  /// backgroundColor is determined by the value of inBar
  /// title is always a [TextField] with the key 'SearchBarTextField',
  /// and various text stylings based on [inBar].
  /// This is also where [onSubmitted] has its listener registered.
  ///
  AppBar buildSearchBar(BuildContext context) {
    var theme = Theme.of(context);

    return new AppBar(
        leading: new BackButton(
            // Don't provide a color (make it white) if it's in the bar,
            // otherwise color it or set it to grey.
            color: inBar
                ? null
                : (colorBackButton
                    ? _defaultAppBar.backgroundColor ??
                        theme.primaryColor ??
                        Colors.grey.shade400
                    : Colors.grey.shade400)),
        backgroundColor:
            inBar ? _defaultAppBar.backgroundColor : theme.canvasColor,
        title: new Row(
          children: <Widget>[
            new Expanded(
                child: new TextField(
              //TODO keys should be unique - if thats gets created over
              //that could explain the error that the global key is not
              // unique exception
              key: new Key('SearchBarTextField'),
              keyboardType: TextInputType.text,
              style: new TextStyle(
                  color: inBar ? Colors.white70 : Colors.black54,
                  fontSize: 16.0),
              decoration: new InputDecoration(
                  hintText: hintText,
                  hintStyle: new TextStyle(
                      color: inBar ? Colors.white70 : Colors.black54,
                      fontSize: 16.0),
                  hideDivider: hideSearchBoxDevider),
              onSubmitted: (val) async {
                if (closeOnSubmit) {
                  await Navigator.maybePop(context);
                }
                onSubmitted(val);
              },
              autofocus: true,
              controller: controller,
            )),
            new Opacity(
                opacity: showClearTextButton ? 1.0 : 0.0,
                child: new IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: _isSearchTextPresent && showClearTextButton
                        ? () {
                            controller.text = '';
                          }
                        : null,
                    color: inBar ? Colors.white70 : Colors.black54)),
          ],
        )

        /*actions: <Widget>[
        new IconButton(
            icon: new Icon(Icons.send),
            onPressed: null
        )
      ]*/
        );
  }

  /// Returns an [IconButton] suitable for an Action
  ///
  /// Put this inside your [buildDefaultAppBar] method!
  IconButton getSearchAction(BuildContext context) {
    return new IconButton(
        icon: new Icon(Icons.search),
        onPressed: () {
          beginSearch(context);
        });
  }

  /// Returns an AppBar based on the value of [_isSearching]
  AppBar build(BuildContext context) {
    return _isSearching ? buildSearchBar(context) : buildAppBar(context);
  }
}
