//
//  MemeTableViewController.swift
//  MemeMe1.0
//
//  Created by Wejdan on 17/10/1441 AH.
//  Copyright © 1441 Udacity. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {
    
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
            self.tableView.reloadData()
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.tableCellReuseIdentifier, for: indexPath) as! MemeTableViewCell

        let meme = memes[indexPath.row]
        cell.meme = meme
        return cell
    }
    


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let detailController = self.storyboard!.instantiateViewController(withIdentifier:K.detailIdentifier) as! MemeDetailViewController

               //Populate view controller with data from the selected item
               detailController.meme = memes[(indexPath as NSIndexPath).row]

               // Present the view controller using navigation
               navigationController!.pushViewController(detailController, animated: true)
    }
    


}
