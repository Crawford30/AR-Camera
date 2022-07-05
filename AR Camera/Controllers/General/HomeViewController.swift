//
//  ViewController.swift
//  AR Camera
//
//  Created by Joel Crawford on 6/30/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: - HEADER VIEW
    private let headerView: UIView = {
        let header =  UIView()
        header.clipsToBounds = true //so that nothing overflows
        let bgImageView = UIImageView(image: UIImage(named: "photo_icon"))
        header.addSubview(bgImageView)
        return header
    }()
    
    
    private let goToRecordVideoButton: UIButton = {
        let button =  UIButton()
        button.setTitle("Record Video", for: .normal)
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    
    private let recordingListButton: UIButton = {
        let button =  UIButton()
        button.setTitle("Recording List", for: .normal)
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavItem()
        addSubviews()
        
        view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view
        goToRecordVideoButton.addTarget(self, action: #selector(didTapRecordButton), for: .touchUpInside)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //======Frame For header view ====
        headerView.frame = CGRect(
            x: 0,
            y:70.0,
            width: view.width,
            height: view.height/3.0
        ) //view.safeAreaInsets.top not to overlap with the notch
        
        
        
        //=====Frame For Record Video Button
        goToRecordVideoButton.frame = CGRect(
                    x: 25,
                    y: headerView.bottom+10,
                    width: view.width-50,
                    height: 52.0
                )
        
        
        //=====Frame for Recording List Button
        recordingListButton.frame = CGRect(
                    x: 25,
                    y: goToRecordVideoButton.bottom+10,
                    width: view.width-50,
                    height: 52.0
                )
        
        configureHeaderView()
        
    }

    
    
    
    
    //MARK: - Nav Title
    private func setNavItem(){
        navigationItem.title = "AR Camera"
    }
    
    
    //MARK: - Go To Record Video Screen
    @objc private func didTapRecordButton(){
        Utilities.vibrate()
        let controller = CameraViewController()
        let transition = CATransition()
            transition.duration = 0.3
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromLeft
            guard let window = view.window else { return }
            window.layer.add(transition, forKey: kCATransition)
            controller.modalPresentationStyle = .fullScreen
            present(controller, animated: false, completion: nil)
        
    }
    
    
    //MARK:- Header View
    private func configureHeaderView(){
        //Should only have one subview by default
        guard headerView.subviews.count == 1 else {
            return
        }
        
        guard let backgroundView = headerView.subviews.first  else {
            return
        }
        
        //Assign the backgroundview frame to be the entirety of the header view
        backgroundView.frame = headerView.bounds
        
        //=====Add Instagram logo
        
//        let logoImageView = UIImageView(image: UIImage(named: "send"))
//        headerView.addSubview(logoImageView)
//        logoImageView.contentMode = .scaleAspectFit
//        logoImageView.frame = CGRect(
//            x: headerView.width/4.0,
//            y: view.safeAreaInsets.top,
//            width: headerView.width/2.0,
//            height: headerView.height-view.safeAreaInsets.top)
        
        
    }
    
    
    //MARK:- Add SubViews
    private func addSubviews(){
        view.addSubview(recordingListButton)
        view.addSubview(goToRecordVideoButton)
        view.addSubview(headerView)
        
    }

}

