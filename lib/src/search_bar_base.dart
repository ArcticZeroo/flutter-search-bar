// Copyright (c) 2017, Spencer. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

typedef Widget WidgetCallback(BuildContext context);
typedef void TextFieldSubmitCallback(String value);
typedef void SetStateCallback(fn);

class SearchBar {
  final bool inBar;
  final bool colorBackButton;
  final String hintText;
  final WidgetCallback buildDefaultAppBar;
  final TextFieldSubmitCallback onSubmitted;
  final SetStateCallback setState;

  bool _isSearching = false;
  AppBar _defaultAppBar;

  SearchBar({this.inBar = true, this.colorBackButton = true, this.hintText, this.onSubmitted, this.buildDefaultAppBar, this.setState});

  void beginSearch(context) {
    ModalRoute.of(context).addLocalHistoryEntry(new LocalHistoryEntry(
      onRemove: () {
        setState(() {
          _isSearching = false;
        });
      }
    ));

    setState(() {
      _isSearching = true;
    });
  }

  // Yes, this builds two app bars each time the app bar is built, but on the bright side there are no logic checks in this one.
  Widget buildAppBar(BuildContext context) {
    AppBar appBar = buildDefaultAppBar(context);

    List<Widget> actions = appBar.actions ??  new List<Widget>(3);

    // If there's something here, it's getting overwritten. Oh well.
    actions[0] = new IconButton(
        icon: new Icon(Icons.search),
        onPressed: () {
          beginSearch(context);
        }
    );

    // Inherit everything BUT the first action in the appBar.
    _defaultAppBar = new AppBar(
      key: appBar.key,
      leading: appBar.leading,
      title: appBar.title,
      actions: actions,
      flexibleSpace: appBar.flexibleSpace,
      bottom: appBar.bottom,
      elevation: appBar.elevation,
      backgroundColor: appBar.backgroundColor,
      brightness: appBar.brightness,
      iconTheme: appBar.iconTheme,
      textTheme: appBar.textTheme,
      primary: appBar.primary,
      centerTitle: appBar.centerTitle,
      toolbarOpacity: appBar.toolbarOpacity,
      bottomOpacity: appBar.bottomOpacity
    );
    
    return _defaultAppBar;
  }

  Widget buildSearchBar(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return new AppBar(
      leading: new BackButton(
          color: inBar ? (colorBackButton ? _defaultAppBar.backgroundColor : null) : _defaultAppBar.textTheme.title.color
      ),
      backgroundColor: inBar ? theme.canvasColor : theme.canvasColor,
      title: new TextField(
          key: new Key('SearchBarTextField'),
          keyboardType: TextInputType.text,
          decoration: new InputDecoration(
              hintText: hintText ?? 'Search'
          ),
          onSubmitted: onSubmitted
      ),
    );
  }

  AppBar get(BuildContext context) {
    return _isSearching ? buildSearchBar(context) : buildAppBar(context);
  }
}