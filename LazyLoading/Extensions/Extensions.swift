//
//  Extensions.swift
//  LazyLoading
//
//  Created by Michael Ardizzone on 6/4/18.
//  Copyright © 2018 Michael Ardizzone. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func downloadImage(from link: String, contentMode: UIViewContentMode) {
        let baseString = "https://mobile-tha-server.appspot.com" + link
        guard let url = URL(string: baseString) else { return }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
            DispatchQueue.main.async {
                self.contentMode = contentMode
                if let data = data {
                    self.image = UIImage(data: data)
                }
            }
        }).resume()
    }
}
