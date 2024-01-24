//
//  DataService.swift
//  Navigation
//
//  Created by Никита on 21.05.2023.
//

import Foundation
import StorageService

class DataService {
    
     let posts: [Post] = [
        
        Post(author: "NotMe", description: "Name Post", image: "apple_logo", likes: 10, views: 10),
        Post(author: "Me1", description: "Name Post", image: "apple_", likes: 15, views: 25),
        Post(author: "Me2", description: "Name Post", image: "cube", likes: 20, views: 45),
        Post(author: "Me3", description: "Name Post", image: "ball", likes: 30, views: 65),
        Post(author: "Me4", description: "Name Post", image: "happy", likes: 40, views: 85),
    ]
    
    
    static let array: [String] = [
        "apple.jpg",
        "kivi.jpg",
        "granade.jpg",
        "multifruit.jpg",
        "mango.jpg",
        "plum.png",
        "greifruit.jpg",
        "pear.jpeg",
        "lime.jpg",
        "mandarin.jpg",
        "cherry.jpeg",
        "pech.jpg"
    ]
}


