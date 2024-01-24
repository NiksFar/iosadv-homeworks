//
//  Checker.swift
//  Navigation
//
//  Created by Никита on 11.07.2023.
//

import Foundation

protocol LoginViewControllerDelegate {
    func check(login: String, password: String) -> Bool
}

class Checker: LoginViewControllerDelegate {
    static let share = Checker()
    
    private let login: String = "111"
    private let password: String = "111"
    
    func check(login: String, password: String) -> Bool {
        if login == self.login, password == self.password {
            return true
        } else {
            return false
        }
    }
    
}

struct LoginInspector: LoginViewControllerDelegate {
    func check(login: String, password: String) -> Bool {
        Checker.share.check(login: login, password: password)
    }
    
}

protocol LoginFactory {
    func makeLoginInspector() -> LoginInspector
}

struct MyLoginFactory: LoginFactory {
    func makeLoginInspector() -> LoginInspector {
        return LoginInspector()
    }
}
