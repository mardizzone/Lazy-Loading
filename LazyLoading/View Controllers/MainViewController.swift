//
//  ViewController.swift
//  LazyLoading
//
//  Created by Michael Ardizzone on 6/4/18.
//  Copyright © 2018 Michael Ardizzone. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var myTableView: UITableView!
    
    var productsArray = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        populateTableView()
    }

}

//MARK: - TableView Methods
extension MainViewController:  UITableViewDataSourcePrefetching, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! ProductTableViewCell
        cell.configure(with: productsArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if NetworkManager.shared.shouldLoadNextPage([indexPaths]) {
            addLoadedDataToTableView()
        }
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
    }
    
}

//MARK: - Data Passer
extension MainViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let sendingTableViewCell = sender as! ProductTableViewCell
        let desinationSegue = segue.destination as! DetailViewController
        desinationSegue.productForDetail = sendingTableViewCell.productForCell
    }
    
}

//MARK: - Helper Methods
extension MainViewController {
    func configureTableView() {
        myTableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func populateTableView() {
        NetworkManager.shared.loadNextPage { products in
            self.productsArray = self.productsArray + products
            DispatchQueue.main.async {
                self.myTableView.reloadData()
            }
        }
    }
    
    func addLoadedDataToTableView() {
        NetworkManager.shared.loadNextPage { products in
            self.productsArray = self.productsArray + products
            DispatchQueue.main.sync {
                self.myTableView.reloadData()
            }
        }
    }
    
}
