//
//  SignUpViewController.swift
//  ItRootsTask
//
//  Created by Raghad's Mac on 03/06/2025.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var signUpLabel: UILabel!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!

    private let viewModel = SignUpViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTargets()
        localizeUI()
    }

    private func setupTargets() {
        [fullNameTextField, usernameTextField, passwordTextField, emailTextField, phoneTextField].forEach {
            $0?.addTarget(self, action: #selector(textFieldChanged(_:)), for: .editingChanged)
            $0?.delegate = self
        }
    }

    @objc private func textFieldChanged(_ textField: UITextField) {
        viewModel.fullName = fullNameTextField.text ?? ""
        viewModel.username = usernameTextField.text ?? ""
        viewModel.password = passwordTextField.text ?? ""
        viewModel.email = emailTextField.text ?? ""
        viewModel.phone = phoneTextField.text ?? ""

        registerButton.isEnabled = viewModel.validate()
    }
    
    private func localizeUI() {
        signUpLabel.text = "Register".localized()
        fullNameTextField.placeholder = "Full Name".localized()
        usernameTextField.placeholder = "Username".localized()
        passwordTextField.placeholder = "Password".localized()
        emailTextField.placeholder = "Email".localized()
        phoneTextField.placeholder = "Phone".localized()
        registerButton.titleLabel?.font = UIFont(name: "System Bold", size: 22)
        registerButton.setTitle("Register".localized(), for: .normal)

        let isRTL = LanguageManager.shared.currentLanguage == "ar"
        let alignment: NSTextAlignment = isRTL ? .right : .left
        usernameTextField.textAlignment = alignment
        passwordTextField.textAlignment = alignment
        emailTextField.textAlignment = alignment
        phoneTextField.textAlignment = alignment
        fullNameTextField.textAlignment = alignment
    }

    @IBAction func registerTapped(_ sender: UIButton) {
        if viewModel.validate() {
            let newUser = User(
                fullName: viewModel.fullName,
                username: viewModel.username,
                password: viewModel.password,
                email: viewModel.email,
                phone: viewModel.phone,
                userType: .user
            )
            UserDefaultsService().saveUser(newUser)
            UserDefaults.standard.set(viewModel.username, forKey: "loggedInUsername")
            UserDefaults.standard.set(viewModel.userType.rawValue, forKey: "loggedInUserType")
            
            let initialVC: UIViewController
            let storyboard = UIStoryboard(name: "MainTabBarController", bundle: nil)
            initialVC = storyboard.instantiateViewController(identifier: "MainTabBarController")
            let navController = UINavigationController(rootViewController: initialVC)
            self.view.window?.rootViewController = navController
            
        } else {
            showAlert("Please fill all fields correctly.")
        }
    }


    private func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
