//
//  Presentation.swift
//  
//
//  Created by Serg MacOs on 05.05.2022.
//

import UIKit

class Presentation: UIViewController {
    
    @IBOutlet weak var presentationImage: UIImageView!
    @IBOutlet weak var presentationDescriptionImage: UIImageView!
    @IBOutlet weak var presentationText: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var continueButton: UIButton!
    
    var newText = ""
    var currentPage = 0
    var numberOfPages = 0
    var newImage = UIImage()
    var newDescriptionImage = UIImage()
    var newButton = UIButton.accessibilityElementsHidden()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presentationImage.image = newImage
        presentationDescriptionImage.image = newDescriptionImage
        presentationText.text = newText
        pageControl.currentPage = currentPage
        pageControl.numberOfPages = numberOfPages
        continueButton.isHidden = newButton
    }
    
    
    @IBAction func continueButton(_ sender: UIButton) {
        
        let way = storyboard?.instantiateViewController(withIdentifier: "navigationController-id")
        present(way!, animated: true, completion: nil)
    }

}
