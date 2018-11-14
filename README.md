# ADIB
# NY Times Article Assignment

# How do i run the code?
 * Step 1 : Get the latest pull from git "https://github.com/abdul-naveed/ADIB.git"
         $ git pull https://github.com/abdul-naveed/ADIB.git
         
 * Step 2 : Open the Folder ADIB/Articles
 * Step 3 : Double Click and Open Articles.xcodeproj
 * Step 4 : Select Articles Target and Select iPhone X
 * Step 5 : Click on Build & Run 


# How do i test the code?
 * Step 1 : Get the latest pull from git "https://github.com/abdul-naveed/ADIB.git"
         $ git pull https://github.com/abdul-naveed/ADIB.git
         
 * Step 2 : Open the Folder ADIB/Articles
 * Step 3 : Double Click and Open Articles.xcodeproj
 * Step 4 : Select Articles Target
 * Step 5 : Select Product-> Test


# About the Code

 * Design Pattern : MVVM
 * Code is generic enough to fetch the articles
 * Used 'Codable' for encoding and decoding JSON
 * ArticlesManager :
     This class responsible to have all the API's integrated to fetch the details 
     from server and return back the proper models. This class contains a class methods and can be used enhance further
 * Master :
      * ViewController : Responsible to display the list of Articles by invoking the API in ArticlesManager.
 * Detail :
      * ArticleDetailViewController : Responsible to display the details of selected Article in 
                                      the list of ViewContoller(Master)

 * Models : 
      * ArticleAPI      : Contains all necassary API Details
      * Article         : Contains information of each article
      * ArticleResponse : Contains information of list of articles
      
      
# Class Diagram

![alt text](https://github.com/abdul-naveed/ADIB/blob/master/Class_Diagram.jpeg)

