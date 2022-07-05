//
//  CustomButton.swift
//  AR Camera
//
//  Created by Joel Crawford on 7/1/22.
//

import UIKit

class CustomButton: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let widthContraints =  NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 100)
        let heightContraints = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 100)
        NSLayoutConstraint.activate([heightContraints,widthContraints])
        self.layer.cornerRadius = 50
        self.backgroundColor = UIColor.white
        self.layer.borderWidth = 4
        self.layer.borderColor = UIColor.red.cgColor
        self.setTitle("", for: .normal)
    }
}
