//
//  LoginVC.swift
//  testApp
//
//  Created by Ganna Melnyk on 3/1/18.
//  Copyright © 2018 Ganna Melnyk. All rights reserved.
//

import UIKit

class RCLLoginVC: UIViewController, AuthServiceDelegate {

    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInOutlet: UIButton!
    @IBOutlet weak var signUpOutlet: UIButton!
    var image = #imageLiteral(resourceName: "recycler")
    
    @IBAction func signInButton(_ sender: Any) {
        guard let login = loginTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        
        authentificator.login(login: login, password: password)
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        performSegue(withIdentifier: "ToSignUp", sender: self)
    }
    
    var styler = RCLStyler()
    var authentificator = RCLAuthentificator()
    var infoWindow = RCLInfoWindow()
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authentificator.delegate = self
//        let user = FirestoreService.shared.getUserBy(email: "test@mail.com", password: "1111")
//        print(user)
//        FirestoreService.shared.get(from: .users, returning: User.self) { (users) in
//            self.users = users
//        }
        
//        FirestoreService.shared.getUserBy(id: "yBX8iC5sp8xoVtaBUR9g") { (user) in
//            print(user.email)
//            print(user)
//        }
//        FirestoreService.shared.getUserBy(email: "c") { (user) -> User in
//
//        }
        
        self.hideKeyboardOnTap(#selector(self.dismissKeyboard))
        styler.styleButton(button: signInOutlet)
        styler.styleButton(button: signUpOutlet)
        loginTextField.initialStyler()
        passwordTextField.initialStyler()
        styler.renderImage(view: logoImage, image: image)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        if authentificator.isAUserActive() {
            performSegue(withIdentifier: "ToApp", sender: self)
        } 
    }
    
    func transitionToProfile() {
        performSegue(withIdentifier: "ToApp", sender: self)
    }
}

extension RCLLoginVC: UITextFieldDelegate {
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
