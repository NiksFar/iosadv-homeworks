//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Никита on 22.05.2023.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {

    let photoLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = .black
        label.text = "Photos"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("➔", for: .normal)
        return button
    }()    
    
    let image1: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .clear
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.layer.cornerRadius = 6
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let image2: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .clear
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.layer.cornerRadius = 6
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let image3: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .clear
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.layer.cornerRadius = 6
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let image4: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .clear
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.layer.cornerRadius = 6
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fill
        stackView.layer.masksToBounds = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    func setData(data: [String]) {
        image1.image = UIImage(named: data[0])
        image2.image = UIImage(named: data[1])
        image3.image = UIImage(named: data[2])
        image4.image = UIImage(named: data[3])
    }
    
    func addSubview() {
        self.addSubview(photoLabel)
        self.addSubview(button)
        self.addSubview(stackView)
        stackView.addArrangedSubview(image1)
        stackView.addArrangedSubview(image2)
        stackView.addArrangedSubview(image3)
        stackView.addArrangedSubview(image4)
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            photoLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            photoLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            
            button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            button.centerYAnchor.constraint(equalTo: photoLabel.centerYAnchor, constant: 0),
            
            stackView.topAnchor.constraint(equalTo: photoLabel.bottomAnchor, constant: 12),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),
            
            image1.widthAnchor.constraint(equalToConstant: (self.frame.width - 48) / 4),
            image1.heightAnchor.constraint(equalTo: image1.widthAnchor, multiplier: 1),
            
            image2.widthAnchor.constraint(equalTo: image1.widthAnchor, multiplier: 1),
            image2.heightAnchor.constraint(equalTo: image1.widthAnchor, multiplier: 1),
            
            image3.widthAnchor.constraint(equalTo: image1.widthAnchor, multiplier: 1),
            image3.heightAnchor.constraint(equalTo: image1.widthAnchor, multiplier: 1),
            
            image4.widthAnchor.constraint(equalTo: image1.widthAnchor, multiplier: 1),
            image4.heightAnchor.constraint(equalTo: image1.widthAnchor, multiplier: 1)
            
        ])
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
