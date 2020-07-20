//
//  NewEvent.swift
//  ArrangeIt
//


import UIKit


class NewEventViewController: UIViewController {
    @IBOutlet var newEventName: UITextField!
    @IBOutlet var newEventPlace: UITextField!
    @IBOutlet var newEventDate: UIDatePicker!
    @IBOutlet var newEventStartTime: UIDatePicker!
    @IBOutlet var newEventEndTime: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newEventDate.datePickerMode = .date
        newEventDate.preferredDatePickerStyle = .compact
        newEventStartTime.datePickerMode = .time
        newEventStartTime.preferredDatePickerStyle = .compact
        newEventEndTime.datePickerMode = .time
        newEventEndTime.preferredDatePickerStyle = .compact
        
        //TODO : можешь отправить событие
        //sendEvent(id: <#T##EventID#>, name: <#T##String#>, eventBeginDate: <#T##Date#>, eventEndDate: <#T##Date#>, place: <#T##(Double, Double)#>, owner: <#T##UserID#>, willGoUsers: <#T##[UserID]#>, mayGoUsers: <#T##[UserID]#>)
    }
}
