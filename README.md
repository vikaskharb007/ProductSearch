# Product Search
The app enables the user to search for a product by entering a  text in the search bar. Once the user presses search results are published in a table view. 

App has following implementations

- Makes backend call for downloading all the product details
- Seperate call for downloading the product images
- Basic call failures have been handled
- Each new search call clears the existing products

UI:
UI has been created progrmatically. Autolayout has been utilised.
Image size optimisation for resizing has not been done.

Architechture: 
- The app uses MVVM.

Testing:
- Major components of the app have been covered with unit testing. View models have been tested by injecting mock network manager to demonstrate uncoupled testing.
- There are no UI tests 

Note: Although the app is universal and supports all form factors and orientations, it best works in iPhone 12 with minium deployment target iOS13

