//
//  SecondPageViewController.swift
//  GetMyAPI
//
//  Created by Joy on 2019/5/19.
//  Copyright © 2019 Joy. All rights reserved.
//

import UIKit

class SecondPageViewController: UIViewController {

    
    @IBOutlet weak var secondPageinputName: UITextField!
    @IBOutlet weak var secondPageinputPrice: UITextField!
    @IBOutlet weak var secondPageinputDescription: UITextField!
    @IBOutlet weak var secondPageinputImage: UITextField!
    
    var secondPageinputCategory = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        secondPageinputCategory = "咖啡"
        
    }
    
    
    @IBAction func clickSegment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            secondPageinputCategory = "咖啡"
        }else if sender.selectedSegmentIndex == 1 {
            secondPageinputCategory = "茶類"
        }else if sender.selectedSegmentIndex == 2 {
            secondPageinputCategory = "其他"
        }else {
            print("Segment error")
        }
    }
    
    
    
    
    
    
    
    
    @IBAction func clickDone(_ sender: UIButton) {
        
        let inName = secondPageinputName.text ?? ""
        let inPrice = secondPageinputPrice.text ?? ""
        let inDes = secondPageinputDescription.text ?? ""
        let inImg = secondPageinputImage.text ?? ""
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = Date()
        let dateString: String = formatter.string(from: date)
        
        
        let urlString = "https://sheetdb.io/api/v1/1r1l7igp0k6fo"
        
        let url = URL(string: urlString)
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let item = Item(product_name: inName, price: inPrice, img_url: inImg, category: secondPageinputCategory, description: inDes, date: dateString)
        
        let itemdata = ItemData(data: [item])
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(itemdata) {
            let task = URLSession.shared.uploadTask(with: urlRequest, from: data) { (returnData, response, error) in
                let decoder = JSONDecoder()
                
                if let returnData = returnData,
                    let dic = try? decoder.decode([String: Int].self, from: returnData),
                    dic["created"] == 1 {
                    
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                    
                }else{
                    print ("if let returnData = retrnData fail")
                }
            }
            task.resume()
        }else {
            print("encode fail")
        }
        
    }
    
    
    

}
