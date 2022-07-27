//
//  CustomLabel.swift
//  AR Camera
//
//  Created by Joel Crawford on 7/27/22.
//


import UIKit

  class CustomLabel: UILabel {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeLabel()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeLabel()
    }

    func initializeLabel() {

        self.textAlignment = .left
        self.font = UIFont(name: "Halvetica", size: 17)
        self.textColor = UIColor.white

    }

}
