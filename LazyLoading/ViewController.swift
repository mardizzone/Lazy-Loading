//
//  ViewController.swift
//  LazyLoading
//
//  Created by Michael Ardizzone on 6/4/18.
//  Copyright © 2018 Michael Ardizzone. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSourcePrefetching, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var myTableView: UITableView!
    
    var productsArray = [Product]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! ProductTableViewCell
        cell.configure(with: productsArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if NetWorkManager.shared.shouldLoadNextPage([indexPaths]) {
            NetWorkManager.shared.loadNextPage { products in
                self.productsArray = self.productsArray + products
                DispatchQueue.main.sync {
                    self.myTableView.reloadData()
                }
            }
        }
        
        //if NetWorkManager.shared.shouldLoadNextPage([indexPaths]) {
//            let newDownloadedData = NetWorkManager.shared.loadNextPage()
//            numberArray = numberArray + newDownloadedData
//            myTableView.reloadData()
//        }
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.rowHeight = UITableViewAutomaticDimension
        NetWorkManager.shared.loadNextPage { products in
            self.productsArray = self.productsArray + products
            DispatchQueue.main.async {
                self.myTableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

