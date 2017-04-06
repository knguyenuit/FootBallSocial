//
//  PitchOwnerViewController.swift
//  FootBall_Social
//
//  Created by Khanh Nguyen on 4/6/17.
//  Copyright © 2017 Khanh Nguyen. All rights reserved.
//

import UIKit

class PitchOwnerViewController: UIViewController,UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    @IBOutlet weak var imgTest: UIImageView!

    @IBAction func uploadImage(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imgTest.contentMode = .scaleToFill
            imgTest.image = pickedImage
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        imgTest.image = #imageLiteral(resourceName: "nguyen")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
