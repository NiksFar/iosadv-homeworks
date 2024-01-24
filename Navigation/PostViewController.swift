//
//  PostViewController.swift
//  Navigation
//
//  Created by Никита on 17.02.2023.
//

import UIKit

final class PostViewController: UIViewController {
    
    var postTitle = "New Post"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = postTitle
        view.backgroundColor = UIColor.cyan
        
        let infoBarButton = UIBarButtonItem(title: "Info", style: .plain, target: self, action: #selector(infoButton))
        navigationItem.rightBarButtonItem = infoBarButton
        
        
        
    }
    
    @objc func infoButton() {
        
        let infoViewController = InfoViewController()
        let navigationController = UINavigationController(rootViewController: infoViewController)
        navigationController.modalPresentationStyle = .pageSheet
        present(navigationController, animated: true, completion: nil)
        
    }
    
}
