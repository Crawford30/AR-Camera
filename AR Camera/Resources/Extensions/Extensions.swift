//
//  Extensions.swift
//  AR Camera
//
//  Created by Joel Crawford on 6/30/22.
//

import UIKit

//MARK: - Extension To Create UIView Programatically
extension UIView{
    public var width: CGFloat{
        return frame.size.width
    }
    
    public var height: CGFloat{
           return frame.size.height
    }
    
    public var top: CGFloat{
              return frame.origin.y
       }
    
    public var bottom: CGFloat{
        return frame.origin.y +  frame.size.height
       }
    
    public var left: CGFloat{
              return frame.origin.x
       }
    
    public var right: CGFloat{
              return frame.origin.x + frame.size.width
       }
    
    
  
    // MARK: Add Constraints
    // Extension for simplifying the adding of constraints
    
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
}


//MARK: - Remove Special Characters From Text
extension String {
      func safeDatabaseKey() -> String {
          return  self.replacingOccurrences(of: "@", with: "_").replacingOccurrences(of: " ", with: "_")
         //return  self.replacingOccurrences(of: ".", with: "_")
    }
    
}

//MARK: - Toast Extension(Showing Toast Message)
extension UIViewController {
    func showToast(message : String, fontSize: CGFloat) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-self.view.frame.size.height/2 + 17.5, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        toastLabel.textColor = UIColor.black
        toastLabel.font = UIFont.systemFont(ofSize: fontSize)
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 3.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}



//MARK: - UIColor Extension
extension UIColor {
    static func rgbColor(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor.init(red: red/255, green: green/255, blue: blue/255, alpha: 1.0)
    }
    
    static func colorFromHex(_ hex: String) -> UIColor {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }
        if hexString.count != 6 {
            return UIColor.magenta
        }
        
        var rgb: UInt64 = 0
        Scanner.init(string: hexString).scanHexInt64(&rgb)
        
        return UIColor.init(red: CGFloat((rgb & 0xFF0000) >> 16)/255,
                            green: CGFloat((rgb & 0x00FF00) >> 8)/255,
                            blue: CGFloat(rgb & 0x0000FF)/255,
                            alpha: 1.0)
    }
    
}




extension UserDefaults {
    var mediaObjects: [CDMediaObject] {
        get {
            guard let data = UserDefaults.standard.data(forKey: "mediaObjects") else { return [] }
            return (try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data)) as? [CDMediaObject] ?? []
        }
        set {
            UserDefaults.standard.set(try? NSKeyedArchiver.archivedData(withRootObject: newValue, requiringSecureCoding: false), forKey: "mediaObjects")
        }
    }
}



extension DateFormatter {

    static var sharedDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        // Add your formatter configuration here
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter
    }()
}

extension Date {
//     static func - (lhs: Date, rhs: Date) -> TimeInterval {
//         return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
//     }
    
    
    static func -(recent: Date, previous: Date) -> (month: Int?, day: Int?, hour: Int?, minute: Int?, second: Int?) {
            let day = Calendar.current.dateComponents([.day], from: previous, to: recent).day
            let month = Calendar.current.dateComponents([.month], from: previous, to: recent).month
            let hour = Calendar.current.dateComponents([.hour], from: previous, to: recent).hour
            let minute = Calendar.current.dateComponents([.minute], from: previous, to: recent).minute
            let second = Calendar.current.dateComponents([.second], from: previous, to: recent).second

            return (month: month, day: day, hour: hour, minute: minute, second: second)
        }
 }


extension UIViewController {

    /**
     *  Height of status bar + navigation bar (if navigation bar exist)
     */

    var topbarHeight: CGFloat {
        return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
}


extension UINavigationController {
  static public func navBarHeight() -> CGFloat {
    let nVc = UINavigationController(rootViewController: UIViewController(nibName: nil, bundle: nil))
    let navBarHeight = nVc.navigationBar.frame.size.height
    return navBarHeight
  }
}
