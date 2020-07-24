//
//  Login&Register.swift
//  Регистрация и вход в приложения с помощью Firebase
//  ArrangeIt
//

import UIKit
import Firebase

class LoginAndRegisterViewController: UIViewController {
    
    // Переключатель Log in / sign up
    var signup: Bool = true {
        willSet {
            if newValue {
                titleLabel.text = "Регистрация"
                nameField.isHidden = false
                accountLabel.text = "У вас уже есть аккаунт?"
                switchButton.setTitle("Войти", for: .normal)
                enterButton.setTitle("Зарегистрироваться!", for:   .normal)
            }
            else {
                //Тут я проверяю бд ПОЖАЛУЙСТА НЕ УДАЛЯТЬ
                //let newEvent = Event(id: "4", name: "Обмен одеждой", eventBeginDate: Date(), eventEndDate: Date().addingTimeInterval(360), place: [54.4, 34.4], owner: "3", willGoUsers: ["3"], invitedUsers: [])
                //newEvent.save()
                titleLabel.text = "Вход"
                nameField.isHidden = true
                accountLabel.text = "Зарегистрироваться"
                switchButton.setTitle("Создать аккаунт", for: .normal)
                enterButton.setTitle("Войти", for: .normal)
            }
        }
    }
    
    
    @IBOutlet var accountLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    
    
    @IBOutlet var switchButton: UIButton!
    @IBOutlet var enterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
        signup = false
    }
    
    // Генерация всплывающего окна
    func showAlert(title : String, message : String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func enterButton(_ sender: UIButton) {
        let name = nameField.text!
        let email = emailField.text!
        let password = passwordField.text!
        if !name.isEmpty && !email.isEmpty && !password.isEmpty || !email.isEmpty && !password.isEmpty && !signup {
            if signup {
                Auth.auth().createUser(withEmail: email, password: password) {
                    (result, error) in
                    if error == nil {
                        if let result = result {
                            let user = User()
                            user.id = result.user.uid
                            user.name = name
                            user.email = email
                            user.save()
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                }
            } else if !signup{
                Auth.auth().signIn(withEmail: email, password: password) { (result, mayError) in
                    if let error: Error = mayError as NSError? {
                        self.showAlert(title: "Ошибка", message: "Не получилось войти. Ошибка: \(error.localizedDescription)")
                        
                    } else {
                        self.showAlert(title: "Успех!", message: "Вы успешно вошли в систему")
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        } else {
            showAlert(title: "Ошибка при выполнении действия!", message: "Вы заполнили не все поля")
        }
    }
    
    @IBAction func switchButton(_ sender: UIButton) { signup.toggle() }
}

