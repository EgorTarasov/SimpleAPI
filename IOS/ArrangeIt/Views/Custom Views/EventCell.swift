//
//  NewUI.swift
//  ArrangeIt
//
//  Created by Артём Тихоненко on 21.07.2020.
//

import UIKit
import Nuke
import MapKit

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
        return fromNib(nibName: String(describing: T.self))
    }
}

class EventsCollectionCell: UICollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    @IBOutlet var eventNameLabel: UILabel!
    @IBOutlet var eventCoverImageView: UIImageView!
    @IBOutlet var eventDateLabel: UILabel!
    @IBOutlet var eventStartLabel: UILabel!
    @IBOutlet var eventEndLabel: UILabel!
    @IBOutlet var eventNumOfPersonLabel: UILabel!
    @IBOutlet var eventShortAdresslabel: UILabel!
    
    func update(event: Event) {
        // Загрузка изображения
        if let eventCoverPath = event.cover {
            if let url = URL(string: eventCoverPath) {
                Nuke.loadImage(with: url, into: eventCoverImageView)
            }
        }
        let df = DateFormatter()
        
        eventNameLabel.text = event.name
        
        df.dateFormat = "dd MMM"
        eventDateLabel.text = df.string(from: event.eventBeginDate)
        
        df.dateFormat = "hh:mm"
        eventStartLabel.text = df.string(from: event.eventBeginDate)
        df.dateFormat = "hh:mm"
        eventEndLabel.text = df.string(from: event.eventEndDate)
        eventNumOfPersonLabel.text = "\(event.willGoUsers.count) человек"
        
        // Краткое название места
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(CLLocation(latitude: event.place.0, longitude: event.place.1), preferredLocale: Locale(identifier: "RU")) {
            (placemarksOpt, error) in
            if let placemarks = placemarksOpt, let streetAndHouse = placemarks[0].name, let city = placemarks[0].locality {
                if error == nil {
                    print("\(city), \(streetAndHouse)")
                } else {
                    print("Нет краткого имени места")
                }
            }
        }
    }
}

