//
//  AuthService.swift
//  Study
//
//  Created by Лолита Чернышева on 01.10.2021.
//

import Foundation
import VK_ios_sdk

//ключевое слово class используется во избежание утечек памяти - чтобы этот протокол мы могли подписывать только под классы
protocol AuthServiceDelegate: class {
    func authServiceShouldShow(_ viewController: UIViewController)
    func authServiceSignIn()
    func authServiceDidSignInFail()
}

final class AuthService: NSObject, VKSdkDelegate, VKSdkUIDelegate {
    
    private let appId = "7965293"
    //точка входа для использования VKSdk, инициализируется при старте приложения
    private let vkSdk: VKSdk
    
    weak var authServiceDelegate: AuthServiceDelegate?
    
    var token: String? {
        return VKSdk.accessToken().accessToken
    }
    
    override init() {
        vkSdk = VKSdk.initialize(withAppId: appId)
        super.init()
        vkSdk.register(self)
        vkSdk.uiDelegate = self
    }
    
    //пытается извлечь токен из хранилища и проверяет, разрешено ли приложению использовать токен доступа пользователям
    func wakeUpSession() {
        //список доступных прав доступа для токена пользователя
        let scope = ["offline"]
        VKSdk.wakeUpSession(scope) { state, error in
            switch state {
            case .initialized:
                print("initialized")
                VKSdk.authorize(scope)
            case .authorized:
                print("authorized")
            default:
                fatalError(error!.localizedDescription)
            }
        }
    }
    
    //MARK: VKSdkDelegate
    
    //уведомляет о завершении авторизации
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
        authServiceDelegate?.authServiceSignIn()
    }
    
    func vkSdkUserAuthorizationFailed() {
        print(#function)
        authServiceDelegate?.authServiceDidSignInFail()
    }
    
    //MARK: VKSdkUIDelegate
    
    //метод содержит контроллер, который является страницей авторизации ВК
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print(#function)
        authServiceDelegate?.authServiceShouldShow(controller)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }
}
