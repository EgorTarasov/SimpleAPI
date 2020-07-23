//
//  EventMenu.swift
//  ArrangeIt
//


import UIKit

class EventMenuViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (FirebaseCover.shared.getNowUser()?.willGoEvents.count ?? 0) + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let list = FirebaseCover.shared.getNowUser()?.willGoEvents {
            if indexPath.row != 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath)
                cell.textLabel?.text = FirebaseCover.shared.getEventByID(list[indexPath.row])?.name
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath)
                cell.textLabel?.text = "Новое событие"
                return cell
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath)
            cell.textLabel?.text = "Вы не вошли или произошла ошибка"
            return cell
        }
    }
}
