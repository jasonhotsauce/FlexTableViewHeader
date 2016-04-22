//
//  TableHeaderView.swift
//  FlexTableHeader
//
//  Created by Wenbin Zhang on 4/22/16.
//  Copyright © 2016 Wenbin Zhang. All rights reserved.
//

import UIKit

protocol Fadable: class {
    func fadeContent(alpha: Double)
}

class TableHeaderView: UIView, Fadable {
    var imageView: UIImageView
    let imageViewFullSize: CGFloat = 50.0

    override init(frame: CGRect) {
        imageView = UIImageView(image: UIImage(named: "baby-face"))
        imageView.contentMode = .ScaleAspectFit
        super.init(frame: frame)
        addSubview(imageView)
        setupConstraints()
        backgroundColor = UIColor.cyanColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: imageViewFullSize))
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: imageViewFullSize))
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1.0, constant: 0.0))
    }

    func fadeContent(alpha: Double) {
        imageView.alpha = CGFloat(alpha)
    }
}
