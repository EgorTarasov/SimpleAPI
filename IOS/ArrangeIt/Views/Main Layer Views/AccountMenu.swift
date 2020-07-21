//
//  AccountMenu.swift
//  ArrangeIt
//


import UIKit


class AccountMenuNavigationController: UINavigationController {
    
}

class AccountMenuViewController: UIViewController {
    @IBOutlet var stackView: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStackView()
        // Do any additional setup after loading the view.
    }
    
    private func setupStackView() {
//        trackLists.map { trackList in
//            let view: TrackListView = .fromNib()
//            view.setup(trackList: trackList)
//            return view
//        }.forEach {
//            stackView.addArrangedSubview($0)
//        }
        let eventsScrollView: EventScrollView = .fromNib()
        let testEventsList = [Event(id: "1", name: "Футбол во дворе", eventBeginDate: Date().addingTimeInterval(60), eventEndDate: Date().addingTimeInterval(3660), place: (55.773863, 37.679636), owner: "1", willGoUsers: ["1", "2", "3"], invitedUsers: []), Event(id: "2", name: "Покер", eventBeginDate: Date().addingTimeInterval(3600), eventEndDate: Date().addingTimeInterval(7200), place: (55.810127, 37.652739), owner: "1", willGoUsers: ["1", "2", "3", "4", "5", "6"], invitedUsers: ["7", "8", "9"]), Event(id: "3", name: "Встреча одноклассников", eventBeginDate: Date().addingTimeInterval(10000), eventEndDate: Date().addingTimeInterval(15000), place: (55.794207, 37.582787), owner: "1", willGoUsers: ["1", "2", "3", "4"], invitedUsers: ["5", "6"])]
        eventsScrollView.setup(eventsListOpt: testEventsList, collectionName: "Администрируемые мероприятия")
        stackView.addArrangedSubview(eventsScrollView)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
