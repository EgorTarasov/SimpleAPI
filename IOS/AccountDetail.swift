//
//  AccountDetail.swift
//  ArrangeIt
//


import UIKit


class DetailedAccountView: UIViewController {
    var selectedUser: User?
    @IBOutlet var userPicture: UIImageView!
    @IBOutlet var userName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userName.text = selectedUser?.name
    }
}
