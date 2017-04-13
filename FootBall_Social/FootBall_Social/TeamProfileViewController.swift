//
//  TeamProfileViewController.swift
//  FootBall_Social
//
//  Created by Khanh Nguyen on 4/9/17.
//  Copyright © 2017 Khanh Nguyen. All rights reserved.
//

import UIKit

class TeamProfileViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {

    @IBOutlet weak var btnLocation: UIButton!
    @IBOutlet weak var btnLevel: UIButton!
    @IBOutlet weak var pickerViewLevel: UIPickerView!
    
    let pickerDataLocation = [
        ["Thủ Đức","Quận 1","Tân Bình","Bình Thạnh","Phú Nhuận"]
    ]
    
    let pickerDataLevel = [
        ["A","B","C","D","E"]
    ]
    
    var isLocation = false
    var isLevel = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerViewLevel.isHidden = true
        pickerViewLevel.delegate = self
        pickerViewLevel.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnLocationClick(_ sender: Any) {
        //pickerData = pickerDataLocation as! [String]
        
        isLocation = true
        isLevel = false
        pickerViewLevel.reloadAllComponents()

        pickerViewLevel.isHidden = false
}

    @IBAction func btnLevelClick(_ sender: Any) {
        //pickerData = pickerDataLevel as! [String]
        
        isLocation = false
        isLevel = true
        pickerViewLevel.reloadAllComponents()
        pickerViewLevel.isHidden = false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if isLocation == true{
        return pickerDataLocation.count
        }
        else{
        return pickerDataLevel.count
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if isLocation == true{
            return pickerDataLocation[component].count
        }
        else{
            return pickerDataLevel[component].count
        }
    }
    
    func pickerView(_
        pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int
        ) -> String? {
        if isLocation == true{
            return pickerDataLocation[component][row]
        }
        else{
            return pickerDataLevel[component][row]
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if isLocation == true {
        let location = pickerDataLocation[0][pickerViewLevel.selectedRow(inComponent: 0)]
        btnLocation.setTitle(location, for: .normal)
        
        }
        else{
            let level = pickerDataLevel[0][pickerViewLevel.selectedRow(inComponent: 0)]
            btnLevel.setTitle(level, for: .normal)
            

        }
        pickerViewLevel.isHidden = true
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
