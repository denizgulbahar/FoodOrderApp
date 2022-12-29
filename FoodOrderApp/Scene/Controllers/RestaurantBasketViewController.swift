//
//  RestaurantBasketViewController.swift
//  MVCFoodOrderApp
//
//  Created by Deniz Gülbahar on 20.07.2022.
//

import UIKit
import Alamofire

class RestaurantBasketViewController: UIViewController {
        
        private var alldatas = [[Menu]]()
        
        public var totalBasketAmount:Int = 0

        private let tableViewMenu:UITableView = {
            let tableView = UITableView(frame: .zero, style: .grouped)
            tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
            return tableView
        }()
        
        private let restaurantNameLabel:UILabel = {
            let label = UILabel()
            label.textColor = .black
            label.font = .systemFont(ofSize: 20, weight: .bold)
            label.textAlignment = .left
            label.numberOfLines = 1
            return label
        }()
        
        private let minDeliveryPriceLabel:UILabel = {
            let label = UILabel()
            label.textColor = .black
            label.numberOfLines = 0
            label.textAlignment = .left
            return label
        }()
        
        private let scoreLabel:UILabel = {
            let label = UILabel()
            label.textColor = .black
            label.numberOfLines = 1
            label.textAlignment = .left
            label.font = .systemFont(ofSize: 18, weight: .regular)
            return label
        }()
        
        private let deliveryTimeLabel:UILabel = {
            let label = UILabel()
            label.textColor = .black
            label.numberOfLines = 1
            label.textAlignment = .left
            label.font = .systemFont(ofSize: 18, weight: .semibold)
            return label
        }()
        
        private let RestaurantimageView:UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            return imageView
        }()
    
  

        override func viewDidLoad() {
            super.viewDidLoad()
            fetchMenu()
            view.backgroundColor = UIColor(red:1 , green: 1, blue: 1, alpha: 1)
            view.addSubview(tableViewMenu)
            view.addSubview(restaurantNameLabel)
            view.addSubview(minDeliveryPriceLabel)
            view.addSubview(scoreLabel)
            view.addSubview(deliveryTimeLabel)
            view.addSubview(RestaurantimageView)
            tableViewMenu.delegate = self
            tableViewMenu.dataSource = self
            self.navigationItem.hidesBackButton = true
            configuremodels()
        }
        
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            RestaurantimageView.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height/5)
            restaurantNameLabel.frame = CGRect(x: 10, y: RestaurantimageView.bottom+20, width: view.width, height: 40)
            minDeliveryPriceLabel.frame = CGRect(x: 10, y: restaurantNameLabel.bottom+10, width: view.width, height: 40)
            scoreLabel.frame = CGRect(x: 20, y: minDeliveryPriceLabel.bottom+10, width: view.width, height: 40)
            deliveryTimeLabel.frame = CGRect(x: 10, y: scoreLabel.bottom+10, width: view.width, height: 40)
            tableViewMenu.frame = CGRect(x: 5, y: deliveryTimeLabel.bottom+10, width: view.width-10, height: view.height-150-view.height/5)
        }


        private func fetchMenu() {
            Alamofire.request("https://raw.githubusercontent.com/adprm/json-food-menu-app/b59513bcc284d8e15bff697f5a9a79ba3e06b738/data/restaurantmenu.json",method: .get).responseJSON { response in
                
                if let data = response.data {
                    
                    do {
                        let response = try JSONDecoder().decode(MenuResponse.self, from: data)
                        if let receivedData = response.menu {
                            let filterData1 = receivedData.filter({$0.category!.contains("Burgers")})
                            let filterData2 = receivedData.filter({$0.category!.contains("Chicken")})
                            let filterData3 = receivedData.filter({$0.category!.contains("Fish")})
                            let filterData4 = receivedData.filter({$0.category!.contains("Dessert")})
                            let filterData5 = receivedData.filter({$0.category!.contains("Beverage")})
                            self.alldatas.append(filterData1)
                            self.alldatas.append(filterData2)
                            self.alldatas.append(filterData3)
                            self.alldatas.append(filterData4)
                            self.alldatas.append(filterData5)
                        }
                        DispatchQueue.main.async {
                            self.tableViewMenu.reloadData()
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
       }
        
        public func configuremodels() {
            RestaurantimageView.image = UIImage(named: "chetto.png")
            restaurantNameLabel.text = "Chetto Restaurant"
            minDeliveryPriceLabel.text = "50 $"
            scoreLabel.text = "9.2/10 "
            deliveryTimeLabel.text = "Delivery: 40 min."
        }
        
    }

    extension RestaurantBasketViewController:UITableViewDelegate,UITableViewDataSource {
        func numberOfSections(in tableView: UITableView) -> Int {
            return alldatas.count
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return alldatas[section].count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let model = alldatas[indexPath.section][indexPath.row]
            let cell = tableViewMenu.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
            cell.configure(with: model)
            cell.layer.cornerRadius = 2
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableViewMenu.deselectRow(at: indexPath, animated: true)
            let model = alldatas[indexPath.section][indexPath.row]
            let vc = DetailsViewController()
            vc.totalBasketAmount = totalBasketAmount
            vc.model = model
            vc.title = "Product Details"
            navigationItem.backButtonTitle = ""
            navigationController?.pushViewController(vc, animated: true)
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 150
        }
        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            if section == 0 {
                return "BURGERS"
            }
            if section == 1 {
                return "CHICKENS"
            }
            if section == 2 {
                return "FISH"
            }
            if section == 3 {
                return "DESSERTS"
            }
            if section == 4 {
                return "BEVERAGES"
            }
         return ""
        }
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 40
        }
       
    }



