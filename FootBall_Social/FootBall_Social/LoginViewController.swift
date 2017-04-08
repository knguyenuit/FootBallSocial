//
//  LoginViewController.swift
//  FootBall_Social
//
//  Created by Khanh Nguyen on 4/5/17.
//  Copyright © 2017 Khanh Nguyen. All rights reserved.
//

import UIKit
import Foundation
import MBProgressHUD

class LoginViewController: UIViewController {

    var isLogin = false
    
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldUser: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

       
        // Do any additional setup after loading the view.
    }

    
    @IBAction func Test(_ sender: Any) {
                print("test click")
        
    }
    
    @IBAction func Login(_ sender: Any) {
        
                //put the link of the php file here. The php file connects the mysql and swift
        //MBProgressHUD.showAdded(to: self.view, animated: true)
        let request = NSMutableURLRequest(url: NSURL(string: "http://cuong.freeiz.com/api/login.php")! as URL)
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
            let stringReponse = String(describing: responseString!)
            let dict = self.convertToDictionary(text:stringReponse)
            let temp = dict!["code"]! as? Int
            if temp! == 0 {
                
                
              let storyboard = UIStoryboard(name: "Main", bundle: nil)
                
              let vc = storyboard.instantiateViewController(withIdentifier: "RegisterView")
              self.present(vc, animated: true, completion: self.stopMBprogress)
            }
            
            
            
        }
        
        task.resume()
        
        

        
        textFieldUser.text = ""
        textFieldPassword.text = ""
    }
    
    func stopMBprogress(){
        //MBProgressHUD.hide(for: self.view, animated: true)
        let alertController = UIAlertController(title: "Login", message:
            "Login Successfull", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)

    }
   
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
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
