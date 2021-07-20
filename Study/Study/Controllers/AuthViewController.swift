//
//  AuthViewController.swift
//  Study
//
//  Created by Lola Chernysheva on 19.07.2021.
//
/*MARK: TODO
- заменить размеры констрейнтов
- вынести цвета в отдельный класс
- добавть отступы слева у плейхолдеров
*/

import SnapKit
import UIKit

class AuthViewController: UIViewController {
	
	private let activityIndicatior = UIActivityIndicatorView()
	private let loginTextField = UITextField()
	private let scrollView = UIScrollView()
	private let signInButton = UIButton(type: .system)
	private let signUpButton = UIButton(type: .system)
	private let passwordTextField = UITextField()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		initialize()
		registerForKeyboardNotifications()
		//скрытие клавиатуры по нажатию на контейнер
		let hideAction = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
		view.addGestureRecognizer(hideAction)
    }
	
	deinit {
		removeKeyboardNotifications()
	}
	
	private func initialize() {
		view.backgroundColor = UIColor(red: 255/255,
									   green: 254/255,
									   blue: 254/255,
									   alpha: 1)
		view.addSubview(scrollView)
		scrollView.snp.makeConstraints { maker in
			maker.top.equalToSuperview()
			maker.trailing.equalToSuperview()
			maker.leading.equalToSuperview()
			maker.bottom.equalToSuperview()
		}
		
		let logoImage = UIImage(named: "VK")
		let logoImageView = UIImageView(image: logoImage)
		scrollView.addSubview(logoImageView)
		logoImageView.snp.makeConstraints { maker in
			maker.centerX.equalToSuperview()
			maker.height.equalTo(70)
			maker.width.equalTo(70)
			maker.top.equalToSuperview().inset(100)
		}
		
		loginTextField.backgroundColor = UIColor(red: 241/255,
												 green: 242/255,
												 blue: 244/255,
												 alpha: 1)
		loginTextField.placeholder = "Email или телефон"
		loginTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
		loginTextField.font = UIFont.systemFont(ofSize: 16)
		loginTextField.layer.cornerRadius = 5.0
		loginTextField.textColor = UIColor.lightGray
		scrollView.addSubview(loginTextField)
		loginTextField.snp.makeConstraints { maker in
			maker.centerX.equalToSuperview()
			maker.leading.trailing.equalToSuperview().inset(20)
			maker.height.equalTo(30)
			maker.top.equalTo(logoImageView).inset(150)
		}
		
		passwordTextField.backgroundColor = UIColor(red: 241/255,
													green: 242/255,
													blue: 244/255,
													alpha: 1)
		passwordTextField.placeholder = "Пароль"
		passwordTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
		passwordTextField.font = UIFont.systemFont(ofSize: 16)
		passwordTextField.layer.cornerRadius = 5.0
		passwordTextField.textColor = UIColor.lightGray
		scrollView.addSubview(passwordTextField)
		passwordTextField.snp.makeConstraints { maker in
			maker.centerX.equalToSuperview()
			maker.leading.trailing.equalToSuperview().inset(20)
			maker.height.equalTo(30)
			maker.top.equalTo(loginTextField).inset(50)
		}
		
		signInButton.backgroundColor = UIColor(red: 39/255,
											   green: 135/255,
											   blue: 245/255,
											   alpha: 1)
		signInButton.setTitle("Войти", for: .normal)
		signInButton.tintColor = .white
		signInButton.layer.cornerRadius = 5.0
		scrollView.addSubview(signInButton)
		signInButton.snp.makeConstraints { maker in
			maker.centerX.equalToSuperview()
			maker.leading.trailing.equalToSuperview().inset(20)
			maker.height.equalTo(30)
			maker.top.equalTo(passwordTextField).inset(50)
		}
		
		signUpButton.setTitle("Зарегистрироваться", for: .normal)
		signUpButton.tintColor = UIColor(red: 39/255,
										 green: 135/255,
										 blue: 245/255,
										 alpha: 1)
		scrollView.addSubview(signUpButton)
		signUpButton.snp.makeConstraints { maker in
			maker.centerX.equalToSuperview()
			maker.leading.trailing.equalToSuperview().inset(20)
			maker.height.equalTo(30)
			maker.top.equalTo(signInButton).inset(50)
			maker.bottom.equalToSuperview()
		}

		scrollView.addSubview(activityIndicatior)
		activityIndicatior.isHidden = true
		activityIndicatior.snp.makeConstraints { maker in
			maker.centerX.equalToSuperview()
			maker.centerY.equalToSuperview()
		}
		signInButton.addTarget(self,
							   action: #selector(buttonPressed),
							   for:.touchUpInside)
		signInButton.addTarget(self,
							   action: #selector(goToSecondViewController),
							   for:.touchUpInside)
		signUpButton.addTarget(self,
							   action: #selector(goToSecondViewController),
							   for:.touchUpInside)
		
	}
	
	//подписка под уведомления об изменении состояния клавиатуры
	private func registerForKeyboardNotifications() {
		NotificationCenter.default.addObserver(self,
											   selector: #selector(kbWillShow),
											   name: UIResponder.keyboardWillShowNotification ,
											   object: nil)
		NotificationCenter.default.addObserver(self,
											   selector: #selector(kbWillHide),
											   name: UIResponder.keyboardWillHideNotification ,
											   object: nil)
	}
	
	//отписка от уведомлений об изменении состояния клавиатуры
	private func removeKeyboardNotifications() {
		NotificationCenter.default.removeObserver(self,
												  name: UIResponder.keyboardWillShowNotification ,
												  object: nil)
		NotificationCenter.default.removeObserver(self,
												  name: UIResponder.keyboardWillHideNotification ,
												  object: nil)
	}
	
	//логика перехода между экранами
	@objc private func goToSecondViewController(sender: UIButton) {
		var secondViewController = UIViewController()
		if (sender.isEqual(signInButton)){
			secondViewController = TabbarController()
		} else if (sender.isEqual(signUpButton)) {
			 secondViewController = SignUpViewController()
		}
		self.navigationController?.pushViewController(secondViewController, animated: true)
	}

	//при появлении клавиатуры
	@objc private func kbWillShow(_ notification: NSNotification) {
		//получение размеров клавиатуры
		let userInfo = notification.userInfo
		let kbFrameSize = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
		scrollView.contentOffset = CGPoint(x: 0, y: kbFrameSize.height)
	}
	
	//при скрытии клавиатуры
	@objc private func kbWillHide() {
		scrollView.contentOffset = CGPoint.zero
	}
	
	//обработка события нажатия на кнопку
	@objc private func buttonPressed() {
		signInButton.backgroundColor = UIColor(red: 181/255,
											   green: 206/255,
											   blue: 234/255,
											   alpha: 1)
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
