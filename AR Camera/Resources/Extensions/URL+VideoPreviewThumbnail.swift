//
//  URL+VideoPreviewThumbnail.swift
//  AR Camera
//
//  Created by Joel Crawford on 7/16/22.
//

import Foundation
import UIKit
import AVFoundation

extension URL{
    
    public func videoPreviewThumbnail() -> UIImage? {
        //AVAsset Instance eg mediaObject.videoURL.videoPreviewThumbnail()
        let asset = AVAsset(url: self) //self is the URL instance
        let assetGenerator = AVAssetImageGenerator(asset: asset)
        
        //maintain the aspect ratio of the video
        assetGenerator.appliesPreferredTrackTransform = true
        
        //create a timestamp od needed location
        //CMTime to generate the given timestamp
        //CMTime is Part of Core Media
        
        let timeStamp = CMTime(seconds: 1, preferredTimescale: 60) //get the first second of the video
        var image:UIImage?
        
        do {
            let cgImage = try assetGenerator.copyCGImage(at: timeStamp, actualTime: nil) //lower level api don't know about UIKit, AVKit
            image = UIImage(cgImage: cgImage)
        } catch {
            print("Failed to generate Image: \(error)")
        }
        return image
    }
    
}
