//
//  MainTabBarController.swift
//  Music
//
//  Created by ivan on 17.12.2020.
//

import UIKit
import SwiftUI

protocol MainTabBarControllerDelegate: class {
    func minimizeTrackDetailController()
    func maximizeTrackDetailController(viewModel: SearchViewModel.Cell?)
    
}

class MainTabBarController: UITabBarController {
    
    var minimizedTopAnchorConstraint: NSLayoutConstraint!
    var maximizedTopAnchorConstraint: NSLayoutConstraint!
    var bottomAnchorConstraint: NSLayoutConstraint!
    let searchVC: SearchViewController = SearchViewController.loadFromStoryboard()
    let trackDetailView: TrackDetailView = TrackDetailView.loadFromNib()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        tabBar.tintColor = #colorLiteral(red: 1, green: 0, blue: 0.3764705882, alpha: 1)
        
        //setupTrackDetailView()
        
        searchVC.tabBarDelegate = self
        
        let library = Library()
        let hostVC = UIHostingController(rootView: library)
        hostVC.tabBarItem.image = #imageLiteral(resourceName: "ios10-apple-music-library-5nav-icon")
        hostVC.tabBarItem.title = "Library"
        
        viewControllers = [
            hostVC,
            generationViewController(rootViewCOntroller: searchVC, image: #imageLiteral(resourceName: "ios10-apple-music-search-5nav-icon-1"), title: "Search")
            //generationViewController(rootViewCOntroller: hostVC, image: #imageLiteral(resourceName: "ios10-apple-music-library-5nav-icon"), title: "Library")
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
    
    
    
    private func setupTrackDetailView() {
        
        
        trackDetailView.translatesAutoresizingMaskIntoConstraints = false
        //trackDetailView.backgroundColor = .green
        trackDetailView.tabBarDelegate = self
        trackDetailView.delegate = searchVC
        view.insertSubview(trackDetailView, belowSubview: tabBar)
        //view.addSubview(trackDetailView)
        
        //maximizedTopAnchorConstraint = trackDetailView.topAnchor.constraint(equalTo: view.topAnchor, constant: -64)
        maximizedTopAnchorConstraint = trackDetailView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height)
        minimizedTopAnchorConstraint = trackDetailView.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -64)
        bottomAnchorConstraint = trackDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: view.frame.height)
        
        bottomAnchorConstraint.isActive = true
        maximizedTopAnchorConstraint.isActive = true

        //trackDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        trackDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        trackDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
        
    }
}

extension MainTabBarController: MainTabBarControllerDelegate {
    
    
    func maximizeTrackDetailController(viewModel: SearchViewModel.Cell?) {
        
        trackDetailView.removeFromSuperview()
        
        trackDetailView.translatesAutoresizingMaskIntoConstraints = false
        //trackDetailView.backgroundColor = .green
        trackDetailView.tabBarDelegate = self
        trackDetailView.delegate = searchVC
        view.insertSubview(trackDetailView, belowSubview: tabBar)
        //view.addSubview(trackDetailView)
        
        
        maximizedTopAnchorConstraint = trackDetailView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0)
        minimizedTopAnchorConstraint = trackDetailView.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -64)
        bottomAnchorConstraint = trackDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        
        bottomAnchorConstraint.isActive = true
        maximizedTopAnchorConstraint.isActive = true

        //trackDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        trackDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        trackDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
//        maximizedTopAnchorConstraint.isActive = true
//        minimizedTopAnchorConstraint.isActive = false
//        maximizedTopAnchorConstraint.constant = 0
//        bottomAnchorConstraint.constant = 0
        
        //trackDetailView.translatesAutoresizingMaskIntoConstraints = true
        
        
        
//        trackDetailView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
//        trackDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
//        self.view.layoutIfNeeded()
        
//        let window = UIApplication.shared.keyWindow
//
//                window?.addSubview(trackDetailView)
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {
                        
                        print("maximize")
                        self.trackDetailView.layoutIfNeeded()
                        self.tabBar.alpha = 0
        },
                       completion: nil)
        
        guard let viewModel = viewModel else { return }
        self.trackDetailView.set(viewModel: viewModel)
    }
    
    
    func minimizeTrackDetailController() {
        
        maximizedTopAnchorConstraint.isActive = false
        bottomAnchorConstraint.constant = view.frame.height
        minimizedTopAnchorConstraint.isActive = true
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {
                        print("minimaze")
                        self.view.layoutIfNeeded()
                        self.tabBar.alpha = 1
        },
                       completion: nil)
        
        print("Print")
    }
}
