//
//  AccountDetail.swift
//  ArrangeIt
//


import UIKit
import Firebase

class AccountDetailViewController: UIViewController {
    var selectedUser: User?
    @IBOutlet var userPicture: UIImageView!
    @IBOutlet var userName: UILabel!
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
        userName.text = selectedUser?.name
        userPicture.image = UIImage(systemName: "person.fill")
    }
}
