//
//  DetailViewController.swift
//  LazyLoading
//
//  Created by Michael Ardizzone on 6/4/18.
//  Copyright © 2018 Michael Ardizzone. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var longDescriptionWebView: WKWebView!
    
    var productForDetail : Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureScreen(baseProduct: productForDetail)
    }
    
    func configureScreen(baseProduct: Product?) {
        guard let productObject = baseProduct else {return}
        productTitleLabel.text = productObject.productName
        productImageView.downloadImage(from: productObject.productImage, contentMode: UIViewContentMode.scaleAspectFit)
        productPriceLabel.text = productObject.price
        constructLongDescriptionWebView()
    }

    func constructLongDescriptionWebView() {
        //this will enlarge the font in the webview enough to make it readable
        guard let htmlFromProduct = productForDetail?.longDescription else {return}
        var html = "<html>"
        html += "<head>"
        html += "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">"
        html += "<style> body { font-size: 100%; } </style>"
        html += "</head>"
        html += "<body>"
        html += htmlFromProduct
        html += "</body>"
        html += "</html>"
        longDescriptionWebView.loadHTMLString(html, baseURL: nil)
    }

}
