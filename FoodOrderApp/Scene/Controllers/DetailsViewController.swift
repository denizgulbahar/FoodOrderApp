//
//  DetailsViewController.swift
//  FoodOrderApp
//
//  Created by Deniz Gülbahar on 20.07.2022.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var model:Menu?
    
    var amount:Int = 0
    
    public var totalBasketAmounts = 0

    private let nameLabel:UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    private let descriptionLabel:UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let priceLabel:UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 1
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    let pieceButton:UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .gray
        return button
    }()
    
    private let pieceStepper:UIStepper = {
        let stepper = UIStepper()
        stepper.minimumValue = 0
        stepper.maximumValue = 10
        stepper.value = 0
        stepper.stepValue = +1
        return stepper
    }()
    
    private let MenuimageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let addBasketButton:UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Add to Basket", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemRed
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        viewSubviews()
        addBasketButton.addTarget(self, action: #selector(addtoBasket), for: .touchUpInside)
        pieceStepper.addTarget(self, action: #selector(changeStepper), for: .touchUpInside)
        configuremodels()
    }
    
    private func viewSubviews() {
        view.addSubview(nameLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(priceLabel)
        view.addSubview(MenuimageView)
        view.addSubview(addBasketButton)
        view.addSubview(pieceStepper)
        view.addSubview(pieceButton)
    }
    
    @objc private func addtoBasket() {
        guard let model = model else {
            return
        }
        totalBasketAmounts = totalBasketAmounts + (model.price!/1000)*(Int(pieceStepper.value))
        let vc = RestaurantViewController()
        vc.totalBasketAmount = totalBasketAmounts
        navigationController?.pushViewController(vc, animated: true)
        print(totalBasketAmounts)
    }
    @objc private func changeStepper() {
        pieceButton.setTitle("\(Int(pieceStepper.value))", for: .normal)
    }
    
    private func configuremodels() {
        guard let model = model else {
            return
        }
        nameLabel.text = model.name
        descriptionLabel.text = model.description
        priceLabel.text = "\(model.price!/1000) $"
        MenuimageView.image = UIImage(named: model.image!)
        addBasketButton.setTitle("Add to Basket", for: .normal)
        pieceButton.setTitle("\(Int(pieceStepper.value))", for: .normal)
    }
    
    override func viewDidLayoutSubviews() {
        let size = view.width/3
        MenuimageView.frame = CGRect(x:size, y: view.safeAreaInsets.top, width:size, height: size)
        nameLabel.frame = CGRect(x: 25, y: MenuimageView.bottom, width: size*3-50, height: 50)
        priceLabel.frame = CGRect(x: 25, y: MenuimageView.bottom, width: view.width-50, height: 50)
        descriptionLabel.frame = CGRect(x: 25, y: nameLabel.bottom, width: view.width-50, height: 120)
        pieceButton.frame = CGRect(x: size/2, y: descriptionLabel.bottom+30, width: size/2, height: 40)
        pieceStepper.frame = CGRect(x: pieceButton.right+10, y:descriptionLabel.bottom+35 , width: 30, height: 60)
        addBasketButton.frame = CGRect(x:pieceStepper.right+10, y: descriptionLabel.bottom+30, width:size, height: 40)
    }
}
