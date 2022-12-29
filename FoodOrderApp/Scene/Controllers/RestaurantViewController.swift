//
//  ViewController.swift
//  FoodOrderApp
//
//  Created by Deniz Gülbahar on 18.07.2022.
//

import UIKit
import Alamofire

class RestaurantViewController: UIViewController {
    
    private var alldata = [[Menu]]()
    
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
    
    let basketPriceButton:UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemRed
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMenu()
        view.backgroundColor = UIColor(red:1 , green: 1, blue: 1, alpha: 1)
        viewSubviews()
        tableViewMenu.delegate = self
        tableViewMenu.dataSource = self
        self.navigationItem.hidesBackButton = true
        configuremodels()
    }
    
    private func viewSubviews() {
        view.addSubview(tableViewMenu)
        view.addSubview(restaurantNameLabel)
        view.addSubview(minDeliveryPriceLabel)
        view.addSubview(scoreLabel)
        view.addSubview(deliveryTimeLabel)
        view.addSubview(RestaurantimageView)
        if totalBasketAmount != 0 {
        view.addSubview(basketPriceButton)
        }
    }
    
    @objc private func basketAmount() {
        let vc = PaymentViewController()
        vc.title = "Payment"
        vc.totalBasketAmount = totalBasketAmount
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        RestaurantimageView.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height/5)
        restaurantNameLabel.frame = CGRect(x: 10, y: RestaurantimageView.bottom+10, width: view.width, height: 40)
        minDeliveryPriceLabel.frame = CGRect(x: 10, y: restaurantNameLabel.bottom, width: view.width, height: 40)
        scoreLabel.frame = CGRect(x: 10, y: minDeliveryPriceLabel.bottom, width: view.width, height: 40)
        deliveryTimeLabel.frame = CGRect(x: 10, y: scoreLabel.bottom, width: view.width, height: 40)
        tableViewMenu.frame = CGRect(x: 5, y: deliveryTimeLabel.bottom+10, width: view.width-10, height: view.height-150-view.height/5)
        basketPriceButton.frame = CGRect(x: 40, y: view.bottom-100, width: view.width-80, height: 40)
        
        
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
                        self.alldata.append(filterData1)
                        self.alldata.append(filterData2)
                        self.alldata.append(filterData3)
                        self.alldata.append(filterData4)
                        self.alldata.append(filterData5)
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
    
    private func configuremodels() {
        RestaurantimageView.image = UIImage(named: "chetto.png")
        restaurantNameLabel.text = "Chetto Restaurant"
        minDeliveryPriceLabel.text = "Minimum Basket Price: 50 $"
        scoreLabel.text = "Restaurant Score: 9.2/10"
        deliveryTimeLabel.text = "Estimated Delivery : 40 min."
        basketPriceButton.setTitle("Basket Price: \(totalBasketAmount) $", for: .normal)
        basketPriceButton.addTarget(self, action: #selector(basketAmount), for: .touchUpInside)
    }
    
}

extension RestaurantViewController:UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return alldata.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alldata[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = alldata[indexPath.section][indexPath.row]
        let cell = tableViewMenu.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        cell.configure(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableViewMenu.deselectRow(at: indexPath, animated: false)
        let model = alldata[indexPath.section][indexPath.row]
        let vc = DetailsViewController()
        vc.model = model
        vc.totalBasketAmounts = totalBasketAmount
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





