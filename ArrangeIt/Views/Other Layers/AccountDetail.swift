//
//  AccountDetail.swift
//  ArrangeIt
//


import UIKit
import Firebase

class AccountDetailViewController: UIViewController {
    var selectedUser: User? = User(id: "test", name: "Artem Tikhonenko", email: "test@r.yr", isAppUser: true)
    @IBOutlet var button: UIButton!
    @IBOutlet var userPicture: UIImageView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var events: UILabel!
    @IBOutlet var invites: UILabel!
    @IBAction func logout(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        if let selectedUser = selectedUser {
            userName.text = selectedUser?.name
            userPicture.image = UIImage(systemName: "person.fill")
          
            events.text = "Встреч: 15"
            invites.text = "Приглашений: 4"
//        } else {
//            userName.text = "Не удалось получить пользователя"
//            button.setTitle("", for: .normal)
//            userPicture.image = UIImage(systemName: "person.fill.questionmark")
//
        }
    }

