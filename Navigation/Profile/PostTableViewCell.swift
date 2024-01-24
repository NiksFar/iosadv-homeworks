//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Никита on 18.05.2023.
//

import UIKit
import StorageService

class PostTableViewCell: UITableViewCell {

    let authorLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .systemGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let likeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let viewsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let postImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .black
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    func setData(post: Post) {
        authorLabel.text = post.author
        descriptionLabel.text = post.description
        let likesString = NSLocalizedString("xxx", comment: "")
        let resultLikesString = String.localizedStringWithFormat(likesString, post.likes)
        likeLabel.text = resultLikesString
        //likeLabel.text = "Likes:\(post.likes)"
        let viewsString = NSLocalizedString("viewsString", comment: "")
        let resultViewsString = String.localizedStringWithFormat(viewsString, post.views)
        viewsLabel.text = resultViewsString
        //viewsLabel.text = "Views:\(post.views)"
        postImage.image = UIImage(named: post.image)
    }
    
    func addSubview() {
        self.addSubview(authorLabel)
        self.addSubview(descriptionLabel)
        self.addSubview(likeLabel)
        self.addSubview(viewsLabel)
        self.addSubview(postImage)
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            authorLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            authorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            authorLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 16),
            
            postImage.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 12),
            postImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            postImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            postImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1),
            postImage.heightAnchor.constraint(equalTo: postImage.widthAnchor, multiplier: 1),
            
            descriptionLabel.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 16),
            
            likeLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            likeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            
            viewsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            viewsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
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
