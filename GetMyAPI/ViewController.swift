//
//  ViewController.swift
//  GetMyAPI
//
//  Created by Joy on 2019/5/18.
//  Copyright © 2019 Joy. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var firstPageTableView: UITableView!
    
    

    var items = [Item]()
    let activityIndicatorView = UIActivityIndicatorView(style: .gray)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(activityIndicatorView)
        activityIndicatorView.center = view.center
        
        activityIndicatorView.startAnimating()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getMySource()
    }


 
    
    
    func getMySource() {
        let urlString = "https://sheetdb.io/api/v1/1r1l7igp0k6fo"
        
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { (data, response
                , error) in
                if let data = data {
                    let decoder = JSONDecoder()
                    
//                    do {
//                        self.items = try decoder.decode([Item].self, from: data)
//                        print("OK")
//                    }catch{
//                        print(error)
//                    }
                    
                    
                    
                    if let items = try? decoder.decode([Item].self, from: data) {
                        self.items = items
                        DispatchQueue.main.async {
                            self.activityIndicatorView.removeFromSuperview()
                            self.firstPageTableView.reloadData()
                        }
                        
                    }
                }else {
                    print("let data = data fail")
                }
            }
            task.resume()
        }else {
            print("url trans fail")
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(items.count)
        return items.count
    }
    

    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = firstPageTableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! MyTableViewCell
        let item = items[indexPath.row]
        cell.firstPageName.text = "品項：\(item.product_name)"
        cell.firstPagePrice.text = "價格： $\(item.price)"
        

        
        if let url = URL(string: item.img_url) {
           let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
               if let data = data {
                DispatchQueue.main.async {
                    cell.firstPageImageView.image = UIImage(data: data)
                }
               }else{
                print("image : let data = data fail")
               }
            }
            task.resume()
        }else{
            print ("image url fail")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            let item = self.items[indexPath.row]
            
            print(item.product_name)
            let urlString = "https://sheetdb.io/api/v1/1r1l7igp0k6fo/product_name/\(item.product_name)"
            print(urlString)
            let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
            var urlRequest = URLRequest(url: url!)
            urlRequest.httpMethod = "DELETE"
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let itemdata = ItemData(data: [item])
            let encoder = JSONEncoder()
            if let data = try? encoder.encode(itemdata) {
                let task = URLSession.shared.uploadTask(with: urlRequest, from: data) { (returnData, response, error) in
                    let decoder = JSONDecoder()
                    if let returnData = returnData,
                        let dic = try? decoder.decode([String: Int].self, from: returnData),
                        dic["deleted"] == 1 {
                    }
                }
                task.resume()
                self.items.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                print("remove success")
                
            }else {
                print("encode fail")
            }
            
            
        }
        
        
        return [delete]
    }
    
  
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoAddPage" {
            //..
        }else if segue.identifier == "gotoDetailPage" {
            if let row = self.firstPageTableView.indexPathForSelectedRow?.row {
               let controller = segue.destination as! DetailViewController
                   controller.item = items[row]
            }
        }else {
            print("segue fail")
        }

    }
    
    
    
    
}

//merica = https://img.gta5-mods.com/q95/images/hot-coffee/dccff7-bigstock-Coffee-cup-on-white-background-27307763.jpg
//milk tea= https://i.dailymail.co.uk/1s/2019/01/04/09/8121480-6557151-image-a-1_1546595792530.jpg
//http://ku.90sjimg.com/element_origin_min_pic/17/03/07/9ea1730a8d3d5e0ccf91a8871ac6a4da.jpg
//expresso =https://www.delonghi.com/Global/recipes/Coffee/espresso.png
//H2=https://www.nespresso.com/shared_res/agility/coffeeHouses/coffeeHouses/img/hero/cup_lungo_L.png
//capo=http://cdn.marksdailyapple.com/wordpress/wp-content/themes/Marks-Daily-Apple-Responsive/images/blog2/coffee.jpg
//柚子茶＝https://media.gettyimages.com/photos/cup-of-tea-picture-id183029979?b=1&k=6&m=183029979&s=612x612&w=0&h=Q86cMwfJky_VnGgm_eM2wGq1xU4S7m20gl-dEHlKKfk=
//black tea=https://image.shutterstock.com/image-photo/cup-tea-isolated-on-white-260nw-418573330.jpg
//green tea=https://botanwang.com/sites/default/files/field/image/1-1254659541Lrty.jpg?itok=KGIIpXJR
//coffee=https://img.gta5-mods.com/q95/images/hot-coffee/dccff7-bigstock-Coffee-cup-on-white-background-27307763.jpg
//latte=https://ku.90sjimg.com/element_origin_min_pic/17/03/07/9ea1730a8d3d5e0ccf91a8871ac6a4da.jpg
