# FortNightly

1) Developed entired application in VIPER Architecture and mostly implemented the UI in Autolayouts programatically
2) Dependency Manager - Cocoapods SDWebImage is used for displaying Images Asynchronously

Note: Cocoapods code is also commited in the repository to avoid additional dependcies to run the project after downloading it.

# Utilities:
Contains Network manager, Constants, Server keys and extensions

NetworkManager:
1) Responsible for performing any Client server communication provided by a Request object (ArticlesViewInteractor creates the request and send it to NetworkManager)
2) Responsible for download the Image data through the API

ServerKeys:
1) Contains the apis for base URL for News Articles and keys for different category News. These Keys will be useful when the UI is extended its functionality to display a different categories or for a Single company or source

UIImageViewExtensions:
1) Responsible for downloading the image communicating the NetworkManager and update the UIImageView with an image

UIImage Extensions:
1) Responsible to scale the bigger image to smaller size 

UIFont Extensions:
1) Used to call these extension methods for the common fonts that are used in the screens.

UINavigation Extensions:
1) Implemented the extension functions for Navigation Controller using Protocol Oriented Programming. Instead of inheriting the Custom Navigation Bar, extended the functionality to customize the Navigation Bar using protocols

Date Extensions:
1) Used Relative Data Formatter to calculate the published time of the Article

Utilities:
Used to get the common UI components for this application. Can construct the Factory pattern for these common UI elements instead of maintaining in Utilities


# ArticlesModule:

Initial View Controller that shows the list of News Articles for a technology Category in US

Configurator: 
Defines the Responsibilities of ArticlesViewPresenter, ArticlesViewInteractor and ArticlesViewRouter using protocols

ArticlesViewRouter:
1) Responsible for creating the ArticlesViewController with presenter and Interactor
2) Responsible to navigate to a DetailArticle when selected

ArticlesViewController:
1) Responsible to display the list of Articles. Communicates with Presenter to fetch the News Articles on Technology Category. Once presenter provides the News Articles, ViewController passes the information to ArticlesViewDataSource which will handle organizing the data in list.
2) Also Responds to any actions that are sent from Data source like selecting a News Article or customizing the navigation when the scrolling events occured.

ArticlesViewDataSource:
1) Responsible for displaying the news Articles and the Cover photo on the Front page. Also responsible to capture the events on scrolling, selecting any news article and send them to View Controller

ArticlesViewPresenter:
1) Responsible to Communicate with ArticlesViewInteractor to fetch any category News and takes the action from ArticlesViewController

ArticlesViewInteractor:
1) Responsible to Interact with NetworkManager to fetch the News Articles, parse them and update it back to ArticlesViewPresenter.


# ArticlesDetailModule:
Responsible to display the selected News Article Information using UIStackView


