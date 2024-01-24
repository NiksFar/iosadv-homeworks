

import UIKit

class User {
    
    var login: String
    var fullName: String
    var avatar: UIImage
    var status: String
    
    init(login: String, fullName: String, avatar: UIImage, status: String) {
        self.login = login
        self.fullName = fullName
        self.avatar = avatar
        self.status = status
    } 
}

protocol UserService {
    func getUser(login: String) -> User?
}

class CurrentUserService: UserService {
    
    let currentUser = User(login: "111", fullName: "Nikita", avatar: UIImage(named: "Image1")!, status: "Going for a ride")
    
    func getUser(login: String) -> User? {
        if login == self.currentUser.login {
            return self.currentUser
        } else {
            return nil 
        }
    }

}

class TestUserService: UserService {
    
    let currentUser = User(login: "2222", fullName: "Test", avatar: UIImage(named: "plum")!, status: "Going for a test")
    
    func getUser(login: String) -> User? {
        if login == self.currentUser.login {
            return self.currentUser
        } else {
            return nil
        }
    }

}
