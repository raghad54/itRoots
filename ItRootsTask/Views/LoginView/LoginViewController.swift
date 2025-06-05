//
//  ViewController.swift
//  ItRootsTask
//
//  Created by Raghad's Mac on 03/06/2025.
//

import UIKit

// MARK: - LoginViewController

class LoginViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userTypeTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var languageToggle: UIButton!
    @IBOutlet weak var arrowImageView: UIImageView!

    private let userTypePicker = UIPickerView()
    private let userTypes = [UserType.admin.rawValue.localized(), UserType.user.rawValue.localized()]
    private let viewModel = LoginViewModel()
    let userDefaultsService = UserDefaultsService()
    


    override func viewDidLoad() {
        super.viewDidLoad()
        setupUserTypePicker()
        setupLanguageToggle()
        localizeUI()
    }

    private func setupUserTypePicker() {
        userTypePicker.delegate = self
        userTypePicker.dataSource = self
        userTypeTextField.inputView = userTypePicker
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissPicker))
        toolbar.setItems([done], animated: false)
        toolbar.isUserInteractionEnabled = true
        userTypeTextField.inputAccessoryView = toolbar
    }

    @objc private func dismissPicker() {
        userTypeTextField.resignFirstResponder()
    }

    private func setupLanguageToggle() {
        languageToggle.setTitle("🌐", for: .normal)
        languageToggle.addTarget(self, action: #selector(toggleLanguage), for: .touchUpInside)
    }

    @objc private func toggleLanguage() {
        LanguageManager.shared.applyLanguageToCurrentScreen()
        localizeUI()
    }
    
    private func localizeUI() {
        let languageCode = LanguageManager.shared.currentLanguage

        titleLabel.text = "TitleLabel".localized()
        usernameTextField.placeholder = "Username".localized()
        passwordTextField.placeholder = "Password".localized()
        userTypeTextField.placeholder = "User".localized()
        signInButton.setTitle("Sign In".localized(), for: .normal)
        signInButton.titleLabel?.font = UIFont(name: "System Bold", size: 22)
        registerButton.titleLabel?.font = UIFont(name: "System Bold", size: 22)
        registerButton.setTitle("Register".localized(), for: .normal)

        let isRTL = LanguageManager.shared.currentLanguage == "ar"
        let alignment: NSTextAlignment = isRTL ? .right : .left
        usernameTextField.textAlignment = alignment
        passwordTextField.textAlignment = alignment
        userTypeTextField.textAlignment = alignment
        
        if LanguageManager.shared.currentLanguage == "ar" {
            arrowImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
        } 
    }

    @IBAction func signInTapped(_ sender: UIButton) {
        viewModel.username = usernameTextField.text ?? ""
        viewModel.password = passwordTextField.text ?? ""
        viewModel.selectedUserType = UserType(rawValue: userTypeTextField.text ?? "") ?? .user
        viewModel.username = usernameTextField.text ?? ""
        viewModel.password = passwordTextField.text ?? ""
        viewModel.selectedUserType = UserType(rawValue: userTypeTextField.text ?? "") ?? .user

        viewModel.login { success in
            if success {
                let user = User(
                    fullName: self.viewModel.fullName,
                    username: self.viewModel.username,
                    password: self.viewModel.password,
                    email: self.viewModel.email,
                    phone: self.viewModel.phone,
                    userType: self.viewModel.selectedUserType
                )

                self.userDefaultsService.saveUser(user)
                UserDefaults.standard.set(true, forKey: "isLoggedIn")

                let storyboard = UIStoryboard(name: "MainTabBarController", bundle: nil)
                let initialVC = storyboard.instantiateViewController(withIdentifier: "MainTabBarController")
                let navController = UINavigationController(rootViewController: initialVC)

                if let window = UIApplication.shared.windows.first {
                    window.rootViewController = navController
                    window.makeKeyAndVisible()
                    UIView.transition(with: window, duration: 0.4, options: .transitionFlipFromRight, animations: nil)
                }

            } else {
                let alert = UIAlertController(title: "Error", message: "Login failed", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true)
            }
        }

    }

    @IBAction func registerTapped(_ sender: UIButton) {
    let storyboard = UIStoryboard(name: "SignUpView", bundle: nil)
    let registerVC = storyboard.instantiateViewController(identifier: "SignUpView")
    self.navigationController?.pushViewController(registerVC, animated: true)
    }
}

// MARK: - UIPickerView Delegate/DataSource
extension LoginViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int { return 1 }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return userTypes.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return userTypes[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        userTypeTextField.text = userTypes[row]
        viewModel.selectedUserType = UserType(rawValue: userTypes[row]) ?? .user
    }
}

