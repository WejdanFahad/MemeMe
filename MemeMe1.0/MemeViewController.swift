//
//  ViewController.swift
//  MemeMe1.0
//
//  Created by Wejdan on 05/10/1441 AH.
//  Copyright © 1441 Udacity. All rights reserved.
//

import UIKit

class MemeViewController: UIViewController , UIImagePickerControllerDelegate,
UINavigationControllerDelegate , UITextFieldDelegate {

    // MARK: Outlets
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    //Set textField TextAttributes
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth: -5.0
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextField(topTextField)
        setupTextField(bottomTextField)
        
    }
    
    func setupTextField(_ textField: UITextField) {
        textField.delegate = self
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .center
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //camera support check
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        //subscribe Keyboard Notifications
        subscribeToKeyboardNotifications()
     
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //unsubscribe Keyboard Notifications
        unsubscribeToKeyboardNotifications()
    }

    // MARK: UIImagePicker functions
    func pickFromSource(_ source: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self;
        imagePicker.sourceType = source
        present(imagePicker, animated: true, completion: nil)
    }

    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        pickFromSource(.photoLibrary)
    }

    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        pickFromSource(.camera)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imagePickerView.image = image
        }
        updateUI()
        dismiss(animated: true, completion: nil)
    }
    
   // MARK: textField delagate methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == K.topText || textField.text == K.bottomText{
        textField.text = ""
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if topTextField.text == "" {topTextField.text = K.topText}
        if bottomTextField.text == "" {bottomTextField.text = K.bottomText}
    }
    
    
    // MARK:KeyboardNotifications functions
    func subscribeToKeyboardNotifications() {
          
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeToKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
               
        NotificationCenter.default.removeObserver(self , name:UIResponder.keyboardWillHideNotification ,object: nil)
        
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        
        if bottomTextField.isFirstResponder {
            let keyboardSize = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
            view.frame.origin.y -= keyboardSize.cgRectValue.height
        }
        
       
    }
    
    @objc func keyboardWillHide(notification: Notification) {
       
            view.frame.origin.y = 0
    }
    
    // MARK: Generate \Save Meme Functions
    func generateMemedImage() -> UIImage {

        //hide nav and toolbar
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        toolBar.isHidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        //show nav and toolbar
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        toolBar.isHidden = false

        return memedImage
    }
    
    func saveMeme()  {
            // Create the meme
            let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imagePickerView.image!, memedImage: generateMemedImage())

    }
    
    // MARK: Share Meme function
    @IBAction func shareMeme (_ sender: Any) {
        
        let memeImage = generateMemedImage()
        
        
        let activityItem: [UIImage] = [memeImage as UIImage]

        let activityVC = UIActivityViewController(activityItems: activityItem as [UIImage], applicationActivities: nil)

        activityVC.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in

            // Return if cancelled
                if (!completed) {
                    return
                }
            
            self.saveMeme()
        }
        self.present(activityVC, animated: true, completion: nil)
        
    }
    
    func updateUI() {
        shareButton.isEnabled = !( self.imagePickerView.image == nil)
    }
    
    
}

