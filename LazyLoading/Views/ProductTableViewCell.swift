//
//  ProductTableViewCell.swift
//  LazyLoading
//
//  Created by Michael Ardizzone on 6/4/18.
//  Copyright © 2018 Michael Ardizzone. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    var productForCell : Product?
    
    func configure(with product: Product) {
        productNameLabel.text = product.productName
        self.productForCell = product
        priceLabel.text = product.price
        productImageView.image = nil
        productImageView.downloadImage(from: product.productImage, contentMode: UIViewContentMode.scaleAspectFit)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
