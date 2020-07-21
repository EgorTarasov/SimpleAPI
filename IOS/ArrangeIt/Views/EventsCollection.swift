//
//  NewUI.swift
//  ArrangeIt
//
//  Created by Артём Тихоненко on 21.07.2020.
//

import UIKit
import Nuke

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
    
    func update(event: Event) {
        if let eventCoverPath = event.cover {
            if let url = URL(string: eventCoverPath) {
                Nuke.loadImage(with: url, into: imageView)
            }
        }
        titleLabel.text = event.name
    }
}

