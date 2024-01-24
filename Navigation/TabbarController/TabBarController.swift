//
//  TabbarController.swift
//  Navigation
//
//  Created by Никита on 17.02.2023.
//

import UIKit

class TabBarController: UITabBarController {
    
    var feedTabNavigationController: UINavigationController!
    var profileTabNavigationController: UINavigationController!
    //var postTabNavigationController: UINavigationController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        
        feedTabNavigationController = UINavigationController.init(rootViewController: FeedViewController())
        let loginInspector = MyLoginFactory().makeLoginInspector()
        profileTabNavigationController = UINavigationController(rootViewController: LogInViewController(service: loginInspector))
       // postTabNavigationController = UINavigationController(rootViewController: PostViewController())
        
        self.viewControllers = [feedTabNavigationController, profileTabNavigationController]
        
        let item1 = UITabBarItem(title: "Feed", image: UIImage(systemName: "newspaper.circle"), tag: 0)
        let item2 = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle"), tag: 1)
        //let item3 = UITabBarItem(title: "Post", image: UIImage(systemName: "pencil.circle"), tag: 2)
        
        feedTabNavigationController.tabBarItem = item1
        profileTabNavigationController.tabBarItem = item2
        //postTabNavigationController.tabBarItem = item3
        
        UITabBar.appearance().backgroundColor = .systemOrange
        
    }
}
