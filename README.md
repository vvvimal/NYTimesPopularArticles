# NYTimesPopularArticles
Popular articles on NY Times

## Application is built using MVVM architecture.

1. ArticlesListResponseModel(Model) - consists the properties related to fetch most popular article list API.
2. ArticlesListViewController(View) - consists the actions and loading of UI objects on the view.
3. ArticlesListViewModel(ViewModel) - consists of the business logic where the network call is made for fetching most popular articles.
4. ArticlesDetailViewController(View) - consists of article shown in Webview.
5. ArticlesDetailViewModel(ViewModel) - consists of view model which provides data to the UI
4. ArticleListViewCell - consists the cell which is getting loaded depending on the data provided


## Network Layer is seperate with generic methods for reading the files using URLSession. It consists of 

1. NetworkManager - Consisting of the genric protocol based methods for fetching and decoding JSONs.
2. Reachability - To check the connectivity to internet.
3. ArticlesListGetRequest/ArticlesListGetManager - Creation and triggering of the URL request for fetching the articles list and its detail from the json.
4. ImageDownloadRequest/ImageDownloadManager - Setting and triggering of the URL request for downloading the image from the url.
5. CacheManager - Singleton class with methods to set limits to the cache, set object, get object to the URL


## Utils classes are also present which give generic functionality which can be used throughout the applications

1. Extensions - Extensions written for classes(i.e UIViewController) for adding alerts, activity indicator.
2. AppConstants - Application constants used throughout the app. Strings, Enums, Errors etc


## Unit XCTestCases with coverage of 91.7%(screenshot added).
1. ArticlesListViewTests - Articles get list test cases for negative and positive cases.
2. ArticlesDetailViewTests - Article's detail related test cases for showing the webpage.
3. NetworkTests - Network request related test cases.
4. ArticlesUITests - UI Test for pull to refresh


## Notes

### Search bar not implemented due to time constraints.

### Prerequisite for Testcases
Please delete the app from simulator before running the test cases. 

### Limitations for Testcases
The UI test case are written for iPhone. It fails for iPad because of the splitview working differently on iPhone and iPad.

