//
//  EventScroll.swift
//  ArrangeIt
//
//  Created by Артём Тихоненко on 21.07.2020.
//

import UIKit

class EventScrollView: UIView {
    @IBOutlet var eventsCollectionView: UICollectionView!
    
    var eventsListOpt: [EventID]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        eventsCollectionView.delegate = self
        eventsCollectionView.dataSource = self
        eventsCollectionView.register(UINib(nibName: "EventCellView", bundle: .main), forCellWithReuseIdentifier: "EventCell")
    }
    
    func setup(eventsListOpt: [EventID]?, collectionName: String) {
        self.eventsListOpt = eventsListOpt
        eventsCollectionView.reloadData()
    }
}

extension EventScrollView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
}

extension EventScrollView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return eventsListOpt?.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventCell", for: indexPath) as? EventsCollectionCell {
            if let eventsList = self.eventsListOpt {
                cell.update(eventOpt: InternalStorage.shared.getEventByID(ID: eventsList[indexPath.row]))
            } else {
                cell.update(eventOpt: nil)
            }
            return cell
        } else {
            return UICollectionViewCell()
        }
        
    }
}


