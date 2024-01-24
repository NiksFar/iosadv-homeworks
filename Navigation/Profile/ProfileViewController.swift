//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Никита on 18.04.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let profileHeaderView = ProfileHeaderView()
    
    let posts = DataService().posts
    
    let tableView = UITableView(frame: .zero, style: .grouped)
    
    let substrateView = UIView()
    
    var user: User!
    
    let animatedView: UIImageView = {
        
        let imageView = UIImageView()
        //imageView.image = UIImage(named: "Image1")
        imageView.clipsToBounds = true // Чтобы изображение не выходило за пределы круга
        imageView.contentMode = .scaleAspectFill // Ресайз контента под фрейм
        imageView.layer.borderWidth = 3 // Ширина рамки 3пт
        imageView.layer.borderColor = UIColor.white.cgColor // Задаем цвет рамки
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    func startConstraints() -> [NSLayoutConstraint] {
        return [
            animatedView.topAnchor.constraint(equalTo: substrateView.topAnchor, constant: 16),
            animatedView.leadingAnchor.constraint(equalTo: substrateView.leadingAnchor, constant: 16),
            animatedView.widthAnchor.constraint(equalTo: substrateView.widthAnchor, multiplier: 0.3),
            animatedView.heightAnchor.constraint(equalTo: animatedView.widthAnchor, multiplier: 1)]
    }
    
    func finishConstraints() -> [NSLayoutConstraint] {
        return [
            animatedView.leadingAnchor.constraint(equalTo: substrateView.leadingAnchor, constant: 0),
            animatedView.trailingAnchor.constraint(equalTo: substrateView.trailingAnchor, constant: 0),
            animatedView.heightAnchor.constraint(equalTo: substrateView.widthAnchor, multiplier: 1),
            animatedView.centerXAnchor.constraint(equalTo: substrateView.centerXAnchor),
            animatedView.centerYAnchor.constraint(equalTo: substrateView.centerYAnchor)]
    }
    
    
    let closeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitleColor(.black, for: .normal)
        button.setTitle("✕", for: .normal)
        button.alpha = 0
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        return button
    }()
    
    @objc func closeAction() {
        launchReverseAnimation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tabBarController?.tabBar.isHidden = false
        self.view.backgroundColor = .gray
        self.view.addSubview(tableView)
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostCell") // - регистрируем ячейку
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotoCell")
        self.tableView.rowHeight = UITableView.automaticDimension
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setupView() {
        profileHeaderView.backgroundColor = .lightGray
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        prepareView()
        setupProfileHeaderView()
        setupConstraints()
        addTap()
    }
    
    func setupProfileHeaderView() {
        profileHeaderView.carImageView.image = user.avatar
        profileHeaderView.statusLabel.text = user.status
        profileHeaderView.profileLabel.text = user.fullName        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.setupView()
        profileHeaderView.carImageView.layer.cornerRadius = self.view.frame.width * 0.15
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        profileHeaderView.carImageView.layer.cornerRadius = profileHeaderView.carImageView.frame.height / 2
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            
            substrateView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            substrateView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            substrateView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            substrateView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            
            closeButton.trailingAnchor.constraint(equalTo: substrateView.trailingAnchor, constant: -16),
            closeButton.topAnchor.constraint(equalTo: substrateView.topAnchor, constant: 16),
            closeButton.heightAnchor.constraint(equalToConstant: 25),
            closeButton.widthAnchor.constraint(equalToConstant: 25)
        ])
        NSLayoutConstraint.activate(startConstraints())
    }
    
    private func addTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        profileHeaderView.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: profileHeaderView)
        let centerXImage = profileHeaderView.carImageView.layer.position.x
        let centerYImage = profileHeaderView.carImageView.layer.position.y
        let halfSize = profileHeaderView.carImageView.bounds.size.width / 2
        if location.x > (centerXImage - halfSize) && location.x < (centerXImage + halfSize)
            && location.y > (centerYImage - halfSize) && location.y < (centerYImage + halfSize) {
            print("Start Animation", location)
            launchAnimation()
        }
    }
    
    private func launchAnimation() {
        
        let radius = animatedView.frame.height / 2
        animatedView.layer.cornerRadius = radius
        animatedView.alpha = 1
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: .curveLinear
        ) {
            self.substrateView.alpha = 0.5
            self.animatedView.center = self.view.center
            self.animatedView.transform = CGAffineTransform(scaleX: 1/0.3, y: 1/0.3)
            self.animatedView.layer.cornerRadius = 0
        } completion: { finished in
            UIView.animate(withDuration: 0.3) {
                self.closeButton.alpha = 1
            }
            
        }
    }
    
    private func launchReverseAnimation() {
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: .curveLinear
        ) {
            self.animatedView.center = CGPoint(x: 75, y: 118)
            self.animatedView.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.animatedView.layer.cornerRadius = 69
        } completion: { finished in
            self.substrateView.alpha = 0
            self.closeButton.alpha = 0
            self.animatedView.alpha = 0
        }
    }
    
    func prepareView() {
        
        substrateView.backgroundColor = .yellow
        substrateView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(substrateView)
        self.view.addSubview(animatedView)
        self.view.addSubview(closeButton)
        substrateView.alpha = 0
        animatedView.alpha = 0
        animatedView.image = user.avatar
    }
    
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return posts.count
        } else {
            return 1
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostTableViewCell
            let post = posts[indexPath.row]
            cell.setData(post: post)
            return cell
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! PhotosTableViewCell
            cell.backgroundColor = .systemGray3
            cell.setData(data: DataService.array)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let vc = PhotosViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return profileHeaderView
        } else {
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 220
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return self.view.frame.width + 130
        } else {
            let height = ((self.view.frame.width - 48) / 4) + 60
            return height
        }
    }
}
