//
//  ViewController.swift
//  ArrangeIt
//


import UIKit
import Firebase


class MainViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
}
