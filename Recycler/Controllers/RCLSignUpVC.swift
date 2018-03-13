//
//  SingUpVC.swift
//  testApp
//
//  Created by Ganna Melnyk on 3/1/18.
//  Copyright © 2018 Ganna Melnyk. All rights reserved.
//

import UIKit

class RCLSignUpVC: UIViewController {

    @IBOutlet var logosForAction: [UIImageView]!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmationPasswordTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var backButtonOutlet: UIButton!
    @IBOutlet weak var loginButtonOutlet: UIButton!
    
    
    var formatter = RCLFormatter()
    var isAllFieldsValid = true
    
    var images = [#imageLiteral(resourceName: "avatar"), #imageLiteral(resourceName: "padlock"), #imageLiteral(resourceName: "phone-call"), #imageLiteral(resourceName: "envelope")]
    var styler = RCLStyler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardOnTap(#selector(self.dismissKeyboard))
        self.view.backgroundColor = UIColor.Backgrounds.GrayDark
        delegates()
        styleViews()
    }
    
    func delegates() {
        nameTextField.delegate = self
        lastNameTextField.delegate = self
        passwordTextField.delegate = self
        confirmationPasswordTextField.delegate = self
        phoneTextField.delegate = self
        emailTextField.delegate = self
    }
    
    func styleViews() {
        styler.renderImage(view: logosForAction[0], image: images[0])
        styler.renderImage(view: logosForAction[1], image: images[1])
        styler.renderImage(view: logosForAction[2], image: images[1])
        styler.renderImage(view: logosForAction[3], image: images[2])
        styler.renderImage(view: logosForAction[4], image: images[3])
        styler.styleButton(button: backButtonOutlet)
        styler.styleButton(button: loginButtonOutlet)
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
    
    func styleTextField() {
        nameTextField.styleTextField()
        lastNameTextField.styleTextField()
        passwordTextField.styleTextField()
        confirmationPasswordTextField.styleTextField()
        phoneTextField.styleTextField()
        emailTextField.styleTextField()
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        if validator {
            print("login successfull")
            let authent = RCLAuthentificator()
            authent.createUser(userName: nameTextField.text!, userLastName: lastNameTextField.text!, email: emailTextField.text!, phone: phoneTextField.text!, password: passwordTextField.text!)
            performSegue(withIdentifier: "ToApp", sender: self)
        } else {
            print("login unsuccessfull")
        }
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        print("back tapped")
//        if let nav = self.navigationController {
//            nav.popToRootViewController(animated: true)
//        } else {
//            self.dismiss(animated: true, completion: nil)
//        }
        
        ///
        
        if self.navigationController?.popToRootViewController(animated: true) == nil {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    var validator: Bool {
        get {
            styleTextField()
            var a: Bool = true
            a = a && nameTextField.valid
            a = a && lastNameTextField.valid
            a = a && passwordTextField.valid
            a = a && confirmationPasswordTextField.valid
            a = a && phoneTextField.valid
            a = a && emailTextField.valid
            if confirmationPasswordTextField.text != passwordTextField.text {
                confirmationPasswordTextField.backgroundColor = UIColor.TextFieldBackGrounds.BackgroundForFalse
                a = false
            }
            return a
        }
    }
}

extension RCLSignUpVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func hideKeyboardOnTap(_ selector: Selector) {
        let tap = UITapGestureRecognizer(target: self, action: selector)
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.initialStyler()
        if (textField == phoneTextField) && textField.text?.count == 0 {
            textField.text = "+38("
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.styleTextField()
        if (textField == phoneTextField) && textField.text?.count == 4 {
            textField.text = ""
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
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

