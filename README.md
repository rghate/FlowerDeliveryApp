# FlowerDeliveryApp
Test application to download, parse and display flowers and gifting products. 

Deployment target: iOS11.0
Mode: Portrait 
Swift version: Swift 5


Third party libraries:
1. SDWebImage - For image download and caching. 
2. Cosmos - For (star)rating widget


Features:
- Completed product details download, json parsing and display.
- A vertically scrollable custom carousel view (implemented using UICollectionView) to browse through single product images
- Design architecture - MVVM
- Unit testing to test viewmodel and network layer. 
- Network error handling and alert messages displayed where required.  
- Local Testfile.json (stored in /Resources/TestFile.json) for offline data testing 

Please Note:

1. Created a local test json file (./Resources/TestFile.json). To read data from test file, set ‘readTestData’ property to true in APIService.swift.

    
    Improvements:
    
    1. Filtering (based on letterbox, hand-tied, occassion, subscriptions, sorting) is not implemented. The method to filter products can be added into ProductViewModel file.
    2. No 'Save product to favorites' implemented. The toggle of favorite button and its delegate is handled.
    3. UI Testing.
    4. Making application localization ready.
    

    
    
