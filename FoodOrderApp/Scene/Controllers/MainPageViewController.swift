//
//  MainPageViewController.swift
//  FoodOrderApp
//
//  Created by Deniz Gülbahar on 20.07.2022.
//

import UIKit

struct Constants {
    static let cornerRadius:CGFloat = 15.0
}

class MainPageViewController: UIViewController {

    private let welcomeLabel:UILabel = {
        let label = UILabel()
        label.text = "WELCOME TO \n FOOD ORDER APP"
        label.textColor = .white
        label.font = .systemFont(ofSize: 34, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 3
        return label
    }()
    
    private let chooseFoodButton:UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Choose Food Now", for: .normal)
        button.backgroundColor = .systemOrange
        button.layer.cornerRadius = Constants.cornerRadius
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        view.addSubview(welcomeLabel)
        view.addSubview(chooseFoodButton)
        chooseFoodButton.addTarget(self, action: #selector(chooseFood), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        welcomeLabel.frame = CGRect(x: 0, y: view.height/3, width: view.width, height: view.height/3)
        chooseFoodButton.frame = CGRect(x:40 , y: welcomeLabel.bottom+10, width: view.width-80, height: 80)
        
    }
    
    @objc private func chooseFood() {
        let vc = RestaurantViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

}
