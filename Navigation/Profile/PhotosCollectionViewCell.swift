//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Никита on 22.05.2023.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .clear
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    func addSubview() {
        self.contentView.addSubview(imageView)
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0),
            imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0),
            imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0),
            imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0)
            
        ])
    }
    
//    func setImage(imageName: String) {
//
//        imageView.image = UIImage(named: imageName)
//
//    }
//    func setPhoto(image: UIImage) {
//        imageView.image = image
//    }
    func setPhoto(image: CGImage) {        
        imageView.image = UIImage(cgImage: image)
    }
 
    override init (frame: CGRect) { // Прочитать про метод
        super.init(frame: frame)
        addSubview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


