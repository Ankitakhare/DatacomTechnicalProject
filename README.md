# DatacomTechnicalProject
Created an app using Swift (UIKit) and an MVVM architecture  as per the requirements.
created an application using Xcode 14.2 and Swift 5.7 and iOS 16 




What features does this app contain:
AlbumList on the Basis of title  and user name which the album belong 
User Detail have been fetched from the user end point API
Album Image return by the API .
When Thumbnail is clicked Image shown in the full Screen .

I have followed MVVM Architecture  so created the ModelClass - AlbumTitleModel Which holds the all the data.


//Model
in this AlbumTitleModel.swift class  Swift structures that conform to the Codable protocol used. This allows them to be encoded and decoded from JSON .
The AlbumTitleModel structure represents a model for an album title, with properties for the user ID, ID, and title.
The AlbumUserModel structure represents a model for an album user, with properties for the ID, name, username, email, address, phone, website, and company. The Address and Company structures are nested inside the AlbumUserModel structure and represent the address and company of the user, respectively.
The AlbumImageModel structure represents a model for an album image, with properties for the album ID, ID, title, URL, and thumbnail URL.
By conforming to the Codable protocol, these structures can be easily converted to and from external representations from JSON. its make task easy when working with the api.

//ViewModel
The AlbumViewModel class is a view model for a user interface that displays information about albums and photos. It appears to have several properties, including a list of users, a list of albums, a list of images, and a closure for reloading a table view.
The AlbumViewModel class also has several methods for fetching data from an ApiManagerProtocol object, which is responsible for making network requests to an API. The fetchUserDetail, fetchAlbumsList, and fetchPhotos methods all use the apiManager object to retrieve data from the API. The getUserName method is used to get the name of a user with a given ID from the userList property.
The AlbumViewModel class has an initializer that takes two optional parameters, apiManager and internetChecker. These parameters have default values, so they can be omitted when creating an instance of the class. The apiManager parameter is used to set the value of the apiManager property, and the internetChecker parameter is used to set the value of the internetChecker property.
this do the data binding !!
The AlbumViewModel class seems to be designed to act as a intermediary between the user interface and the API. It fetches data from the API as needed and stores it in its properties, and it provides methods for the user interface to access this data. It also has a closure that can be used to refresh the table view when new data is available.
Overall, the AlbumViewModel class is a useful tool for managing and displaying data in a user interface that displays information about albums and photos.


//API Manager Class 
This class is an implementation of the ApiManagerProtocol in Swift. It appears to be responsible for making network requests to retrieve data from an API and returning the results to the caller.
The ApiManager class has three methods: fetchAlbumsList, fetchUserDetail, and fetchPhotos. Each of these methods makes a network request to a specific endpoint of the API and processes the response.The fetchAlbumsList method makes a GET request to the "https://jsonplaceholder.typicode.com/albums" endpoint and returns a list of AlbumTitleModel objects in the response. The fetchUserDetail method makes a GET request to the "https://jsonplaceholder.typicode.com/users" endpoint and returns a list of AlbumUserModel objects in the response. The fetchPhotos method makes a GET request to the "http://jsonplaceholder.typicode.com/photos" endpoint with a query parameter indicating the album ID, and returns a list of AlbumImageModel objects in the response.
Each of these methods uses a completion handler to return the results of the network request to the caller. The completion handler is a closure that takes two optional parameters: an array of the appropriate model objects, and an error object if an error occurred. This allows the caller to handle the results of the network request or handle any errors that may have occurred.
Regenerate response.

// InternetChecker Protocol
This class is a simple implementation of an Internet connection checker for iOS. It defines a protocol called InternetCheckerProtocol which specifies a single method isInternetAvailable() that returns a Boolean value indicating whether or not the device has an active Internet connection. The InternetChecker class itself implements this protocol and provides a concrete implementation of the isInternetAvailable() method.
The method uses the System Configuration framework to check the device's current network reachability status. It creates a socket address with the sockaddr_in struct and passes it to the SCNetworkReachabilityCreateWithAddress() function to create a network reachability reference. It then calls the SCNetworkReachabilityGetFlags() function to retrieve the current flags for the reference.
The flags are then examined to determine whether the device is currently reachable and whether a connection is required. If the device is reachable and no connection is required, the method returns true, indicating that the device has an active Internet connection. If either of these conditions is not met, the method returns false.

