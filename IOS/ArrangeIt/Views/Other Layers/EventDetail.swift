//
//  EventDetail.swift
//  ArrangeIt
//


import UIKit


class EventDetailViewController: UIViewController {
    var selectedEvent: Event?
    
    @IBOutlet var nameOfEvent: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameOfEvent.text = selectedEvent?.name
    }
}
