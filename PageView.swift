//
//  PageView.swift
//  
//
//  Created by Serg MacOs on 05.05.2022.
//

import UIKit

class PageView: UIPageViewController {
    
    let presentationText = ["Цель игры","Подготовка к игре","Ход игры","Конец игры", "Состав игры"]
    let presentationImage = [UIImage(named: "startGamePic"),UIImage(named: "prepareToGamePic"),UIImage(named: "gameProgressPic"),UIImage(named: "endGamePic"), UIImage(named: "cardsPic")]
    let presentationDescriptionImage = [UIImage(named: "startGame"),UIImage(named: "prepareToGame"),UIImage(named: "gameProgress"),UIImage(named: "endGame"),UIImage(named: "cards")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        nextPage()
    }
    
    
    func nextPage() {
        if let presPage = showViewContollerAtIndex(index: 0) {
        setViewControllers([presPage], direction: UIPageViewController.NavigationDirection.forward, animated: true, completion: nil)
        }
    }
    
    func showViewContollerAtIndex (index:Int) -> Presentation? {
        
        guard index >= 0 else {return nil}
        guard index < presentationText.count else {return nil}
        guard let wayFromPresentPage = storyboard?.instantiateViewController(withIdentifier: "presentationPage-id") as? Presentation else {return nil}
        
        wayFromPresentPage.newText = presentationText[index]
        wayFromPresentPage.newImage = presentationImage[index]!
        wayFromPresentPage.newDescriptionImage = presentationDescriptionImage[index]!
        wayFromPresentPage.currentPage = index
        wayFromPresentPage.numberOfPages = presentationText.count
        wayFromPresentPage.newButton = true
        
        switch index {
        case 4 : wayFromPresentPage.newButton = false
                 let userDefault = UserDefaults.standard
                 userDefault.set(true, forKey: "presentationWasViewed")
        default:break
        }
        return wayFromPresentPage
    }
    
}

extension PageView : UIPageViewControllerDataSource {
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var pageNumber = (viewController as! Presentation).currentPage
        pageNumber -= 1
        return showViewContollerAtIndex(index: pageNumber)
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var pageNumber = (viewController as! Presentation).currentPage
        pageNumber += 1
        return showViewContollerAtIndex(index: pageNumber)
    }
    
}
