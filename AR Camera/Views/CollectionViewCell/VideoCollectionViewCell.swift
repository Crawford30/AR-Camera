//
//  VideoCollectionViewCell.swift
//  AR Camera
//
//  Created by Joel Crawford on 7/15/22.
//

import Foundation
import UIKit

class VideoCollectionViewCell: UICollectionViewCell {
    
    public func configureCell(for mediaObject: MediaObject){
        if let imageData = mediaObject.imageData{
            //converts a data object to a UIImage
            myImageView.image = UIImage(data: imageData)
        }
    }
    
    static let identifier = "VideoCollectionViewCell"
    
    public let myImageView : UIImageView = {
        let imageView               = UIImageView()
        imageView.image             = UIImage(systemName: "house")
        imageView.backgroundColor   = .yellow
        imageView.contentMode       = .scaleAspectFit
        imageView.clipsToBounds     = true
        return imageView
    }()
    
    public let dateLabel : UILabel = {
        let label = UILabel()
        label.text = "Custom"
        label.textColor            = .white
        label.numberOfLines        = .zero
        label.font                 = UIFont.boldSystemFont(ofSize: 14.0)
        label.backgroundColor      =  UIColor(named: "myGreenTint")
        return label
    }()
    
    
    public let tagLabel : UILabel = {
        let label = UILabel()
        label.text = "Tag"
        label.textColor           = .white
        label.numberOfLines       = .zero
        label.font                = UIFont.boldSystemFont(ofSize: 14.0)
        label.backgroundColor     =  UIColor(named: "myGreenTint")
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor    = UIColor(named: "myLightGray")
        contentView.clipsToBounds      = true
        contentView.addSubview(myImageView)
        contentView.addSubview(dateLabel)
        contentView.addSubview(tagLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tagLabel.frame = CGRect(
            x: 0,
            y: contentView.frame.size.height-40,
            width: contentView.frame.size.width,
            height: 40
        )
        
        dateLabel.frame = CGRect(
            x: 0,
            y: contentView.frame.size.height-90,
            width: contentView.frame.size.width,
            height: 40
        )
        
        myImageView.frame = CGRect(
            x: 0,
            y: 0,
            width: contentView.frame.size.width,
            height: 200
        )
    }
    
}
