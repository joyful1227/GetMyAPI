//
//  DetailViewController.swift
//  GetMyAPI
//
//  Created by Joy on 2019/5/19.
//  Copyright © 2019 Joy. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    
    
    @IBOutlet weak var detailImageView: UIImageView!
    
    @IBOutlet weak var detailoutputName: UILabel!
    @IBOutlet weak var detailoutputPrice: UILabel!
    @IBOutlet weak var detailoutputDate: UILabel!
    @IBOutlet weak var detailoutputCategory: UILabel!
    @IBOutlet weak var detailoutputDescription: UILabel!
    
    var item:Item?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let item = item {
            self.title = item.product_name
            detailoutputName.text = "品項：\(item.product_name)"
            detailoutputPrice.text = "價格： $\(item.price)"
            detailoutputDate.text = "上架日期： \(item.date)"
            detailoutputCategory.text = "分類： \(item.category)"
            detailoutputDescription.text = "描述：\(item.description)"
            
            if let url = URL(string: item.img_url) {
              let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    DispatchQueue.main.async {
                        self.detailImageView.image = UIImage(data: data)
                    }
                }
              }
              task.resume()
            }
            
        }
    }
    

    

}
