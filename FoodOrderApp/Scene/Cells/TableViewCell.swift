//
//  TableViewCell.swift
//  FoodOrderApp
//
//  Created by Deniz Gülbahar on 18.07.2022.
//

import UIKit

class TableViewCell: UITableViewCell {

    static let identifier = "TableViewCell"
    
    public var model:Menu?
    
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
        label.textAlignment = .left
        return label
    }()
    
    private let menuimageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor(red:1 , green: 1, blue: 1, alpha: 1)
        contentView.clipsToBounds = true
        contentView.addSubview(nameLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(menuimageView)
        contentView.addSubview(priceLabel)
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.borderWidth = 1
        selectionStyle = .none
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model:Menu) {
        self.model = model
        menuimageView.image = UIImage(named: model.image!)
        nameLabel.text = model.name
        descriptionLabel.text = model.description
        priceLabel.text = "\(model.price!/1000) $"
        
    }
    override func layoutSubviews() {
        nameLabel.frame = CGRect(x: 20, y: 0, width: (contentView.width*2)/3-30, height: 40)
        descriptionLabel.frame = CGRect(x: 20, y: nameLabel.bottom, width: (contentView.width*2)/3-30, height: 80)
        priceLabel.frame = CGRect(x: 20, y: descriptionLabel.bottom, width: contentView.width/4, height: 30)
        menuimageView.frame = CGRect(x: nameLabel.right, y: 0, width: contentView.width/3, height: 150)
    }

    override func prepareForReuse() {
        nameLabel.text = nil
        descriptionLabel.text = nil
        priceLabel.text = nil
        menuimageView.image = nil
    }
}





















