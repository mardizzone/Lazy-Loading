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
    //data is being passed!
    
    var productForDetail : Product?
    
    @IBOutlet weak var longDescriptionWebView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var html = "<html>"
        html += "<head>"
        html += "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">"
        html += "<style> body { font-size: 100%; } </style>"
        html += "</head>"
        html += "<body>"
        html += productForDetail!.longDescription!
        html += "</body>"
        html += "</html>"
        
        
        longDescriptionWebView.loadHTMLString(html, baseURL: nil)
    
    }

    

}
