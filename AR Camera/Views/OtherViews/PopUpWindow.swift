//
//  PopUpWindow.swift
//  AR Camera
//
//  Created by Joel Crawford on 7/2/22.
//

import UIKit

class PopupWindow: UIViewController{
    private let popUpWindowView = PopUpWindowView()
    
    init(title:String,text:String, buttonText:String){
        super.init(nibName: nil, bundle: nil)
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overFullScreen
    
        popUpWindowView.popupTitle.text = title
        popUpWindowView.popupTextField.text = text
        popUpWindowView.popupButton.setTitle(buttonText, for: .normal)
        popUpWindowView.popupButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        
        //Add popup window to ViewController
        view = popUpWindowView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func dismissView(){
        Utilities.vibrate()
        self.dismiss(animated: true, completion: nil)
    }
}

private class PopUpWindowView: UIView {
    
    let popupView = UIView(frame: CGRect.zero)
    let popupTitle = UILabel(frame: CGRect.zero)
    let popupText = UILabel(frame: CGRect.zero)
    let popupTextField = UITextField(frame: CGRect.zero)
    let popupButton = UIButton(frame: CGRect.zero)
    
    init(){
        super.init(frame:CGRect.zero)
        
        //Semi-transparent background
        backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        //Popup Background
        popupView.backgroundColor               = UIColor.blue
        popupView.layer.borderWidth             = Constants.borderWidth
        popupView.layer.masksToBounds           = true
        popupView.layer.borderColor             = UIColor.white.cgColor
        
        //Popup Title
        popupTitle.textColor                   = UIColor.white
        popupTitle.backgroundColor             = UIColor.yellow
        popupTitle.layer.masksToBounds         = true
        popupTitle.adjustsFontSizeToFitWidth   = true
        popupTitle.clipsToBounds               = true
        popupTitle.font                        = UIFont.systemFont(ofSize: 23.0, weight: .bold)
        popupTitle.numberOfLines               = 1
        popupTitle.textAlignment               = .center
        
        //Popup Text
        popupText.textColor                    = UIColor.white
        popupText.font                         = UIFont.systemFont(ofSize: 16.0, weight: .semibold)
        popupText.numberOfLines                = 0
        popupTitle.textAlignment               = .center
        
        //Popup Textfield
        popupTextField.textColor               = UIColor.white
        popupTextField.font                    = UIFont.systemFont(ofSize: 16.0)
        popupTextField.keyboardType            = UIKeyboardType.alphabet
        popupTextField.attributedPlaceholder  =  NSAttributedString(string: "Tag")

        
        //Popup Button
        popupButton.setTitleColor(UIColor.white, for: .normal)
        popupButton.titleLabel?.font           = UIFont.systemFont(ofSize: 23.0, weight: .bold)
        popupButton.backgroundColor            = .systemBlue
        
        
        popupView.addSubview(popupTitle)
        popupView.addSubview(popupTextField)
        popupView.addSubview(popupButton)
        
        
        //Add the poppview in the Popupwindow (Semit-transparent Background)
        addSubview(popupView)
        
        
        //PopupView Constraints
        popupView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            popupView.widthAnchor.constraint(equalToConstant: 350),
            popupView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            popupView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        
        
        //Popup Title Constraints
        popupTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            popupTitle.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: Constants.borderWidth),
            popupTitle.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -Constants.borderWidth),
            popupTitle.topAnchor.constraint(equalTo: popupView.topAnchor, constant: Constants.borderWidth),
            popupTitle.heightAnchor.constraint(equalToConstant: 55)
        
        ])
        

        popupTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            popupTextField.heightAnchor.constraint(equalToConstant: 44),
            popupTextField.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: Constants.borderWidth),
            popupTextField.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -Constants.borderWidth),
            popupTextField.bottomAnchor.constraint(equalTo: popupView.bottomAnchor, constant: -Constants.borderWidth)
            ])

        
        
        // PopupText constraints
                popupText.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    popupText.heightAnchor.constraint(greaterThanOrEqualToConstant: 67),
                    popupText.topAnchor.constraint(equalTo: popupTitle.bottomAnchor, constant: 8),
                    popupText.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 15),
                    popupText.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -15),
                    popupText.bottomAnchor.constraint(equalTo: popupButton.topAnchor, constant: -8)
                    ])

                
                // PopupButton constraints
                popupButton.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    popupButton.heightAnchor.constraint(equalToConstant: 44),
                    popupButton.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: Constants.borderWidth),
                    popupButton.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -Constants.borderWidth),
                    popupButton.bottomAnchor.constraint(equalTo: popupView.bottomAnchor, constant: -Constants.borderWidth)
                    ])
        
     
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
