//
//  VideoCollectionViewCell.swift
//  AR Camera
//
//  Created by Joel Crawford on 7/15/22.
//

import Foundation
import UIKit

class VideoCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "VideoCollectionViewCell"
    
    private let myImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "house")
        imageView.backgroundColor = .yellow
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let dateLabel : UILabel = {
        let label = UILabel()
        label.text = "Custom"
        label.backgroundColor = .green
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemRed
        contentView.clipsToBounds = true
        contentView.addSubview(myImageView)
        contentView.addSubview(dateLabel)
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        dateLabel.frame = CGRect(
            x: 5,
            y: contentView.frame.size.height-50,
            width: contentView.frame.size.width-10,
            height: 50
        )
        
        myImageView.frame = CGRect(
            x: 5,
            y: 0,
            width: contentView.frame.size.width-10,
            height: contentView.frame.size.height-50
        )
    }
    
}
