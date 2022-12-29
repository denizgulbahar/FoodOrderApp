//
//  BeveragesViewController.swift
//  FoodOrderApp
//
//  Created by Deniz Gülbahar on 17.07.2022.
//

import UIKit
import Alamofire

class BeveragesViewController: UIViewController {

    private let tableViewBeverages:UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private var beverages = [Menu]()

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMenu()
        view.addSubview(tableViewBeverages)
        tableViewBeverages.delegate = self
        tableViewBeverages.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableViewBeverages.frame = view.bounds
    }


    private func fetchMenu() {
        Alamofire.request("https://raw.githubusercontent.com/adprm/json-food-menu-app/b59513bcc284d8e15bff697f5a9a79ba3e06b738/data/restaurantmenu.json",method: .get).responseJSON { response in
            
            if let data = response.data {
                
                do {
                    let response = try JSONDecoder().decode(MenuResponse.self, from: data)
                    if let receivedData = response.menu {
                        let filterData = receivedData.filter({$0.category!.contains("Burgers")})
                        self.beverages = filterData
                    }
                    DispatchQueue.main.async {
                        self.tableViewBeverages.reloadData()
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

extension BeveragesViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beverages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = beverages[indexPath.row]
        let cell = tableViewBeverages.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = model.name!
        return cell
    }

}

