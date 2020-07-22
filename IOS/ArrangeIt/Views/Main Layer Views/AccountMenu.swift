//
//  AccountMenu.swift
//  ArrangeIt
//


import UIKit


class AccountMenuNavigationController: UINavigationController {
    
}

class AccountMenuViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var accountCell: AccountCellView = .fromNib()
        accountCell.setup(userOpt: InternalStorage.shared.nowUser)
        
        var featuredEventsCell: EventScrollView = .fromNib()
        featuredEventsCell.setup(eventsListOpt: InternalStorage.shared.getFeaturedEvents(), collectionName: "Избранные встречи")
        
        var administratedEventsCell: EventScrollView = .fromNib()
        administratedEventsCell.setup(eventsListOpt: InternalStorage.shared.getAdministratedEventsByUser(userOpt: InternalStorage.shared.nowUser), collectionName: "Администрируемые встречи")
        
        view.addSubview(accountCell)
        // Do any additional setup after loading the view.
    }
}
        // let testEventsList = [Event(id: "1", name: "Футбол во дворе", eventBeginDate: Date().addingTimeInterval(60), eventEndDate: Date().addingTimeInterval(3660), place: (55.773863, 37.679636), owner: "1", willGoUsers: ["1", "2", "3"], invitedUsers: []), Event(id: "2", name: "Покер", eventBeginDate: Date().addingTimeInterval(3600), eventEndDate: Date().addingTimeInterval(7200), place: (55.810127, 37.652739), owner: "1", willGoUsers: ["1", "2", "3", "4", "5", "6"], invitedUsers: ["7", "8", "9"]), Event(id: "3", name: "Встреча одноклассников", eventBeginDate: Date().addingTimeInterval(10000), eventEndDate: Date().addingTimeInterval(15000), place: (55.794207, 37.582787), owner: "1", willGoUsers: ["1", "2", "3", "4"], invitedUsers: ["5", "6"])]
