//
//  SingUpVC.swift
//  testApp
//
//  Created by Ganna Melnyk on 3/1/18.
//  Copyright © 2018 Ganna Melnyk. All rights reserved.
//

import UIKit

class RCLSignUpVC: UIViewController, AuthServiceDelegate {
    
    @IBOutlet private weak var firstAndLastNameUIImageView: UIImageView!
    @IBOutlet private weak var passwordUIImageView: UIImageView!
    @IBOutlet private weak var passwordConfirmationUIImageView: UIImageView!
    @IBOutlet private weak var phoneUIImageView: UIImageView!
    @IBOutlet private weak var emailUIImageView: UIImageView!
    
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var lastNameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var confirmationPasswordTextField: UITextField!
    @IBOutlet private weak var phoneTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!
    
    @IBOutlet private weak var backButtonOutlet: UIButton!
    @IBOutlet private weak var loginButtonOutlet: UIButton!
    
    @IBAction private func loginButton(_ sender: UIButton) {
        if validator {
            authentificator.createUser(userName: nameTextField.text!, userLastName: lastNameTextField.text!, email: emailTextField.text!, phone: phoneTextField.text!, password: passwordTextField.text!)
        } else {
            alert(text: "please, fill all fields correctly")
        }
    }
    
    @IBAction private func backButton(_ sender: UIButton) {
        if self.navigationController?.popToRootViewController(animated: true) == nil {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    private let customAlert = RCLCustomAlertVC(nibName: "RCLCustomAlertVC", bundle: nil)
    private var formatter = RCLFormatter()
    private var authentificator = RCLAuthentificator()
    private var isAllFieldsValid = true
    
    private var namesImage = #imageLiteral(resourceName: "avatar-1")
    private var passwordImage = #imageLiteral(resourceName: "padlock")
    private var phoneImage = #imageLiteral(resourceName: "phone-call")
    private var emailImage = #imageLiteral(resourceName: "envelope")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authentificator.delegate = self
        self.hideKeyboardOnTap(#selector(self.dismissKeyboard))
        self.view.backgroundColor = UIColor.Backgrounds.GrayDark
        delegates()
        styleViews()
        addTitleLabel(text: "Registration")
    }
    
    private func delegates() {
        nameTextField.delegate = self
        lastNameTextField.delegate = self
        passwordTextField.delegate = self
        confirmationPasswordTextField.delegate = self
        phoneTextField.delegate = self
        emailTextField.delegate = self
    }
    
    private func styleViews() {
        firstAndLastNameUIImageView.setRenderedImage(image: namesImage)
        passwordUIImageView.setRenderedImage(image: passwordImage)
        passwordConfirmationUIImageView.setRenderedImage(image: passwordImage)
        phoneUIImageView.setRenderedImage(image: phoneImage)
        emailUIImageView.setRenderedImage(image: emailImage)
        backButtonOutlet.styleButton()
        loginButtonOutlet.styleButton()
        nameTextField.textType = .generic
        lastNameTextField.textType = .generic
        passwordTextField.textType = .password
        confirmationPasswordTextField.textType = .password
        phoneTextField.textType = .phone
        emailTextField.textType = .emailAddress
        nameTextField.initialStyler()
        lastNameTextField.initialStyler()
        passwordTextField.initialStyler()
        confirmationPasswordTextField.initialStyler()
        phoneTextField.initialStyler()
        emailTextField.initialStyler()
    }
    
    private func styleTextField() {
        nameTextField.styleTextField()
        lastNameTextField.styleTextField()
        passwordTextField.styleTextField()
        confirmationPasswordTextField.styleTextField()
        phoneTextField.styleTextField()
        emailTextField.styleTextField()
    }
    
    private var validator: Bool {
            styleTextField()
            var isAllFieldsValid: Bool = true
            isAllFieldsValid = isAllFieldsValid && nameTextField.valid
            isAllFieldsValid = isAllFieldsValid && lastNameTextField.valid
            isAllFieldsValid = isAllFieldsValid && passwordTextField.valid
            isAllFieldsValid = isAllFieldsValid && confirmationPasswordTextField.valid
            isAllFieldsValid = isAllFieldsValid && phoneTextField.valid
            isAllFieldsValid = isAllFieldsValid && emailTextField.valid
            if confirmationPasswordTextField.text != passwordTextField.text {
                confirmationPasswordTextField.backgroundColor = UIColor.TextFieldBackGrounds.BackgroundForFalse
                isAllFieldsValid = false
            }
            return isAllFieldsValid
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
        performSegue(withIdentifier: "ToApp", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToApp" {
            if let tabBar = segue.destination as? UITabBarController {
                tabBar.selectedIndex = 4
            }
        }
    }
}

extension RCLSignUpVC: UITextFieldDelegate {
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    internal func hideKeyboardOnTap(_ selector: Selector) {
        let tap = UITapGestureRecognizer(target: self, action: selector)
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    internal func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.initialStyler()
        if (textField == phoneTextField) && textField.text?.count == 0 {
            textField.text = "+38("
        }
    }

    internal func textFieldDidEndEditing(_ textField: UITextField) {
        textField.styleTextField()
        if (textField == phoneTextField) && textField.text?.count == 4 {
            textField.text = ""
        }
    }
    
    internal func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        isAllFieldsValid = true
        if (textField == phoneTextField) {
            let decimalString = formatter.decimalFormatter(text: textField.text!, range: range, replacementString: string)
            let length = decimalString.length
            if length == 0 || length > 12 {
                let newLength = (textField.text! as NSString).length + (string as NSString).length - range.length as Int
                return (newLength > 11) ? false : true
            }
            textField.text = formatter.formatString(text: decimalString, length: length)
            textField.styleTextField()
            return false
        } else {
            textField.styleTextField()
            return true
        }
    }
}

