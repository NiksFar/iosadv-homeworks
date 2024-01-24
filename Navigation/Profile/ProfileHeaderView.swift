import UIKit

class ProfileHeaderView: UIView {
    
    
    let carImageView: UIImageView = {
        
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "Image1")
        imageView.clipsToBounds = true // Чтобы изображение не выходило за пределы круга
        imageView.contentMode = .scaleAspectFill // Ресайз контента под фрейм
        imageView.layer.borderWidth = 3 // Ширина рамки 3пт
        imageView.layer.borderColor = UIColor.white.cgColor // Задаем цвет рамки
        //imageView.layer.cornerRadius = 75 // Height/2
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var textField: UITextField = {
        
        var field = UITextField()
        
        field.layer.cornerRadius = 12
        field.backgroundColor = .white
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.black.cgColor
        
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: field.frame.height)) // Добавляем маленькую вьюшку(белый прямоугольник) - для отступа от края textField
        field.leftViewMode = .always
        field.placeholder = "Set text"
        field.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
        
    }()
    
    @objc func statusTextChanged(_ textField: UITextField) {
        statusText = textField.text
    }
    
    
    private var statusText: String?
    
    
    lazy var statusButton: UIButton = {
        
        let button = UIButton()
        
        button.backgroundColor = .blue
        button.setTitle("Set status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 16 // Поправить до нужного радиуса
        button.layer.masksToBounds = false // Обязательно, если хотим видеть тень
        
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // Обработка нажатия кнопки
    @objc func buttonPressed() {
        statusLabel.text = statusText
    }

    
    let profileLabel: UILabel = {
        
        let label = UILabel()
        
        label.text = "Hipster Car"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let statusLabel: UILabel = {
        
        let secondaryLabel = UILabel()
        
        secondaryLabel.text = "Waiting for a ride"
        secondaryLabel.font = .systemFont(ofSize: 14, weight: .regular)
        secondaryLabel.textColor = .gray
        secondaryLabel.translatesAutoresizingMaskIntoConstraints = false
        return secondaryLabel
    }()
    
    override init (frame: CGRect) { // Прочитать про метод
        super.init(frame: frame)
        self.setupAddedSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAddedSubviews() {
        
        self.addSubview(profileLabel)
        self.addSubview(statusLabel)
        self.addSubview(textField)
        self.addSubview(statusButton)
        self.addSubview(carImageView)
        self.setupElementConstraints()
        
    }
    
    private func setupElementConstraints() {
        
        NSLayoutConstraint.activate([
        
            // Подгоняем картинку
            carImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            carImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            //carImageView.heightAnchor.constraint(equalToConstant: 150),
            //carImageView.widthAnchor.constraint(equalToConstant: 150),
            
            carImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3),
            carImageView.heightAnchor.constraint(equalTo: carImageView.widthAnchor, multiplier: 1),
            
            // Подгоняем profileLabel
            profileLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 27),
            profileLabel.leadingAnchor.constraint(equalTo: carImageView.trailingAnchor, constant: 15),
            profileLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15),
            
            // Подгоняем statusLabel
            statusLabel.topAnchor.constraint(equalTo: profileLabel.bottomAnchor, constant: 20),
            statusLabel.leadingAnchor.constraint(equalTo: carImageView.trailingAnchor, constant: 15),
            statusLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15),
            
            // Подгоняем кнопку
            statusButton.topAnchor.constraint(equalTo: carImageView.bottomAnchor, constant: 16),
            statusButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            statusButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            // Подгоняем textField
            textField.bottomAnchor.constraint(equalTo: statusButton.topAnchor, constant: -15),
            textField.leadingAnchor.constraint(equalTo: carImageView.trailingAnchor, constant: 15),
            textField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15),
            textField.heightAnchor.constraint(equalToConstant: 40)
            
        ])
        
    }
    
}
