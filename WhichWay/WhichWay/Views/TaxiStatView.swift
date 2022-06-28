//
//  TaxiStatView.swift
//  WhichWay
//
//  Created by Nikita Kazakov on 09.06.2022.
//

import Foundation
import UIKit

class TaxiStatView: UIView {
    var logoName: String
    var brandName: String
    var stat: Array<(key: String, value: Int)>
    var drivingTime: Int
    init(logoName: String, brandName: String, categoriesWithPrices: Array<(key: String, value: Int)>, time: Int) {
        self.logoName = logoName
        self.brandName = brandName
        self.stat = categoriesWithPrices
        self.drivingTime = time
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.heightAnchor.constraint(equalToConstant: 90).isActive = true
        
        let logo = UIImageView()
        logo.image = UIImage(named: logoName) ?? UIImage.strokedCheckmark
        logo.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(logo)
        logo.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        logo.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        logo.heightAnchor.constraint(equalToConstant: 30).isActive = true
        logo.widthAnchor.constraint(equalTo: logo.heightAnchor).isActive = true
        logo.widthAnchor.constraint(equalTo: logo.heightAnchor).isActive = true
        
        let brandLabel = UILabel()
        brandLabel.text = brandName
        brandLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(brandLabel)
        brandLabel.centerYAnchor.constraint(equalTo: logo.centerYAnchor).isActive = true
        brandLabel.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: 5).isActive = true
        
        let time = UILabel()
        time.text = stat.isEmpty || drivingTime < 0 ? "- мин." : "\(drivingTime / 60) мин."
        time.translatesAutoresizingMaskIntoConstraints = false
        time.font = .boldSystemFont(ofSize: 13)
        self.addSubview(time)
        let _ = time.centerVertically(equalTo: logo.centerYAnchor).setTrailingConstraint(equalTo: self.trailingAnchor, constant: -10)
        
        let infoStack = UIStackView()
        infoStack.axis = .horizontal
        infoStack.distribution = .fillEqually
        infoStack.spacing = 10
        infoStack.translatesAutoresizingMaskIntoConstraints = false
        infoStack.backgroundColor = .white
//        infoStack.layer.cornerRadius = 10
//        infoStack.dropShadow()
//        infoStack.layer.borderColor = UIColor.separator.cgColor
//        infoStack.layer.borderWidth = 1
        self.addSubview(infoStack)
        infoStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        infoStack.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        if stat.isEmpty {
            let emptyMsg = UILabel()
            emptyMsg.text = "Нет доступных машин"
            emptyMsg.translatesAutoresizingMaskIntoConstraints = false
            emptyMsg.font = .systemFont(ofSize: 13)
            self.addSubview(emptyMsg)
            let _ = emptyMsg.centerHorizontally(equalTo: self.centerXAnchor).setTopConstraint(equalTo: logo.bottomAnchor, constant: 5)
        }
        for item in stat {
            infoStack.addArrangedSubview(generateStatItemView(item.key, item.value))
        }
    }
    
    private func generateStatItemView(_ category: String, _ amount: Int) -> UIView {
        let container = UIStackView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.axis = .vertical
        
        let categoryLabel = UILabel()
        categoryLabel.text = category
        categoryLabel.textAlignment = .center
        container.addArrangedSubview(categoryLabel)
        categoryLabel.font = .systemFont(ofSize: 10)
        
        let amountLabel = UILabel()
        amountLabel.text = String(amount) + "₽"
        amountLabel.textAlignment = .center
        amountLabel.font = .systemFont(ofSize: 17, weight: .medium)
        container.addArrangedSubview(amountLabel)
        
        return container
    }
}

extension UIView {
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = .zero
        layer.shadowRadius = 2
//        layer.shadowOffset = CGSize(width: 0, height:0)
//        layer.shadowRadius = 1

//        layer.shadowPath = UIBezierPath(rect: CGRect(x: -5, y: -5, width: self.frame.width + 100, height: self.frame.height + 5)).cgPath
//        layer.shouldRasterize = true
//        layer.rasterizationScale = UIScreen.main.scale
      }
}
