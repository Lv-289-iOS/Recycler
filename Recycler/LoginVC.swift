//
//  LoginVC.swift
//  testApp
//
//  Created by Ganna Melnyk on 3/1/18.
//  Copyright © 2018 Ganna Melnyk. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInOutlet: UIButton!
    @IBOutlet weak var signUpOutlet: UIButton!
    var image = #imageLiteral(resourceName: "recycler")
    
    @IBAction func signInButton(_ sender: Any) {
        guard let login = loginTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        
        if !authentificator.isUser(login: login, pass: password) {
            self.present(infoWindow.wrongCredentials(), animated: true, completion: nil)
        } else {
            performSegue(withIdentifier: "ToApp", sender: self)
        }
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        performSegue(withIdentifier: "ToSignUp", sender: self)
    }
    
    var styler = Styler()
    var authentificator = Authentificator()
    var infoWindow = InfoWindow()
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FirestoreService.shared.get(from: .users, returning: User.self) { (users) in
            self.users = users
        }
        self.hideKeyboardOnTap(#selector(self.dismissKeyboard))
        styler.styleButton(button: signInOutlet)
        styler.styleButton(button: signUpOutlet)
        loginTextField.initialStyler()
        passwordTextField.initialStyler()
        styler.renderImage(view: logoImage, image: image)
    }
}

extension LoginVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func hideKeyboardOnTap(_ selector: Selector) {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: selector)
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
