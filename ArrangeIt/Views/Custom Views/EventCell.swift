//
//  NewUI.swift
//  ArrangeIt
//
//  Created by Артём Тихоненко on 21.07.2020.
//

import UIKit
import Nuke
import MapKit
import Firebase

public extension UIView {
    class func fromNib<T: UIView>(nibName: String) -> T {
        let bundle = Bundle(for: T.self)
        return bundle.loadNibNamed(
            nibName,
            owner: nil,
            options: nil
        )?.first as! T
    }
    
    class func fromNib<T: UIView>() -> T {
        print(String(describing: T.self))
        return fromNib(nibName: String(describing: T.self))
    }
}

class EventsCollectionCell: UICollectionViewCell {
    var eventOptional: Event?
    var parentVC: UIViewController? = nil
    var storyboard: UIStoryboard? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 20.0
    }
    @IBOutlet var eventNameLabel: UILabel!
    @IBOutlet var eventCoverImageView: UIImageView!
    @IBOutlet var eventDateLabel: UILabel!
    @IBOutlet var eventStartLabel: UILabel!
    @IBOutlet var eventEndLabel: UILabel!
    @IBOutlet var eventNumOfPersonLabel: UILabel!
    @IBOutlet var eventShortAdresslabel: UILabel!
    
    @IBAction func cellTapped(_ sender: UIButton) {
        print("tapped")
        if let _ = eventOptional, let vc = storyboard?.instantiateViewController(identifier: "eventDetail") as? EventDetailViewController {
            vc.selectedEvent = eventOptional
            self.parentVC?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func update(eventOpt: Event?, parentVCont: UIViewController? = nil, storyboardVC: UIStoryboard? = nil) {
        eventOptional = eventOpt
        parentVC = parentVCont
        storyboard = storyboardVC
        // Загрузка изображения
        if let event = eventOpt {
            if let eventCoverPath = event.cover {
                if let url = URL(string: eventCoverPath) {
                    Nuke.loadImage(with: url, into: eventCoverImageView)
                }
            } else {
                eventCoverImageView.image = UIImage(systemName: "calendar")
            }
            let df = DateFormatter()
            
            eventNameLabel.text = event.name
            
            df.dateFormat = "dd MMMM"
            eventDateLabel.text = df.string(from: event.eventBeginDate)
            
            df.dateFormat = "hh:mm"
            eventStartLabel.text = df.string(from: event.eventBeginDate)
            df.dateFormat = "hh:mm"
            eventEndLabel.text = df.string(from: event.eventEndDate)
            eventNumOfPersonLabel.text = "\(event.willGoUsers.count) человек"
            
            // Краткое название места
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(CLLocation(latitude: event.place[0], longitude: event.place[1]), preferredLocale: Locale(identifier: "RU")) {
                (placemarksOpt, error) in
                if let placemarks = placemarksOpt, let streetAndHouse = placemarks[0].name, let city = placemarks[0].locality {
                    if error == nil {
                        self.eventShortAdresslabel.text = "\(city), \(streetAndHouse)"
                    } else {
                        self.eventShortAdresslabel.text = ("Нет краткого имени места")
                    }
                }
            }
        } else if Auth.auth().currentUser != nil {
            eventNameLabel.text = "Не удалось получить данные встречи"
            eventShortAdresslabel.text = "??????"
            eventDateLabel.text = "?? ????"
            eventStartLabel.text = "??:??"
            eventEndLabel.text = "??:??"
            eventCoverImageView.image = UIImage(systemName: "questionmark.circle")
            eventNumOfPersonLabel.text = "?????????"
            
        } else {
            eventNameLabel.text = "Вы не вошли в аккаунт"
            eventShortAdresslabel.isHidden = true
            eventDateLabel.isHidden = true
            eventStartLabel.isHidden = true
            eventEndLabel.isHidden = true
            eventCoverImageView.image = UIImage(systemName: "person.crop.circle.badge.questionmark")
            eventNumOfPersonLabel.isHidden = true
            // TODO
            // Пользователь не вошел в аккаунт
        }
    }
}

