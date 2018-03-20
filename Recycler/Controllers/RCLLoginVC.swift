//
//  LoginVC.swift
//  testApp
//
//  Created by Ganna Melnyk on 3/1/18.
//  Copyright © 2018 Ganna Melnyk. All rights reserved.
//

import UIKit

class RCLLoginVC: UIViewController, AuthServiceDelegate {
    
    @IBOutlet private weak var logoImage: UIImageView!
    @IBOutlet private weak var loginTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var signInOutlet: UIButton!
    @IBOutlet private weak var signUpOutlet: UIButton!
    
    @IBAction private func signInButton(_ sender: Any) {
        guard let login = loginTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        authentificator.login(login: login, password: password)
    }
    
    @IBAction private func signUpButton(_ sender: Any) {
        performSegue(withIdentifier: "ToSignUp", sender: self)
    }
    
    private var authentificator = RCLAuthentificator()
    private var image = #imageLiteral(resourceName: "logo")
    private let customAlert = RCLCustomAlertVC(nibName: "RCLCustomAlertVC", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.Backgrounds.GrayDark
        delegates()
        styles()
        self.hideKeyboardOnTap(#selector(self.dismissKeyboard))
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        authentificator.isAUserActive()
    }
    
    private func delegates() {
        authentificator.delegate = self
        loginTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func styles() {
        signInOutlet.styleButton()
        signUpOutlet.styleButton()
        loginTextField.textType = .emailAddress
        passwordTextField.textType = .password
        loginTextField.initialStyler()
        passwordTextField.initialStyler()
        logoImage.image = image
    }
    
    internal func alert(text: String) {
        customAlert.modalPresentationStyle = .overCurrentContext
        present(customAlert, animated: true, completion: nil)
        customAlert.errorTextLabel?.text = text
    }
    
    internal func transitionToCust() {
        performSegue(withIdentifier: "ToApp", sender: self)
    }
    
    internal func transitionToEmpl() {
        performSegue(withIdentifier: "ToEmp", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToApp" {
            if let tabBar = segue.destination as? UITabBarController {
                tabBar.selectedIndex = 2
            }
        }
    }
}

extension RCLLoginVC: UITextFieldDelegate {
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    internal func hideKeyboardOnTap(_ selector: Selector) {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: selector)
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

