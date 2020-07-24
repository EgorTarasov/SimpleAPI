//
//  EventDetail.swift
//  ArrangeIt
//

import Foundation
import UIKit
import MapKit
import Firebase


class EventDetailViewController: UIViewController {
    var selectedEvent: Event?
    
    @IBOutlet var nameOfEvent: UILabel!
    @IBOutlet var image: UIImageView!
    @IBOutlet var button: UIButton!
    @IBOutlet var invites: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet var time: UILabel!
    @IBOutlet var address: UILabel!
    
    @IBAction func participants(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(identifier: "usersList") as? UsersListViewController {
            vc.selectedEvent = selectedEvent
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameOfEvent.text = selectedEvent?.name
        if let willGo = selectedEvent?.willGoUsers.count {
            button.setTitle("Участников: \(willGo)", for: .normal)
        } else {
            button.setTitle("Участников: неизвестно", for: .normal)
        }
        if let invites = selectedEvent?.invitedUsers.count {
            self.invites.text = "Приглашений: \(invites)"
        } else {
            invites.text = "Приглашений: неизвестно"
        }
        let df = DateFormatter()
        df.dateFormat = "dd MMMM yyyy"
        date.text = df.string(from: selectedEvent?.eventBeginDate ?? Date(timeIntervalSince1970: 0))
        df.dateFormat = "HH:mm"
        let start = df.string(from: selectedEvent?.eventBeginDate ?? Date(timeIntervalSince1970: 0))
        let finish = df.string(from: selectedEvent?.eventEndDate ?? Date(timeIntervalSince1970: 1000))
        time.text = start + " - " + finish
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(CLLocation(latitude: selectedEvent?.place[0] ?? 0.0, longitude: selectedEvent?.place[1] ?? 0.0), preferredLocale: Locale(identifier: "RU")) {
            (placemarksOpt, error) in
            if let placemarks = placemarksOpt, let streetAndHouse = placemarks[0].name, let city = placemarks[0].locality {
                if error == nil {
                    self.address.text = "\(city), \(streetAndHouse)"
                } else {
                    self.address.text = ("Нет краткого имени места")
                }
            }
        }
    }
}
