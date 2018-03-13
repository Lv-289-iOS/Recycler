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
    var image = #imageLiteral(resourceName: "logo")
    
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
        
        self.view.backgroundColor = UIColor.Backgrounds.GrayDark
        authentificator.delegate = self
//        let trash = Trash(trashCanId: "uFYf9ltIIloIxWtFiJLf", userIdReportedFull: "CUXMZQRwJD1JfbrjfDEs")
//        FirestoreService.shared.add(for: trash, in: .trash)
//        FirestoreService.shared.getLatestTrashBy(trashCanId: "uFYf9ltIIloIxWtFiJLf") { (trash) in
//            print(trash!)
//        }
        
        self.hideKeyboardOnTap(#selector(self.dismissKeyboard))
        styler.styleButton(button: signInOutlet)
        styler.styleButton(button: signUpOutlet)
        loginTextField.textType = .emailAddress
        passwordTextField.textType = .password
        loginTextField.initialStyler()
        passwordTextField.initialStyler()
        logoImage.image = image
//        styler.renderImage(view: logoImage, image: image)
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
