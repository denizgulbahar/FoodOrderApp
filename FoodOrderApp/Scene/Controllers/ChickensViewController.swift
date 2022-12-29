//
//  ChickensViewController.swift
//  FoodOrderApp
//
//  Created by Deniz Gülbahar on 17.07.2022.
//

import UIKit
import Alamofire

class ChickensViewController: UIViewController {

    private let tableViewChickens:UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private var chickens = [Menu]()

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMenu()
        view.addSubview(tableViewChickens)
        tableViewChickens.delegate = self
        tableViewChickens.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableViewChickens.frame = view.bounds
    }


    private func fetchMenu() {
        Alamofire.request("https://raw.githubusercontent.com/adprm/json-food-menu-app/b59513bcc284d8e15bff697f5a9a79ba3e06b738/data/restaurantmenu.json",method: .get).responseJSON { response in
            
            if let data = response.data {
                
                do {
                    let response = try JSONDecoder().decode(MenuResponse.self, from: data)
                    if let receivedData = response.menu {
                        let filterData = receivedData.filter({$0.category!.contains("Burgers")})
                        self.chickens = filterData
                    }
                    DispatchQueue.main.async {
                        self.tableViewChickens.reloadData()
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

extension ChickensViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chickens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = chickens[indexPath.row]
        let cell = tableViewChickens.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = model.name!
        return cell
    }

}

