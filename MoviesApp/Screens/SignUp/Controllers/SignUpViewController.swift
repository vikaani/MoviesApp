//
//  SignUpViewController.swift
//  MoviesApp
//
//  Created by 1 on 18.11.2023.
//

import UIKit

class SignUpViewController: UIViewController  {
    @IBOutlet var errorTextLabel: UILabel!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!

    var onCompleteSignUp: (() -> Void)?
    
    private let signUpAutenticator: FireBaseSignUpAuthenticator
    
    init(signUpAutenticator: FireBaseSignUpAuthenticator) {
        self.signUpAutenticator = signUpAutenticator
        super.init(nibName: SignUpViewController.className, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "SIGN UP"
        passwordTextField.delegate = self
        emailTextField.delegate = self
    }
    
    @IBAction private func didTapSignUpButton() {
        guard let email = emailTextField.text,
              let password = passwordTextField.text else {
            return
        }
        
        signUpAutenticator.createUser(email: email, password: password) { [weak self] result in
            switch result {
            case .success(_):
                self?.onCompleteSignUp?()
            case .failure(let failure):
                
                switch failure {
                case .userIsAlreadyExist:
                    self?.showErrorTextLabel(with: "This user is already exist.")
                case .inccorrectEmail:
                    self?.showErrorTextLabel(with: "Incorrect email address. Please try again.")
                case .incorrectData:
                    self?.showErrorTextLabel(with: "Check login and password again.")
                }
                print(failure.localizedDescription)
            }
        }
    }
   
    private func showErrorTextLabel(with text: String) {
        errorTextLabel.text = text
        errorTextLabel.isHidden = false
    }
}


extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        passwordTextField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.highiglight(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.highiglight(false)
    }
}
