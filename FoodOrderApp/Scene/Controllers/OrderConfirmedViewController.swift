//
//  OrderConfirmedViewController.swift
//  FoodOrderApp
//
//  Created by Deniz Gülbahar on 21.07.2022.
//

import UIKit

class OrderConfirmedViewController: UIViewController {

    private let orderConfirmedLabel:UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        return label
    }()
    
    private let thanksLabel:UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 22, weight: .regular)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonTitle = ""
        view.backgroundColor = .white
        view.addSubview(orderConfirmedLabel)
        view.addSubview(thanksLabel)
        configureModels()
    }
    private func configureModels() {
        orderConfirmedLabel.text = "Your order has been received."
        thanksLabel.text = "Thank you for choosing us!"
    }
    
    override func viewDidLayoutSubviews() {
        orderConfirmedLabel.frame = CGRect(x: 40, y: view.height/6, width: view.width, height: 60)
        thanksLabel.frame = CGRect(x: 40, y: view.height/3, width: view.width-80, height: 60)
    }

}
