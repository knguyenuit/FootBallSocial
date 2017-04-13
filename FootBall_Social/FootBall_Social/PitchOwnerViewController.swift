//
//  PitchOwnerViewController.swift
//  FootBall_Social
//
//  Created by Khanh Nguyen on 4/6/17.
//  Copyright © 2017 Khanh Nguyen. All rights reserved.
//

import UIKit

class PitchOwnerViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate {
   
    @IBOutlet weak var pickerViewLocation: UIPickerView!
    @IBOutlet weak var imgTest: UIImageView!
    @IBOutlet weak var textFieldPitchName: UITextField!
    @IBOutlet weak var textViewPriceBoard: UITextView!
    @IBOutlet weak var textFieldHourStart: UITextField!
    @IBOutlet weak var textFieldPrice: UITextField!
    @IBOutlet weak var textFieldHourEnd: UITextField!
    @IBOutlet weak var btnLocation: UIButton!

    
    var arrPriceBoard = [""]
        var dem = 1
    let pickerData = [
        ["Thủ Đức","Quận 1","Tân Bình","Bình Thạnh","Phú Nhuận"]
    ]
    
    
    @IBAction func btnLocationClick(_ sender: Any) {
        pickerViewLocation.isHidden = false
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData[component].count
    }
    
    func pickerView(_
        pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int
        ) -> String? {
        return pickerData[component][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let location = pickerData[0][pickerViewLocation.selectedRow(inComponent: 0)]
        btnLocation.setTitle(location, for: .normal)
        pickerViewLocation.isHidden = true
    }

    @IBAction func addToPriceBoard(_ sender: Any) {
        
        let priceHour = "\(textFieldHourStart.text!)" + "-" + "\(textFieldHourEnd.text!)" + ":" + "\(textFieldPrice.text!)" + "\n"
        arrPriceBoard.append(priceHour)
        
            textViewPriceBoard.text! = "\(textViewPriceBoard.text!)" + arrPriceBoard[dem]
        
            dem = dem + 1
        textFieldHourStart.text = ""
        textFieldHourEnd.text = ""
        textFieldPrice.text = ""
        //textViewPriceBoard.text = arrPriceBoard.description
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        pickerViewLocation.delegate = self
        pickerViewLocation.dataSource = self
        pickerViewLocation.isHidden = true
                // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
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
        
        myImageUploadRequest()
        picker.dismiss(animated: true, completion: nil)
    }
    
    func myImageUploadRequest()
    {
        
        let myUrl = NSURL(string: "http://cuong.freeiz.com/api/upload.php");

        
        let request = NSMutableURLRequest(url:myUrl! as URL);
        request.httpMethod = "POST";
        
        let param = [
//            "firstName"  : "Sergey",
//            "lastName"    : "Kargopolov",
//            "userId"    : "9"
            "pitch_name"  : "\(textFieldPitchName.text!)",
            "price"    : "\(textViewPriceBoard.text!)",
            "location"    : "\(btnLocation.titleLabel?.text!)"
        ]
        
        let boundary = generateBoundaryString()
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        
        let imageData = UIImageJPEGRepresentation(imgTest.image!, 1)
        
        if(imageData==nil)  { return; }
        
        request.httpBody = createBodyWithParameters(parameters: param, filePathKey: "file", imageDataKey: imageData! as NSData, boundary: boundary) as Data
        
        
//        myActivityIndicator.startAnimating();
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            // You can print out response object
            print("******* response = \(response)")
            
            // Print out reponse body
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("****** response data = \(responseString!)")
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                
                print(json)
                
                
                
            }catch
            {
                print(error)
            }
            
        }
        
        task.resume()
    }
    
    
    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
        let body = NSMutableData();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString(string: "--\(boundary)\r\n")
                body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString(string: "\(value)\r\n")
            }
        }
        
        let filename = "\(textFieldPitchName.text!).jpg"
        let mimetype = "image/jpg"
        body.appendString(string: "--\(boundary)\r\n")
        body.appendString(string: "Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
        body.append(imageDataKey as Data)
        body.appendString(string: "\r\n")
        
        
        
        body.appendString(string: "--\(boundary)--\r\n")
        
        return body
    }
    
    
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
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
extension NSMutableData {
    
    func appendString(string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
}
}
