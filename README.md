# olx

1. XCode 8.1, Swift3 is used.  
2. VIPER architecture used - very scalable architecture, separation of responsibilities of classes.  
3. contains 2 pages - search and details  
4. works for both landscape and portrait - auto layout is used for view controller and tableview/cells.  
5. core data is used - the last search results are cached. whenever a new keyword is searched, the older results are cleared and the results for new keyword are cached.  
6. paginated content - in the search page, click on search field, enter a keyword, you can watch activity indicator on status bar, the results are displayed after ~5 seconds. Scroll down infinitely to see paginated content refreshing whenever the available cells are close to exhaustion. page size is set to 30.  
7. Image Caching is used - time out before cleanup/refresh of an image is set to 10hours.
8. item detail page - supports landscape and portrait. shows full image, title, price and description.  
9. custom protocols - ListViewInterface, ListModuleInterface. VIPER is very protocol driven architecture.  
10. unit tests and UI tests have been written. Can be executed by pressing cmd+U.  
