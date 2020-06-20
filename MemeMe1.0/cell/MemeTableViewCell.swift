//
//  MemeTableViewCell.swift
//  MemeMe1.0
//
//  Created by Wejdan on 17/10/1441 AH.
//  Copyright © 1441 Udacity. All rights reserved.
//

import UIKit

class MemeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var memeText: UILabel!
    @IBOutlet weak var memeImageView: UIImageView!
   
    var meme: Meme! {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        memeText.text = "\(meme.topText) ... \(meme.bottomText)"
        memeImageView.image =  meme.memedImage
    }

}
