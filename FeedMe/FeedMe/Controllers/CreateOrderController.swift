//
//  CreateOrderController.swift
//  FeedMe
//
//  Created by Nikita Kazakov on 22.04.2022.
//

import Foundation
import UIKit

class CreateOrderController: UIViewController {
    var header = ""
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var errorMessage: UILabel!
    
    var brands: [Brand] = []
    let apiClient = BrandApiClient()
    
    override func viewDidLoad() {
        headerLabel.text = header
        indicator.startAnimating()
        tableView.delegate = self
        tableView.dataSource = self
        errorMessage.isHidden = true
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            self.apiClient.getBrands(completion: {
                result in
                DispatchQueue.main.async {
                    self.indicator.stopAnimating()
                    switch result {
                    case .success(let brands):
                        self.brands = brands.map{ Brand(from: $0) }
                        self.tableView.reloadData()
                    case .failure(let error):
                        self.brands = []
                        self.tableView.reloadData()
                        self.errorMessage.isHidden = false
                        self.errorMessage.text = error.localizedDescription
                    }
                }
            })
        }
    }
}
extension CreateOrderController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
}

extension CreateOrderController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return brands.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let brandCell = tableView.dequeueReusableCell(withIdentifier: "bc", for: indexPath) as! BrandCell
        let item = brands[indexPath.row]
        brandCell.setInfo(name: item.name, rating: item.rating ?? -1)
        return brandCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250.0
    }
}
