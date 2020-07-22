//
//  AccountDetail.swift
//  ArrangeIt
//


import UIKit


class AccountDetailViewController: UIViewController {
    var selectedUser: User?
    @IBOutlet var userPicture: UIImageView!
    @IBOutlet var userName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userName.text = selectedUser?.name
    }
}
