//
//  AccountMenu.swift
//  ArrangeIt
//


import UIKit
import Nuke

class AccountMenuNavigationController: UINavigationController {
    
}

class AccountMenuViewController: UIViewController {
    @IBOutlet var image: UIImageView!
    @IBOutlet var name: UIButton!
    @IBOutlet var events: UILabel!
    @IBOutlet var invites: UILabel!
    @IBOutlet var settings: UIButton!
    @IBOutlet var scroll: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let user = InternalStorage.shared.nowUser {
            if let imageLink = user.image, let imageUrl = URL(string: imageLink) {
                Nuke.loadImage(with: imageUrl, into: image)
            } else {
                image.image = UIImage(systemName: "person.circle")
            }
            name.setTitle(user.name, for: .normal)
            events.text = "Всего мероприятий: \(user.willGoEvents.count)"
            invites.text = "Активных приглшений: \(user.invitedToEvents.count)"
        } else {
            image.image = UIImage(systemName: "person.badge.plus")
            name.setTitle("Войти в аккаунт", for: .normal)
        }
        let featuredView: EventScrollView = .fromNib()
        featuredView.setup(eventsListOpt: InternalStorage.shared.getFeaturedEvents(), collectionName: "Избранные мероприятия")
        scroll = featuredView
    }

    
    @IBAction func nameTapped(_ sender: UIButton) {
        if let user = InternalStorage.shared.nowUser, let vc = storyboard?.instantiateViewController(identifier: "accountDetail") as? AccountDetailViewController {
            vc.selectedUser = user
            navigationController?.pushViewController(vc, animated: true)
        } else if let vc = storyboard?.instantiateViewController(identifier: "loginAndRegister") as? LoginAndRegisterViewController {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

// Тестовый список из трех мероприятий
// let testEventsList = [Event(id: "1", name: "Футбол во дворе", eventBeginDate: Date().addingTimeInterval(60), eventEndDate: Date().addingTimeInterval(3660), place: (55.773863, 37.679636), owner: "1", willGoUsers: ["1", "2", "3"], invitedUsers: []), Event(id: "2", name: "Покер", eventBeginDate: Date().addingTimeInterval(3600), eventEndDate: Date().addingTimeInterval(7200), place: (55.810127, 37.652739), owner: "1", willGoUsers: ["1", "2", "3", "4", "5", "6"], invitedUsers: ["7", "8", "9"]), Event(id: "3", name: "Встреча одноклассников", eventBeginDate: Date().addingTimeInterval(10000), eventEndDate: Date().addingTimeInterval(15000), place: (55.794207, 37.582787), owner: "1", willGoUsers: ["1", "2", "3", "4"], invitedUsers: ["5", "6"])]

//func setup(userOpt: User?) {
//    self.layer.cornerRadius = 20.0
//    if let user = userOpt {
//        if let userImagePath = user.image {
//            if let url = URL(string: userImagePath) {
//                Nuke.loadImage(with: url, into: userImage)
//                userImage.layer.cornerRadius = 75.0
//            }
//        } else {
//            userImage.image = UIImage(systemName: "person.crop.square")
//        }
//
//        userName.text = user.name
//        userEvents.setTitle("Ваши встречи: \(user.willGoEvents.count)", for: .normal)
//        userInvites.setTitle("Приглашений: \(user.invitedToEvents.count)", for: .normal)
//    } else {
//        userImage.image = UIImage(systemName: "person.crop.circle.badge.questionmark")
//        userName.text = "Войти или зарегистрироваться"
//    }
//}
