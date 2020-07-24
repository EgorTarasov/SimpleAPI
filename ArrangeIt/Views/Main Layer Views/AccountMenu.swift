//
//  AccountMenu.swift
//  ArrangeIt
//


import UIKit
import Nuke
import Firebase

class AccountMenuNavigationController: UINavigationController {
    
}

class AccountMenuViewController: UIViewController {
    @IBOutlet var image: UIImageView!
    @IBOutlet var name: UIButton!
    @IBOutlet var events: UILabel!
    @IBOutlet var invites: UILabel!
    @IBOutlet var settings: UIButton!
    @IBOutlet var scroll: UIView!
    @IBOutlet var accountView: UIView!
    @IBOutlet var imageButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        accountView.backgroundColor = UIColor(named: "accountCellColor")
//        scroll.subviews.forEach({$0.removeFromSuperview()})
//        var user = User()
//        user.getCurrentUser(user: user)
//        var id = Auth.auth().currentUser?.uid
//        if let tmp = UsersStorage.shared.cacheId[id ?? ""] {
//            user = tmp
//        }
//        if user.name != "" {
//            print("all ok")
            image.image = UIImage(systemName: "person.circle")
            name.setTitle("Artem", for: .normal)
            
            
            events.text = "Всего мероприятий: 15"
         
            invites.text = "Активных приглашений: 4"
            
            let featuredView: EventScrollView = .fromNib()
        let testEventsList = [Event(name: "Футбол во дворе", eventBeginDate: Date().addingTimeInterval(60), eventEndDate: Date().addingTimeInterval(3660), place: [55.773863, 37.679636], owner: "1", willGoUsers: ["1", "2", "3"], invitedUsers: []), Event(name: "Покер", eventBeginDate: Date().addingTimeInterval(3600), eventEndDate: Date().addingTimeInterval(7200), place: [55.810127, 37.652739], owner: "1", willGoUsers: ["1", "2", "3", "4", "5", "6"], invitedUsers: ["7", "8", "9"]), Event( name: "Встреча одноклассников", eventBeginDate: Date().addingTimeInterval(10000), eventEndDate: Date().addingTimeInterval(15000), place: [55.794207, 37.582787], owner: "1", willGoUsers: ["1", "2", "3", "4"], invitedUsers: ["5", "6"])]
            featuredView.setup(eventsListOpt: testEventsList, collectionName: "Ваши мероприятия", parentVC: self, storyboard: storyboard)
            featuredView.frame.size.width = self.view.frame.size.width
            scroll.addSubview(featuredView)
//        } else {
//            image.image = UIImage(systemName: "person.badge.plus")
//            name.setTitle("Войти в аккаунт", for: .normal)
//            events.text = "Всего мероприятий: 0"
//            invites.text = "Активных приглшений: 0"
//            scroll.subviews.forEach { $0.removeFromSuperview() }
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.update()
    }
    
    func update() {
//        scroll.subviews.forEach({$0.removeFromSuperview()})
//        var user = User()
//        user.getCurrentUser(user: user)
//        var id = Auth.auth().currentUser?.uid
//        if let tmp = UsersStorage.shared.cacheId[id ?? ""] {
//            user = tmp
//        }
//        if user.name != "" {
//            image.image = UIImage(systemName: "person.circle")
//            name.setTitle(user.name, for: .normal)
//
//            let eventsCollection = EventsCollection()
//            eventsCollection.getWillEvents(userid: user.id)
//            events.text = "Всего мероприятий: \(eventsCollection.count)"
//
//            let invitesCollection = EventsCollection()
//            invitesCollection.getInvitedEvents(userid: user.id)
//            invites.text = "Активных приглашений: \(invitesCollection.count)"
//
//            let featuredView: EventScrollView = .fromNib()
//            featuredView.setup(eventsListOpt: eventsCollection, collectionName: "Ваши мероприятия", parentVC: self, storyboard: storyboard)
//            featuredView.frame.size.width = self.view.frame.size.width
//            scroll.addSubview(featuredView)
//        } else {
//            image.image = UIImage(systemName: "person.badge.plus")
//            name.setTitle("Войти в аккаунт", for: .normal)
//            events.text = "Всего мероприятий: 0"
//            invites.text = "Активных приглшений: 0"
//            scroll.subviews.forEach { $0.removeFromSuperview() }
//        }
    }
    
    @IBAction func nameTapped(_ sender: UIButton) {
        var user = User()
        user.getCurrentUser(user: user)
        let id = Auth.auth().currentUser?.uid ?? "1"
        user = UsersStorage.shared.cacheId[id]!
        if user.name != "", let vc = storyboard?.instantiateViewController(identifier: "accountDetail") as? AccountDetailViewController {
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
