// Copyright (c) 2017, Spencer. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_search_bar/search_bar.dart';

void main() {
  runApp(new SearchBarDemoApp());
}

class SearchBarDemoApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Search Bar Demo',
        theme: new ThemeData(
            primarySwatch: Colors.blue
        ),
        home: new SearchBarDemoHome()
    );
  }
}

class SearchBarDemoHome extends StatefulWidget {
  @override
  _SearchBarDemoHomeState createState()=> new _SearchBarDemoHomeState();
}

class _SearchBarDemoHomeState extends State<SearchBarDemoHome> {
  SearchBar searchBar;

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
        title: new Text('Search Bar Demo')
    );
  }

  void onSubmitted(String value) {
    Scaffold.of(context).showSnackBar(
      new SnackBar(
          content: new Text('You wrote $value!')
      )
    );
  }

  _SearchBarDemoHomeState() {
    searchBar = new SearchBar(
      inBar: false,
      buildDefaultAppBar: buildAppBar,
      setState: setState,
      onSubmitted: onSubmitted
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: searchBar.build(context),
      body: new Center(
        child: new Text("Don't look at me! Press the search button!")
      ),
    );
  }
}