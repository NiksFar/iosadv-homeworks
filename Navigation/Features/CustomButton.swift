//
//  CustomButton.swift
//  Navigation
//
//  Created by Никита on 30.08.2023.
//

import Foundation
import UIKit

protocol ButtonDelegate: AnyObject {
    func fetchButtonTapped()
}

class CustomButton: UIButton {
    
    var callBack: (() -> Void )? //Added callBack
    weak var delegate: ButtonDelegate?
    
    init(title: String, titleColor: UIColor, backgroundColor: UIColor) {
        
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.backgroundColor = backgroundColor
        self.setTitleColor(titleColor, for: .normal)
        self.addTarget(self, action: #selector(tapAction), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    @objc func tapAction() {
        //print("Ho Ho")
        delegate?.fetchButtonTapped()
        callBack?() //Add callBack
    }
}
