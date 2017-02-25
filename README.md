# olx

-VIPER architecture used - very scalable architecture, separation of responsibilities of classes.
-contains 2 pages - search and details
-works for both landscape and portrait - auto layout is used for view controller and tableview/cells.\n
-core data is used - the last search results are cached. whenever a new keyword is searched, the older results are cleared and the results for new keyword are cached.\n
-paginated content - in the search page, click on search field, enter a keyword, you can watch activity indicator on status bar, the results are displayed after ~5 seconds. Scroll down infinitely to see paginated content refreshing whenever the available cells are close to exhaustion. page size is set to 30. \n
-item detail page - supports landscape and portrait. shows full image, title, price and description. \n
-custom protocols - ListViewInterface, ListModuleInterface. VIPER is very protocol driven architecture. \n
-unit tests and UI tests have been written. Can be executed by pressing cmd+U. \n
