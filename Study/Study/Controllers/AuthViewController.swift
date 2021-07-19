//
//  AuthViewController.swift
//  Study
//
//  Created by admin on 19.07.2021.
//
/*MARK: TODO
- добавить скролл вью
- добавить клавиатуру
- добавить поднятие интерфейся на высоту клавиатуры
- заменить размеры констрейнтов
*/

import SnapKit
import UIKit

class AuthViewController: UIViewController {
	
	private let signInButton = UIButton(type: .system)
	private let activityIndicatior = UIActivityIndicatorView()
	private let loginTextField = UITextField()
	private let passwordTextField = UITextField()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		//скрытие клавиатуры по нажатию на контейнер
		let hideAction = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
		view.addGestureRecognizer(hideAction)
		initialize()
    }
	
	private func initialize() {
		view.backgroundColor = UIColor(red: 255/255, green: 254/255, blue: 254/255, alpha: 1)
		
		let logoImage = UIImage(named: "VK")
		let logoImageView = UIImageView(image: logoImage)
		view.addSubview(logoImageView)
		logoImageView.snp.makeConstraints { maker in
			maker.centerX.equalToSuperview()
			maker.height.equalTo(70)
			maker.width.equalTo(70)
			maker.top.equalToSuperview().inset(100)
		}
		
		loginTextField.backgroundColor = UIColor(red: 241/255, green: 242/255, blue: 244/255, alpha: 1)
		loginTextField.text = "Email или телефон"
		loginTextField.font = UIFont.systemFont(ofSize: 16)
		loginTextField.layer.cornerRadius = 5.0
		loginTextField.textColor = UIColor.lightGray
		view.addSubview(loginTextField)
		loginTextField.snp.makeConstraints { maker in
			maker.centerX.equalToSuperview()
			maker.leading.trailing.equalToSuperview().inset(20)
			maker.height.equalTo(30)
			maker.top.equalTo(logoImageView).inset(150)
		}
		
		passwordTextField.backgroundColor = UIColor(red: 241/255, green: 242/255, blue: 244/255, alpha: 1)
		passwordTextField.text = "Пароль"
		passwordTextField.font = UIFont.systemFont(ofSize: 16)
		passwordTextField.layer.cornerRadius = 5.0
		passwordTextField.textColor = UIColor.lightGray
		view.addSubview(passwordTextField)
		passwordTextField.snp.makeConstraints { maker in
			maker.centerX.equalToSuperview()
			maker.leading.trailing.equalToSuperview().inset(20)
			maker.height.equalTo(30)
			maker.top.equalTo(loginTextField).inset(50)
		}
		
		signInButton.backgroundColor = UIColor(red: 39/255, green: 135/255, blue: 245/255, alpha: 1)
		signInButton.setTitle("Войти", for: .normal)
		signInButton.tintColor = .white
		signInButton.layer.cornerRadius = 5.0
		view.addSubview(signInButton)
		signInButton.snp.makeConstraints { maker in
			maker.centerX.equalToSuperview()
			maker.leading.trailing.equalToSuperview().inset(20)
			maker.height.equalTo(30)
			maker.top.equalTo(passwordTextField).inset(50)
		}
		
		view.addSubview(activityIndicatior)
		activityIndicatior.isHidden = true
		activityIndicatior.snp.makeConstraints { maker in
			maker.centerX.equalToSuperview()
			maker.centerY.equalToSuperview()
		}
		signInButton.addTarget(self, action: #selector(buttonPressed), for:.touchUpInside)
	}
	
	@objc private func buttonPressed() {
		signInButton.backgroundColor = UIColor(red: 181/255, green: 206/255, blue: 234/255, alpha: 1)
		signInButton.isEnabled = false
		activityIndicatior.isHidden = false
		loginTextField.isEnabled = false
		passwordTextField.isEnabled = false
		view.alpha = 0.9
		activityIndicatior.startAnimating()
	}
	
	//скрытие клавиатуры по нажатию на контейнер
	@objc private func hideKeyboard() {
		view.endEditing(true)
	}
}
