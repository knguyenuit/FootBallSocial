//
//  ViewController.swift
//  FootBall_Social
//
//  Created by Khanh Nguyen on 4/2/17.
//  Copyright © 2017 Khanh Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textFieldUser: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBAction func Login(_ sender: Any) {
        //put the link of the php file here. The php file connects the mysql and swift
        let request = NSMutableURLRequest(url: NSURL(string: "http://cuong.freeiz.com/api/?action=login")! as URL)
        request.httpMethod = "POST"
        
        let postString = "user_name=\(textFieldUser.text!)&user_password=\(textFieldPassword.text!)"
        
        
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            
            
            
            
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("responseString = \(responseString!)")
            //            let stringReponse = String(describing: responseString!)
            //            let dict = self.convertToDictionary(text:stringReponse)
            //            let temp = dict!["code"]! as? String
            //            let a = Int(temp!)
            //            if a == 200{
            //                print("Go to main screen")
            //            }
            
            //            if let json = try? JSONSerialization.data(withJSONObject: dict, options: []) {
            //                if let content = String(data: json, encoding: String.Encoding.utf8) {
            //
            //                    print(content)
            //                }
            //            }
            
            
        }
        task.resume()
        
        //        let url = URL(string: "http://rectangletest.byethost7.com/testpost.php")
        //        URLSession.shared.dataTask(with:url!, completionHandler: {(data, response, error) in
        //            guard let data = data, error == nil else { return }
        //
        //            do {
        //                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
        //                let posts = json["posts"] as? [[String: Any]] ?? []
        //                print(posts)
        //            } catch let error as NSError {
        //                print(error)
        //            }
        //        }).resume()
        
        
        //        let url:URL = URL(string: "http://jsonplaceholder.typicode.com/posts")!
        //        let session = URLSession.shared
        //
        //        var request = URLRequest(url: url)
        //        request.httpMethod = "POST"
        //        //request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        //
        //        let paramString = "data=nguyen"
        //        request.httpBody = paramString.data(using: String.Encoding.utf8)
        //
        //        let task = session.dataTask(with: request as URLRequest) {
        //            (
        //            data, response, error) in
        //
        //            guard let data = data, let _:URLResponse = response, error == nil else {
        //                print("error")
        //                return
        //            }
        //
        //            let dataString =  String(data: data, encoding: String.Encoding.utf8)
        //            print(dataString)
        //
        //        }
        //
        //        task.resume()
        
        let alertController = UIAlertController(title: "Candidate's Name", message:
            "Successfully Added", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
        
        textFieldUser.text = ""
        textFieldPassword.text = ""

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