//AlbumVC ViewControllerClass
This class appears to define a view controller for an iOS app that displays a list of albums. The view controller has a viewModel property of type AlbumViewModel, which is used to fetch and store the data for the albums. The view controller also has a table view, and it sets up the table view with certain properties and implements various methods to configure the table view, such as numberOfSections, numberOfRowsInSection, cellForRowAt, didSelectRowAt, and heightForRowAt. When the view controller's viewDidLoad method is called, it sets up the view by calling the setupView method and then fetches the album data by calling the callWebserviceForAlbumsList method. The callWebserviceForAlbumsList method calls a method on the viewModel object to fetch the album data, and it also sets up a closure to reload the table view when the data is ready


//AlbumDetailVC Viewcontroller Class
This code is for a UIViewController in an iOS app that displays a list of images in a UICollectionView. The view controller has a property albumViewModelObj of type AlbumViewModel which is used to fetch the list of images to be displayed. When the view controller's viewDidLoad method is called, it calls a method callWebserviceForAlbumsImageList which in turn calls a method fetchPhotos on the albumViewModelObj object and passes it the albumId property of the view controller. The fetchPhotos method is responsible for fetching the list of images from some remote source.
The view controller also has a UICollectionView outlet called collectionViewAlbums and a UIImageView outlet called imgFull. The collectionViewAlbums is used to display the list of images and the imgFull is used to display a full-sized version of the selected image.
The view controller also implements the UICollectionViewDelegate and UICollectionViewDataSource protocols to handle the display of the images in the collection view. The collectionView(_:numberOfItemsInSection:) method returns the number of items in the collection view, which is the number of images in the arrayImageList property of the albumViewModelObj object. The collectionView(_:cellForItemAt:) method returns a UICollectionViewCell for each image in the arrayImageList property to be displayed in the collection view.
When an image in the collection view is selected, the collectionView(_:didSelectItemAt:) method is called. This method sets the imgFull image view to the selected image and shows the viewFull view.
The view controller also implements the UICollectionViewDelegateFlowLayout protocol to handle the layout of the cells in the collection view. The collectionView(_:layout:sizeForItemAt:) method returns the size for each cell in the collection view, and the collectionView(_:layout:minimumInteritemSpacingForSectionAt:) and collectionView(_:layout:minimumLineSpacingForSectionAt:) methods return the minimum spacing between cells and lines in the collection view.
Regenerate response

//AlbulTitleCell
This is a class definition for an AlbumTitleCell in Swift,
The class has two outlets, titleLabel and userLabel, which are instances of UILabel, a standard UI element for displaying text in iOS. The outlets are used to set the text displayed in the labels.
The prepareForReuse() method is an override of a method in the superclass UITableViewCell. It is called just before the cell is reused, which occurs when the table view is scrolled and cells go off-screen and are then scrolled back on-screen. The method resets the text of the labels to an empty string, effectively clearing the cell for reuse.

//AlbumImageCell
This is a UICollectionViewCell subclass in Swift. It has an imgAlbum outlet of type UIImageView and a property albumImage of type AlbumImageModel.
The awakeFromNib() method is called when the cell is loaded from the storyboard. It sets up the imgAlbum view with a rounded corner and a mask to bounds to make it look like a circle.
The setUpUI() method is called when the albumImage property is set. It asynchronously fetches the image from the URL specified in the thumbnailUrl property of the albumImage object, and sets the imgAlbum image to the fetched image. If the image cannot be fetched, it sets the imgAlbum image to a default image named "img".

//Album_iosTests class
The Album_iosTests class has a couple of instance variables that are used as spies: internetChecker and apiManager. These objects are instances of classes that are designed to record when certain methods are called on them, so that the unit test can verify that the correct methods were called under the right circumstances.
The Album_iosTests class also has an instance variable viewModel of type AlbumViewModel, which is initialized in the setUp() method. This method is called before each test method in the class is run, so that the viewModel variable is set up with the appropriate dependencies (apiManager and internetChecker) before each test is run.
The testFetchUserDetail() method is a unit test that verifies that the fetchUserDetail() method on the viewModel object correctly calls the fetchUserDetail() method on the apiManager object, given that the internetChecker object reports that the internet is available. The test does this by using the invokedFetchUserDetail property on the apiManager object, which is set to true when the fetchUserDetail() method is called on apiManager. The test then uses the XCTAssertTrue() function to verify that this property is indeed true.
Regenerate response


