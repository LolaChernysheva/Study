//
//  AuthViewController.swift
//  Study
//
//  Created by Lola Chernysheva on 19.07.2021.
//
/*MARK: TODO
- заменить размеры констрейнтов
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
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		signInButton.backgroundColor = ButtonAppearance.buttonIsActive
		signInButton.isEnabled = true
		activityIndicatior.isHidden = true
		loginTextField.isEnabled = true
		passwordTextField.isEnabled = true
		view.alpha = 1
		activityIndicatior.stopAnimating()
	}
	
	deinit {
		removeKeyboardNotifications()
	}
	
	private func initialize() {
		view.backgroundColor = AppAppearence.backgroundColor
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
		
		loginTextField.backgroundColor = AppAppearence.textFieldBackgroundColor
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
		
		passwordTextField.backgroundColor = AppAppearence.textFieldBackgroundColor
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
		
		signInButton.backgroundColor = ButtonAppearance.buttonIsActive
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
		signUpButton.tintColor = ButtonAppearance.buttonIsActive
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
		let checkResult = checkUserData()
		//если нажата кнопка авторизации, и данные пользователя верны
		if (sender.isEqual(signInButton)) && checkResult {
			secondViewController = TabbarController()
			self.navigationController?.pushViewController(secondViewController, animated: true)
		//если данные пользователя не верны, выводим ошибку
		} else if (sender.isEqual(signInButton)) && (!checkResult) {
				showLoginErrorAlert()
		}
		//если нажата кнопка регистрации
		else if (sender.isEqual(signUpButton)) {
			 secondViewController = SignUpViewController()
			self.navigationController?.pushViewController(secondViewController, animated: true)
		}
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
		signInButton.backgroundColor = ButtonAppearance.bittonIsInactive
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
	
	//проверка корректоности логина и пароля
	private func checkUserData() -> Bool {
		guard
			let login = loginTextField.text,
			let password = passwordTextField.text else { return false }
		if login == "User" && password == "123" {
			return true
		} else {
			return false
		}
	}
	
	//обработка ошибки ввода пароля
	private func showLoginErrorAlert() {
		//создание контрроллера
		let alert = UIAlertController(title: "Ошибка", message: "Введены неверные данные пользователя", preferredStyle: .alert)
		//создание кнопки для алерта
		let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
		//добавление кнопки на алерт
		alert.addAction(alertAction)
		//показываем UIAlertController
		present(alert, animated: true, completion: nil)
	}
}
