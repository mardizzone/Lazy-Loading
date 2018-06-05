//
//  File.swift
//  LazyLoading
//
//  Created by Michael Ardizzone on 6/4/18.
//  Copyright © 2018 Michael Ardizzone. All rights reserved.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    let pageCount = 20
    var nextPageToLoad = 20
    var pagesAlreadyLoaded = [Int]()
    
    var cache = NSCache<AnyObject, AnyObject>()

    func loadNextPage(completionHandler: @escaping ([Product]) -> () ) {
        let url = URL(string: "https://mobile-tha-server.appspot.com/walmartproducts/1/\(pageCount)")
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            if let validData = data, let json = ProductResponse.productsFromData(inputData: validData) {
                self.pagesAlreadyLoaded.append(self.nextPageToLoad)
                self.nextPageToLoad += self.pageCount
                completionHandler(json)
            }
        }
        task.resume()
    }
    
    func shouldLoadNextPage(_ input: [[IndexPath]]) -> Bool {
        guard let lastnumber = getLastNumber(input) else {return false}
        if lastnumber + pageCount == nextPageToLoad  && !pagesAlreadyLoaded.contains(nextPageToLoad) {
            return true
        } else {
            return false
        }
        
    }

    func getLastNumber(_ input: [[IndexPath]]) -> Int? {
        guard let lastNumber = input.last?.last?.row else {return nil}
        return lastNumber + 1
    }


}
