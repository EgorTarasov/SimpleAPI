//
//  AuthVIewController.swift
//  ArrangeIt
//


import UIKit
import Firebase

class LoginAndRegisterViewController: UIViewController {
    
    var signup: Bool = true {
        willSet {
            if newValue {
                titleLabel.text = "Регистрация"
                nameField.isHidden = false
                accountLabel.text = "У вас уже есть аккаунт?"
                switchButton.setTitle("Войти", for: .normal)
            }
            else {
                titleLabel.text = "Вход"
                nameField.isHidden = true
                accountLabel.text = "Присоединиться"
                switchButton.setTitle("Создать аккаунт", for: .normal)
            }
        }
    }
    
    // Лейблы
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    // Поля ввода
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    // Кнопки
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var switchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Показать уведомление, что все окей
    func showAlert(title : String, message : String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // Обработать введенные данные и отправить на сервер
    @IBAction func enterButton(_ sender: UIButton) {
        let name = nameField.text!
        let email = emailField.text!
        let password = passwordField.text!
        
        if name.isEmpty || email.isEmpty || password.isEmpty {
            showAlert(title: "Проверьте ввод", message: "Вы заполнили не все поля")
        }
        else {
            Auth.auth().createUser(withEmail: email, password: password) {
                (result, error) in
                if error == nil {
                    if let result = result {
                        print(result.user.uid)
                    }
                }
            }
        }
        
    }
    
    @IBAction func switchButton(_ sender: UIButton) { signup.toggle() }
}
