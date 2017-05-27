//
//  PageViewController.swift
//  Thesis
//
//  Created by Kaya Thomas on 10/2/16.
//  Copyright © 2016 Kaya Thomas. All rights reserved.
//

import UIKit

class PageViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var choosenCharacter: String!
    var pageController: UIPageViewController?
    var pageContent: [String] = []
    var imgName: String!
    var userid : String!

    override func viewDidLoad() {
        super.viewDidLoad()
        pageContent = tutorialImgs.dict[choosenCharacter!]!

        // Do any additional setup after loading the view.
        pageController = UIPageViewController(
            transitionStyle: .pageCurl,
            navigationOrientation: .horizontal,
            options: nil)
        
        pageController?.delegate = self
        pageController?.dataSource = self
        
        let startingViewController: ContentViewController =
            viewControllerAtIndex(index: 0)!
        
        let viewControllers: NSArray = [startingViewController]
        pageController!.setViewControllers(viewControllers
            as? [UIViewController],
                                           direction: .forward,
                                           animated: false,
                                           completion: nil)
        
        self.addChildViewController(pageController!)
        self.view.addSubview(self.pageController!.view)
        
        let pageViewRect = self.view.bounds  
        pageController!.view.frame = pageViewRect    
        pageController!.didMove(toParentViewController: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewControllerAtIndex(index: Int) -> ContentViewController? {
        
        if (pageContent.count == 0) ||
            (index >= pageContent.count) {
            return nil
        }
        
        let storyBoard = UIStoryboard(name: "Main",
                                      bundle: Bundle.main)
        let dataViewController = storyBoard.instantiateViewController(withIdentifier: "contentView") as! ContentViewController
        
        dataViewController.imgName = pageContent[index]
        dataViewController.currentGame = choosenCharacter
        dataViewController.userid = userid
        return dataViewController
    }
    
    func indexOfViewController(viewController: ContentViewController) -> Int {
        
        if let data: String = viewController.imgName {
            return pageContent.index(of: data)!
        } else {
            return NSNotFound
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        var index = indexOfViewController(viewController: viewController as! ContentViewController)
        
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        index -= 1
        return viewControllerAtIndex(index: index)
    }

    func pageViewController(_ pageViewController: UIPageViewController,
                        viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        var index = indexOfViewController(viewController: viewController as! ContentViewController)
    
        if (index == NSNotFound) {
            return nil
        }
    
        index += 1
    
        if index == pageContent.count {
            return nil
        }
    
        return viewControllerAtIndex(index: index)
    }
}
