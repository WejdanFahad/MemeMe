//
//  MemeCollectionViewController.swift
//  MemeMe1.0
//
//  Created by Wejdan Alhussain on 08/06/2020.
//  Copyright © 2020 Udacity. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UICollectionViewController {

    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    override func viewDidLoad() {
              super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(reloadMemesData), name: .didAddMeme , object: nil)
           
       }
       

       @objc func reloadMemesData() {
              updateUI()
            self.collectionView.reloadData()
       }
    
   
    func updateUI() {
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0

         // set collectionViewFlowLayout
            flowLayout.minimumInteritemSpacing = space
            flowLayout.minimumLineSpacing = space
            flowLayout.itemSize = CGSize(width: dimension, height: dimension)
            
    }
    
   
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.collectionCellReuseIdentifier, for: indexPath) as! MemeCollectionViewCell
        
        let meme = self.memes[(indexPath as NSIndexPath).row]

        // Set image
        cell.imageView.image = meme.memedImage

        return cell
    }
    
    

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {

        // Grab the DetailVC from Storyboard
        let detailController = self.storyboard!.instantiateViewController(withIdentifier:K.detailIdentifier) as! MemeDetailViewController

        //Populate view controller with data from the selected item
        detailController.meme = memes[(indexPath as NSIndexPath).row]

        // Present the view controller using navigation
        navigationController!.pushViewController(detailController, animated: true)

    }
    
}
