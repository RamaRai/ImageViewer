//
//  ViewController.swift
//  ImageViewer Swift
//
//  Created by user152991 on 5/8/19.
//  Copyright © 2019 RamaRai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    

    @IBOutlet weak var imageView: UIImageView!
    
    // Activity Indicator Style
    let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
    
    var imageNames = [String]()
    var currentIndex = 0
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Additional setup after loading the view.
        
        //Creating a view for Activity Indicator
        self.view.addSubview(activityIndicator)
        activityIndicator.frame = imageView.bounds
        activityIndicator.center = imageView.center
        
        // To show Activity animation
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        
        //Creating string Array of image names
        imageNames.append("lobster.jpg")
        imageNames.append("pasta.png")
        imageNames.append("pizza.jpg")
        imageNames.append("steak.jpg")
        
        //Calling function to fetch the image
        fetchDataAndUpdateUI()
        
    }
    
    
    
    @IBAction func prevBtnPressed(_ sender: Any) {
        
    //Image needs to be fetched , Activity Indicator needs to start and should be shown
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        
        //When your image index reaches 0, index needs to be reset to max index
        if (self.currentIndex > 0) {
            
            self.currentIndex -= 1;
            
        } else {
            
            self.currentIndex = self.imageNames.count - 1;
            
        }
        
        // Calling function for multi threading to fetch image
        fetchDataAndUpdateUI()
     
    }
    
    
    
    @IBAction func nextBtnPressed(_ sender: UIBarButtonItem) {
        
        //Image needs to be fetched , Activity Indicator needs to start and should be shown
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        
        //When your image index is max, index needs to be reset to 0
        if (self.currentIndex < self.imageNames.count - 1) {
            
            self.currentIndex += 1;
            
        } else {
            
            self.currentIndex = 0;
            
        }
       
        // Calling function for multi threading to fetch image
        fetchDataAndUpdateUI()
        
    }
    
    
    
    func getImageDatawithImageName(_ imageName: String) -> NSData
        
    {
        //Function to Convert the string url to url
       
        var imageData:  NSData?
        let urlString: String = "https://raniaarbash.000webhostapp.com/" + imageName
        
        // Optional url as it will have the value later
        let url: URL = URL(string: urlString)!
        
         // and to fetch image from the url to Data format
        imageData = NSData.init(contentsOf: url)
        
        return imageData!;
        
    }
    
    
    
    func fetchDataAndUpdateUI() {
        
        //Multi Threading
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else {
                return
            }
           //Fetching image from the index by calling function
            let imageData = self.getImageDatawithImageName(self.imageNames[self.currentIndex])
            
            //Joining the main thread
            DispatchQueue.main.async {
                //When image is ready to be updated , Activity Indicator needs to stop and should be hidden
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                
                //Converting data to image format for imageview
                self.imageView.image = UIImage(data: imageData as Data)
                
            }
            
        }
        
    }
    


}

