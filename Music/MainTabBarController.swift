//
//  MainTabBarController.swift
//  Music
//
//  Created by ivan on 17.12.2020.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        tabBar.tintColor = #colorLiteral(red: 1, green: 0, blue: 0.3764705882, alpha: 1)
        
        let searchVC: SearchViewController = SearchViewController.loadFromStoryboard()
        
        viewControllers = [
            generationViewController(rootViewCOntroller: searchVC, image: #imageLiteral(resourceName: "ios10-apple-music-search-5nav-icon-1"), title: "Search"),
            generationViewController(rootViewCOntroller: ViewController(), image: #imageLiteral(resourceName: "ios10-apple-music-library-5nav-icon"), title: "Library")
        ]
    }
    
    private func generationViewController(rootViewCOntroller: UIViewController, image: UIImage, title: String) -> UIViewController {
        
        let navigationVC = UINavigationController(rootViewController: rootViewCOntroller)
        navigationVC.tabBarItem.image = image
        navigationVC.tabBarItem.title = title
        rootViewCOntroller.navigationItem.title = title
        navigationVC.navigationBar.prefersLargeTitles = true
        return navigationVC
    }
}
