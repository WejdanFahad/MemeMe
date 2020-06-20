//
//  MemeDetailViewController.swift
//  MemeMe1.0
//
//  Created by Wejdan Alhussain on 08/06/2020.
//  Copyright © 2020 Udacity. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {

    var meme: Meme!
    
    @IBOutlet weak var MemeImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //set image property
        MemeImageView.image = meme.memedImage
    }

}
