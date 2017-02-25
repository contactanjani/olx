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


VIPER ARCHITECTURE outline is as below:
For each page, we have the following components.
Transition between one page to another happens via Wireframe. Also, flow of data between pages happens via wireframes.  
User-Interface(1) <---> Presenter(2) <---> Interactor(3) <---> Data-Manager(4)  <---> Data-Store/API-Service(5)  
                        ^   
                        |  
                        |   
                        v  
                    Wireframe (6)  
  
User-Interface - handles the most basic UI tasks. Meant to be very light weight. Informs the Presenter of any user event in the UI.  
  
Presenter - the code to handle UI logic resides here. It guides the User interface to execute UI changes in response to data received from Interactor.  
  
Interactor - Contains the bulk of business logic, sorting, filtering etc. only data processing is done here.  
  
Data-Manager - provides very basic data list/set to the interactor for processing. Data Manager fetches data either from cache, file system or API.  
  
Data-store/API Service : contains code to read file, fetch response from API or any other end point data source.  
  
Wire frame - Sends/receives signals from Presenter only. It can ask a presenter to display it's UI by providing certain input. It can also receive direction from presenter to present another User-interface via any type of transition. One way of data flow from one module(page) to another happens through wireframe.  
  
Class Names in the code base are as below:  
Search/List page :  
  
ListViewController(1)  
ListPresenter(2)  
ListInteractor(3)  
ListDataManager(4)  
CoreDataStore(5)  
APIService(5)  
ListWireframe(6)  
  
  
Detail Page :  
DetailViewController(1)  
DetailPresenter(2)  
DetailInteractor(3)  
DetailWireframe(6)  
