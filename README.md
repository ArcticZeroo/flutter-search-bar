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

## SearchBar vs Flutter's showSearch + SearchDelegate



## Using SearchBar

Essentially, this class returns two different app bars based on whether search is active. Colors from the most recently built "default" app bar are used to color the search bar.

I may refer to the two different app bars as **default** and **search**. Default is, as may be inferred, the _default_ app bar. It shows up when you open your app, and is the "default state". Once its search button has been pressed, the search app bar appears, where the user can put in input and submit a field.

This documentation may be slightly outdated. It will soon be generated with dartdoc instead of being manual (not really sure why it wasn't that way from the start).

### TypeDefs

#### AppBarCallback

`typedef AppBar AppBarCallback(BuildContext context);`

This should take BuildContext and return an Appbar.

#### TextFieldSubmitCallback

`typedef void TextFieldSubmitCallback(String value);`

This should take the value of the input field and return nothing.

#### SetStateCallback

`typedef void SetStateCallback(fn);`

This should take a function and return nothing. Generally, this should just be `setState`. More below.

### Constructor

_bool inBar_ - Whether the search should take place "in the existing search bar", meaning whether it has the same background as the AppBar or a flipped (white) one (which also has a colored back button if necessary). Defaults to true.

_bool colorBackButton_ - Whether the back button in the search bar should be colored, if false it will be `Colors.grey.shade400`. Defaults to true.

_bool closeOnSubmit_ - Whether the search bar should close once it has been submitted. You should probably keep this on, and it defaults to true anyways.

_String hintText_ - The hint text for the TextField that appears when the search button is pressed. Defaults to just 'Search'.

_AppBarCallback buildDefaultAppBar_ - The function to be called each time the **default** app bar is built. The colors from the most recent AppBar build will be used for the next **search** app bar.

_TextFieldSubmitCallback onSubmitted_ - A void callback called when the search bar is submitted.

_SetStateCallback setState_ - This is called every time the State needs to be updated (i.e. when the AppBar changes). You can literally just pass `setState` to this, unless for some reason you want to do extra stuff each time the AppBar changes. 

### Properties

In addition to all of the above properties set in the constructor:

_bool \_isSearching_ - Whether search is active.

_AppBar \_defaultAppBar_ - The last built default app bar.

### Methods

#### getSearchAction
`IconButton getSearchAction(BuildContext context)`
This takes `context` as an argument, and returns an IconButton suitable for an Action in an AppBar. If you want your SearchBar to actually work, put this inside your `buildDefaultAppBar`pub  method.


#### build

`AppBar build(BuildContext context)`

This takes `context` as an argument, and returns an AppBar based on whether search is active.

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/ArcticZeroo/flutter-search-bar
