//
//  NewEvent.swift
//  ArrangeIt
//


import UIKit


class NewEventViewController: UIViewController {
    @IBOutlet var newEventName: UITextField!
    @IBOutlet var newEventPlace: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO : можешь отправить событие
        //sendEvent(id: <#T##EventID#>, name: <#T##String#>, eventBeginDate: <#T##Date#>, eventEndDate: <#T##Date#>, place: <#T##(Double, Double)#>, owner: <#T##UserID#>, willGoUsers: <#T##[UserID]#>, mayGoUsers: <#T##[UserID]#>)
    }
}
