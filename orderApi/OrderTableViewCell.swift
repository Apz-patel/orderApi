//
//  OrderTableViewCell.swift
//  orderApi
//
//  Created by ved katrodiya on 15/02/23.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
    
    @IBOutlet var orderButton: UIButton!
    @IBOutlet weak var paymentAmount: UILabel!
    @IBOutlet weak var sellerName: UILabel!
  
    @IBOutlet weak var orderStatus: UILabel!
    @IBOutlet weak var dateTime: UILabel!
    @IBOutlet weak var orderId: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
