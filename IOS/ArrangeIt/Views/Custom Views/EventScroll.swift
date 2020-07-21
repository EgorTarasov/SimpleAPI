//
//  EventScroll.swift
//  ArrangeIt
//
//  Created by Артём Тихоненко on 21.07.2020.
//

import UIKit

class EventScrollView: UIView {
    @IBOutlet var typeOfCollectionLabel: UILabel!
    @IBOutlet var eventsCollectionView: UICollectionView!
    
    var eventsListOpt: [Event]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        eventsCollectionView.delegate = self
        eventsCollectionView.dataSource = self
        eventsCollectionView.register(UINib(nibName: "EventCellView", bundle: .main), forCellWithReuseIdentifier: "EventCell")
    }
    
    func setup(eventsListOpt: [Event], collectionName: String) {
        self.eventsListOpt = eventsListOpt
        self.typeOfCollectionLabel.text = collectionName
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
        return eventsListOpt?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let eventsList = self.eventsListOpt,
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventCell", for: indexPath) as? EventsCollectionCell
        else {
            return UICollectionViewCell()
        }
        
        cell.update(event: eventsList[indexPath.row])
        return cell
    }
}


