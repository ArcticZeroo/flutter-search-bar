# flutter_search_bar

A simple and mostly automatic material search bar for flutter (dart).

Note: use `flutter_search_bar` and not `search_bar` -- I own both packages but I'm just a tad bit locked out of `search_bar`, so it won't be updated.

## Screenshots

Normal state (search is not active yet, only `title` and `actions` are set, with the only action being a search button)

![Normal State](https://frozor.io/up/0eytLH6M.png)

inBar set to false (background white, back button inherited): 

![inBar false](https://frozor.io/up/MdswWio.png)

inBar set to true (background inherited):

![inBar true](https://frozor.io/up/FvENH9A.png)

## Usage

A simple usage example:

```dart
class _MyHomePageState extends State<MyHomePage> {
  SearchBar searchBar;
  
  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
      title: new Text('My Home Page'),
      actions: [searchBar.getSearchAction(context)]
    );
  }  
  
  _MyHomePageState() {
    searchBar = new SearchBar(
      inBar: false,
      setState: setState,
      onSubmitted: print,
      buildDefaultAppBar: buildAppBar
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: searchBar.build(context)
    );
  }
}
```

This will create an AppBar with a search button as its only action, and on press the AppBar will turn white and have a TextField inside, allowing user input. Once the user has input something and pressed the "enter" button on their keyboard, it will close and the value will be printed to the debugger.

## Using SearchBar

Essentially, this class returns two different app bars based on whether search is active.

The setState callback you pass the search bar can technically be any VoidCallback.

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/ArcticZeroo/flutter-search-bar

We've recently added support for null-safety in 3.0.0-dev.1 -- if you find any issues, please 
report them there!