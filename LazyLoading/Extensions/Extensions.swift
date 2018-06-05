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
        if let img = NetworkManager.shared.cache.object(forKey: link as AnyObject) {
            self.image = img as? UIImage
        } else {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
                DispatchQueue.main.async {
                    self.contentMode = contentMode
                    if let data = data {
                        let downloadedImage = UIImage(data: data)
                        self.image = downloadedImage
                        if let unwrappedImage = downloadedImage {
                            NetworkManager.shared.cache.setObject(unwrappedImage, forKey: link as AnyObject)
                        }
                    }
                }
            }).resume()
        }
    }
    
}
