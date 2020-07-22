//
//  AccountCellView.swift
//  ArrangeIt
//
//  Created by Артём Тихоненко on 21.07.2020.
//

import UIKit
import Nuke


class AccountCellView: UIView {
    @IBOutlet var userImage: UIImageView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var settingsButton: UIButton!
    @IBOutlet var userInvites: UIButton!
    @IBOutlet var userEvents: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(userOpt: User?) {
        self.layer.cornerRadius = 20.0
        if let user = userOpt {
            if let userImagePath = user.image {
                if let url = URL(string: userImagePath) {
                    Nuke.loadImage(with: url, into: userImage)
                    userImage.layer.cornerRadius = 75.0
                }
            } else {
                userImage.image = UIImage(systemName: "person.crop.square")
            }
            
            userName.text = user.name
            userEvents.setTitle("Ваши встречи: \(user.willGoEvents.count)", for: .normal)
            userInvites.setTitle("Приглашений: \(user.invitedToEvents.count)", for: .normal)
        } else {
            userImage.image = UIImage(systemName: "person.crop.circle.badge.questionmark")
            userName.text = "Войти или зарегистрироваться"
            settingsButton.setTitle("", for: .normal)
        }
    }
}
