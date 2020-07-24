//
//  NewEvent.swift
//  ArrangeIt
//


import UIKit
import MapKit
import Firebase

class NewEventViewController: UIViewController {
    
    
    
    @IBOutlet var newEventName: UITextField!
    @IBOutlet var newEventPlace: UITextField!
    @IBOutlet var date: UITextField!
    @IBOutlet var time: UITextField!
    @IBOutlet var duration: UITextField!
    @IBOutlet var emails: UITextField!
    
    @IBAction func create(_ sender: UIButton) {
        if let test1 = newEventName.text?.isEmpty, !test1, let test2 = newEventPlace.text?.isEmpty, !test2, let test3 = date.text?.isEmpty, !test3, let test4 = time.text?.isEmpty, !test4, let test5 = duration.text?.isEmpty, !test5, let test6 = emails.text?.isEmpty, !test6 {
            let formatter = DateFormatter()
            let addedDate = date.text!
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            
            
            let addedTime = time.text!
            formatter.dateFormat = "hh:mm"
            
            let addedDuration = duration.text!
            
            let compiledStart = formatter.date(from: addedDate + "T" + addedTime + ":00+0000")
            
            let compiledEnd: Date? = formatter.date(from: addedDate + "T" + addedDuration + ":00+0000")
            
            let addedEmails = emails.text!
            let addedEmailsArray = addedEmails.components(separatedBy: ", ")
            var addedUsers: [User] = []
            for email in addedEmailsArray {
                var user = User()
                user.getUserByEmail(email, user: user)
                user = UsersStorage.shared.cacheEmail[email] ?? user
                if user.name != "" {
                    addedUsers.append(user)
                }
            }
            let eventname = newEventName.text!
            let finalEvent = Event()
            if let start = compiledStart, let end = compiledEnd {
                finalEvent.name = eventname
                finalEvent.eventBeginDate = start
                finalEvent.eventEndDate = end
                for user in addedUsers {
                    finalEvent.invitedUsers.append(user.id)
                }
                if let tmp = Auth.auth().currentUser?.uid {
                    finalEvent.willGoUsers.append(tmp)
                }
            }
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(newEventPlace.text!) {
                (placemarks, error) in
                if error == nil {
                    if let placemark = placemarks?[0] {
                        finalEvent.place[0] = placemark.location?.coordinate.longitude ?? 0.0
                        finalEvent.place[1] = placemark.location?.coordinate.latitude ?? 0.0
                        finalEvent.save()
                    }
                } else {
                    
                }
            }
        } else {
            showAlert(title: "Ошибка", message: "Вы заполнили не все поля")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
        
    }
    
    func showAlert(title : String, message : String){
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
//    let geocoder = CLGeocoder()
//        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
//            if error == nil {
//                if let placemark = placemarks?[0] {
//                    let location = placemark.location!
//
//                    completionHandler(location.coordinate, nil)
//                    return
//                }
//            }
}
