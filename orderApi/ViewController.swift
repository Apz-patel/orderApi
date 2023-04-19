//
//  ViewController.swift
//  orderApi
//
//  Created by ved katrodiya on 14/02/23.
//

import UIKit

class ViewController: UIViewController {
    var arrorders: [Data] = []
    @IBOutlet weak var bgLabel: UILabel!
    @IBOutlet weak var ordersTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        users()
        design()
    }
    func design (){
        bgLabel.layer.cornerRadius = 45
        bgLabel.layer.masksToBounds = true
    }
    private func users() {
        let url = URL(string: "https://myct.store/Mobile_Services/user/v2/index.php/get_order/8-")
        
        let dataTask = URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            guard let data = data,error == nil else
            {
                print ("Error Occured While Accessing Data with URL")
                return
            }
            var orderList: OrderApi?
            do{
                orderList = try JSONDecoder().decode( OrderApi.self, from: data)
            }
            catch{
                print("error")
            }
            self.arrorders = orderList!.data
            DispatchQueue.main.async {
                self.ordersTableView.reloadData()
            }
        })
        dataTask.resume()
    }
}




struct OrderApi: Decodable{
    var error: Bool
    var data: [Data]
}

struct Data: Decodable{
    var orderId: String
    var totalPrice: String
    var dateTime: String
    var vImage: String
    var orderStatus: String
    var vName : String
    
    private enum CodingKeys: String, CodingKey{
        case orderId = "order_id"
        case totalPrice = "total_price"
        case dateTime = "date_time"
        case vImage = "vimage"
        case orderStatus = "oreder_status"
        case vName = "vname"
    }
    init(from decoder: Decoder) throws{
        let values = try decoder.container (keyedBy: CodingKeys.self)
        vName = try values.decode (String.self, forKey:.vName)
        orderId = try values.decode (String.self, forKey:.orderId)
        orderStatus = try values.decode (String.self, forKey:.orderStatus)
        totalPrice = try values.decode (String.self, forKey:.totalPrice)
        dateTime = try values.decode (String.self, forKey:.dateTime)
        vImage = try values.decode (String.self, forKey:.vImage)
  
    }

}
extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrorders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ordersTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OrderTableViewCell
        let user = arrorders[indexPath.row]
        cell.sellerName.text = user.vName
        cell.orderId.text = user.orderId
        cell.dateTime.text = ("📆\(user.dateTime)")
        cell.orderStatus.text = user.orderStatus
        cell.paymentAmount.text = ("payment Amount : $\(user.totalPrice)")
       
        return cell
    }
}
