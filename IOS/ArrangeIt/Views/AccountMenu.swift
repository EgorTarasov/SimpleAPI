//
//  AccountMenu.swift
//  ArrangeIt
//


import UIKit


class AccountMenuViewController: UITableViewController {
    var everythingStorage: InternalStorage? = testEverythingStorage
    var nowUser: User? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nowUser = everythingStorage?.nowUser
    }
    
    
    // Отвечает за количество строк
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let user = nowUser {
            return 1 + user.returnAdministratedEvents(storage: everythingStorage).count
        }
        else {
            return 1
        }
    }
    
    
    // Отвечает за то, куда перейдет пользователь после тапа по строчке
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // аккаунт и залогинен - просмотр аккаунта
        if indexPath.row == 0 && nowUser != nil {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "detailedAccountView") as? AccountDetailViewController {
                vc.selectedUser = everythingStorage?.nowUser
                navigationController?.pushViewController(vc, animated: true)
            }
        }
        
        // аккаунт и не залогинен - регистрация/вход
        else if indexPath.row == 0 && nowUser == nil {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "loginInAccountView") as? LoginAndRegisterViewController {
                navigationController?.pushViewController(vc, animated: true)
            }
        }
        
        // мероприятие - детальный просмотр мероприятия
        else if nowUser != nil {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "detailedEventView") as? EventDetailViewController {
                vc.selectedEvent = everythingStorage?.getEventByID(ID: nowUser!.returnAdministratedEvents(storage: everythingStorage)[indexPath.row - 1])
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
