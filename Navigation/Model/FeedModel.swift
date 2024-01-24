//
//  FeedModel.swift
//  Navigation
//
//  Created by Никита on 30.08.2023.
//

import Foundation

class FeedModel  {
    
   private let secretWord = "1111"
   //var typedWord = ""
    
    func checkSecretWord(word: String) -> String {
        if word == secretWord {
            return "Верно"
        }  else if word == "" {
            return "Пустое поле"
        } else {
            return "Не верно"
        }
    }

    
}

