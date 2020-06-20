//
//  Constant.swift
//  MemeMe1.0
//
//  Created by Wejdan on 06/10/1441 AH.
//  Copyright © 1441 Udacity. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let didAddMeme = Notification.Name("didAddMeme")
}

struct K {
    
    static let bottomText = "BOTTOM"
    static let topText = "TOP"
    static let collectionCellReuseIdentifier = "memeCollectionCell"
    static let tableCellReuseIdentifier = "memeTableCell"
    static let detailIdentifier = "MemeDetailViewController"
}
