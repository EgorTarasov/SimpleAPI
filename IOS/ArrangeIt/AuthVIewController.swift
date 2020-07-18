//
//  AuthVIewController.swift
//  ArrangeIt
//
//  Created by Егор Тарасов on 17.07.2020.
//  Copyright © 2020 Егор Тарасов. All rights reserved.
//

import UIKit
import Firebase

class LoginInAccountView: UIViewController {
    
    var signup: Bool = true {
        willSet {
            if newValue {
                titleLabel.text = "Регистрация"
                nameField.isHidden = false
                accountLabel.text = "У вас уже есть аккаунт?"
                switchButton.setTitle("Войти", for: .normal)
            } else {
                titleLabel.text = "Вход"
                nameField.isHidden = true
                accountLabel.text = "Присоединиться"
                switchButton.setTitle("Создать аккаунт", for: .normal)
            }
        }
    }

    
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var titleLabel : UILabel!
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var enterButton: UIButton!
    
    @IBOutlet weak var switchButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    func showAlert(tittle : String, message : String){
        let alert = UIAlertController(title: tittle, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func enterButton(_ sender: UIButton) {
        let name = nameField.text!
        let email = emailField.text!
        let password = emailField.text!
        if (name.isEmpty){
            showAlert(tittle: "Пустое поле", message: "Вы не указали имя пользователя")
        }
        if (email.isEmpty){
            showAlert(tittle: "Пустое поле", message: "Вы не указали адрес электронной почты")
        }
        if (password.isEmpty){
            showAlert(tittle: "Пустое поле", message: "Вы не указали пароль от аккаунта")
        }
        
        if (!name.isEmpty && !email.isEmpty && !password.isEmpty){
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                if error == nil{
                    if let result = result{
                        print(result.user.uid)
                    }
                }
            }
        }
        
    }
    
    @IBAction func switchButton(_ sender: UIButton) {
        signup = !signup
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

