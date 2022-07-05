//
//  Utilities.swift
//  AR Camera
//
//  Created by Joel Crawford on 6/30/22.
//

import Foundation
import UIKit

class  Utilities {

    //MARK: - Light Haptic Feedback
    static func vibrate() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.prepare()  //removes the small delay in the feedback
        generator.impactOccurred()
    }
    
    //MARK: - On Selection Changed
    static func vibrateOnSelect() {
        let selectionGenerator = UISelectionFeedbackGenerator()
        selectionGenerator.prepare()  //removes the small delay in the feedback
        selectionGenerator.selectionChanged()
    }
    
    //=======NotificationFeedBack Generator 3 cases, success, warning and error
    
    //MARK: - On Success
    static func vibrateOnNotificationSuccess() {
        let notificationGenerator = UINotificationFeedbackGenerator()
        notificationGenerator.prepare() //remove delay
        notificationGenerator.notificationOccurred(.success)
    }
    

    //MARK: - On Warning
    static func vibrateOnNotificationWarning() {
        let notificationGenerator = UINotificationFeedbackGenerator()
        notificationGenerator.prepare() //remove delay
        notificationGenerator.notificationOccurred(.warning)
    }
    
    //MARK: - On Error
    static func vibrateOnNotificationError() {
        let notificationGenerator = UINotificationFeedbackGenerator()
        notificationGenerator.prepare() //remove delay
        notificationGenerator.notificationOccurred(.error)
    }
    
 
}









