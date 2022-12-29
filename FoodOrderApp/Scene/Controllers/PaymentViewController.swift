//
//  PaymentViewController.swift
//  FoodOrderApp
//
//  Created by Deniz Gülbahar on 20.07.2022.
//

import UIKit

class PaymentViewController: UIViewController {
    
    public var totalBasketAmount:Int = 0

    private let deliveryTimeLabel:UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    private let subtotalLabel:UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private let totalLabel:UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    
    private let sendingPriceLabel:UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    private let needSwitch:UISwitch = {
        let needswitch = UISwitch()
        return needswitch
    }()
    
    private let forkKnifeLabel:UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    private let forkKnifeNeedLabel:UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    private let basketAmountLabel:UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    private let basketConfirmButton:UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemRed
        return button
    }()
    
    private let clearBasketButton:UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.textAlignment = .center
        return button
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonTitle = ""
        view.backgroundColor = .white
        viewSubviews()
        basketConfirmButton.addTarget(self, action: #selector(basketConfirm), for: .touchUpInside)
        clearBasketButton.addTarget(self, action: #selector(clearBasket), for: .touchUpInside)
        configuremodels()
    }
    
    @objc private func basketConfirm() {
        if totalBasketAmount >= 50 {
            let vc = OrderConfirmedViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc private func clearBasket() {
        totalBasketAmount = 0
        let vc = RestaurantViewController()
        vc.totalBasketAmount = 0
        navigationController?.pushViewController(vc, animated: true)
        let vc1 = PaymentViewController()
        vc1.totalBasketAmount = 0
    }
    
    private func viewSubviews() {
        view.addSubview(deliveryTimeLabel)
        view.addSubview(subtotalLabel)
        view.addSubview(totalLabel)
        view.addSubview(sendingPriceLabel)
        view.addSubview(needSwitch)
        view.addSubview(forkKnifeLabel)
        view.addSubview(forkKnifeNeedLabel)
        view.addSubview(basketConfirmButton)
        view.addSubview(clearBasketButton)
        if totalBasketAmount < 50 {
        view.addSubview(basketAmountLabel)
        }
    }
    
    private func configuremodels() {
        deliveryTimeLabel.text = "Estimated Delivery Time \n Now (40 min)"
        subtotalLabel.text = "Sub Total Price  \(totalBasketAmount) $"
        sendingPriceLabel.text = "Sending Price      Free"
        totalLabel.text = "Total Price  \(totalBasketAmount) $"
        forkKnifeLabel.text = "Fork & Knife Selection"
        forkKnifeNeedLabel.text = "Do you need plastic service?"
        basketAmountLabel.text = "You are below the minimum basket amount!"
        basketConfirmButton.setTitle("Confirm Basket", for: .normal)
        clearBasketButton.setTitle("Clear Basket", for: .normal)
    }
    
    override func viewDidLayoutSubviews() {
        let size = view.height/24
        deliveryTimeLabel.frame = CGRect(x: 0, y: view.safeAreaInsets.top+size, width: view.width, height: 60)
        subtotalLabel.frame = CGRect(x: 40, y: deliveryTimeLabel.bottom+(size*3)/2, width: view.width, height: 40)
        sendingPriceLabel.frame = CGRect(x: 40, y: subtotalLabel.bottom, width: view.width, height: 40)
        forkKnifeLabel.frame = CGRect(x: 40, y: sendingPriceLabel.bottom+size, width: (view.width*2)/3, height: 40)
        forkKnifeNeedLabel.frame = CGRect(x: 40, y: forkKnifeLabel.bottom, width: (view.width*2)/3, height: 40)
        needSwitch.frame = CGRect(x: forkKnifeLabel.right+30, y: sendingPriceLabel.bottom+size+20, width: (view.width*1)/3, height: 60)
        forkKnifeNeedLabel.frame = CGRect(x: 40, y: forkKnifeLabel.bottom, width: (view.width*2)/3, height: 40)
        basketAmountLabel.frame = CGRect(x: 40, y: forkKnifeNeedLabel.bottom+size, width: view.width, height: 40)
        totalLabel.frame = CGRect(x: 40, y: basketAmountLabel.bottom+8, width: view.width, height: 40)
        basketConfirmButton.frame = CGRect(x: 40, y: totalLabel.bottom+8, width: view.width-80, height: 60)
        clearBasketButton.frame = CGRect(x: 60, y: basketConfirmButton.bottom+8, width: view.width-120, height: 30)
    }
 

}
