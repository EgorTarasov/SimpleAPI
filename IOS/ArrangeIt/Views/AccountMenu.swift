//
//  AccountMenu.swift
//  ArrangeIt
//


import UIKit


class AccountMenuViewController: UITableViewController {

    // Отвечает за количество строк
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let user = InternalStorage.shared.nowUser {
            return 1 + InternalStorage.shared.getAdministratedEventsByUser(user: user).count
        }
        else {
            return 1
        }
    }
    
    
    // Отвечает за то, куда перейдет пользователь после тапа по строчке
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // аккаунт и залогинен - просмотр аккаунта
        if indexPath.row == 0 && InternalStorage.shared.nowUser != nil {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "accountDetail") as? AccountDetailViewController {
                vc.selectedUser = InternalStorage.shared.nowUser
                navigationController?.pushViewController(vc, animated: true)
            }
        }
        
        // аккаунт и не залогинен - регистрация/вход
        else if indexPath.row == 0 && InternalStorage.shared.nowUser == nil {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "loginAndRegister") as? LoginAndRegisterViewController {
                navigationController?.pushViewController(vc, animated: true)
            }
        }
        
        // мероприятие - детальный просмотр мероприятия
        else if InternalStorage.shared.nowUser != nil {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "eventDetail") as? EventDetailViewController {
                vc.selectedEvent = InternalStorage.shared.getEventByID(ID: InternalStorage.shared.nowUser!.willGoEvents[indexPath.row - 1])
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    // Отвечает за то, какой контент находится на строчке
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Строчка "аккаунт" и пользователь залогинен - имя, ближайший ивент, фотография, уведомления
        if indexPath.row == 0 && nowUser != nil {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AccountItem", for: indexPath)
            
            cell.textLabel?.text = "Ваш аккаунт, \(nowUser!.name)"
            cell.imageView?.image = UIImage(systemName: "person")
            
            return cell
        }
        
        // Строчка "аккаунт" и пользователь не залогинен - пустое изображение, "войти или зарегистрироваться"
        else if indexPath.row == 0 && nowUser == nil {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AccountItem", for: indexPath)
            
            cell.textLabel?.text = "Войти в аккаунт"
            cell.imageView?.image = UIImage(systemName: "person.crop.circle.badge.plus")
            
            return cell
        }
        
        // Строчка "мероприятие" и их нет/не залогинен - пусто, иначе список мероприятий - название, дата, место, изображение
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventItem", for: indexPath)
            
            cell.textLabel?.text = everythingStorage?.getEventByID(ID: nowUser!.returnAdministratedEvents(storage: everythingStorage)[indexPath.row - 1])?.name
            cell.imageView?.image = UIImage(systemName: "person.3")
            
            return cell
        }
    }
}
