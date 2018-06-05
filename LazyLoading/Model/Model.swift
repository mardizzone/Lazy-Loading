//
//  Model.swift
//  LazyLoading
//
//  Created by Michael Ardizzone on 6/4/18.
//  Copyright © 2018 Michael Ardizzone. All rights reserved.
//

import Foundation

struct ProductResponse : Codable {
    
    let products : [Product]
    
    static func productsFromData(inputData: Data) -> [Product]? {
        do {
            let json = try JSONDecoder().decode(ProductResponse.self, from: inputData)
            return json.products
        } catch {
            print(error)
            return nil
        }
    }
}

struct Product : Codable {
    
    let productId : String
    let productName : String
    let shortDescription : String?
    let longDescription : String?
    let price : String
    let productImage : String
    let reviewRating : Double
    let reviewCount : Int
    let inStock : Bool
}
