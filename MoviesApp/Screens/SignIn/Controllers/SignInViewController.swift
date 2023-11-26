//
//  LoginViewController.swift
//  MoviesApp
//
//  Created by 1 on 18.11.2023.
//

import UIKit

class SignInViewController: UIViewController {
    @IBOutlet var errorTextLabel: UILabel!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    var onCompleteSignIn: (() -> Void)?
    var onTapSignUpButton: (() -> Void)?
    
    private let signInAutenticator: FireBaseSignInAuthenticator
    
    init(signInAutenticator: FireBaseSignInAuthenticator) {
        self.signInAutenticator = signInAutenticator
        super.init(nibName: SignInViewController.className, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "LOG IN"
        
        passwordTextField.delegate = self
        emailTextField.delegate = self
    }
    
    @IBAction func didTapLoginButton() {
        guard let email = emailTextField.text,
              let password = passwordTextField.text
        else { return }
        
        signInAutenticator.signIn(email: email, password: password) { [weak self] result in
            switch result {
            case .success(_):
                self?.onCompleteSignIn?()
            case .failure(let failure):
                
                switch failure {
                case .badlyEmailFormatted:
                    self?.showErrorTextLabel(with: "The email address is badly formatted.")
                case .userDoesNotExist:
                    self?.showErrorTextLabel(with: "User does not exist.")
                case .incorrectData:
                    self?.showErrorTextLabel(with: "Check login and password again.")
                }
            }
        }
    }
    
    @IBAction private func didTapSignUpButton() {
        onTapSignUpButton?()
    }
    
    private func showErrorTextLabel(with text: String) {
        errorTextLabel.text = text
        errorTextLabel.isHidden = false
    }
}

extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.highiglight(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.highiglight(false)
    }
}

