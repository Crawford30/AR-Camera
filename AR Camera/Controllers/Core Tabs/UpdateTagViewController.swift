//
//  UpdateTagViewController.swift
//  AR Camera
//
//  Created by Joel Crawford on 7/27/22.
//

import UIKit
import CoreData

class UpdateTagViewController: UIViewController {
    var videoID:String = ""
    
    
    
    struct Constants {
        static let cornerRadius: CGFloat = 8.0
    }
    
    private let tagTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Tag"
        field.returnKeyType = .done
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0)) //so that text is not flushed with the frame
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.backgroundColor = UIColor(named: "myGreenTint")
        field.layer.cornerRadius = Constants.cornerRadius
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    
    
    
    private let updateButton: UIButton = {
        let button =  UIButton()
        button.setTitle("Update Tag", for: .normal)
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    
    
    private let headerView: UIView = {
        let header =  UIView()
        header.clipsToBounds = true //so that nothing overflows
        let bgImageView = UIImageView(image: UIImage(named: "gradient"))
        header.addSubview(bgImageView)
        return header
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getSentData()
        view.backgroundColor = UIColor(named: "myLightGray")
        setNavItem()
        //Delegates for Textfields when the user taps enter button
        tagTextField.delegate = self
        
        addSubviews()
        
        
        updateButton.addTarget(self, action: #selector(didTapUpdate), for: .touchUpInside)
        
    }
    
    
    func getSentData() {
        let shared = MediaObjectSingleton.shared
        let tag = shared.getUserTag()
        videoID = shared.getID()
        
        tagTextField.text = tag
        
        print("VIDEO ID: \(videoID)")
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //======Frame For header view ====
        headerView.frame = CGRect(
            x: 0,
            y: 0.0,
            width: view.width,
            height: view.height/3.0
        ) //view.safeAreaInsets.top not to overlap with the notch
        
        
        //=====Frame for Username TextField
        tagTextField.frame = CGRect(
            x: 25,
            y: headerView.bottom + 40,
            width: view.width-50,
            height: 52.0
        )
        
        
        //=====Frame for Login Button
        updateButton.frame = CGRect(
            x: 25,
            y: tagTextField.bottom+10,
            width: view.width-50,
            height: 52.0
        )
        configureHeaderView()
        
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
        
        //=====Add  logo
        
        let logoImageView = UIImageView(image: UIImage(named: "text"))
        headerView.addSubview(logoImageView)
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.frame = CGRect(
            x: headerView.width/4.0,
            y: view.safeAreaInsets.top,
            width: headerView.width/2.0,
            height: headerView.height-view.safeAreaInsets.top)
        
        
    }
    
    //MARK:- Add SubViews
    private func addSubviews(){
        view.addSubview(tagTextField)
        view.addSubview(updateButton)
        view.addSubview(headerView)
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //MARK: - Nav Item
    private func setNavItem(){
        self.navigationItem.leftItemsSupplementBackButton = true
        navigationItem.title = "Edit Tag"
        let videoImage   = UIImage(systemName: "video.fill")!
        let listVideos = UIImage(systemName: "list.dash")!
        let backButton =   UIImage(systemName: "chevron.left")!
        let videoButton = UIBarButtonItem(image: videoImage,  style: .plain, target: self, action: #selector(didTapTakeVideoButton))
        let listVideoButton = UIBarButtonItem(image: listVideos,  style: .plain, target: self, action: #selector(didTapListViedeosButton))
        navigationItem.rightBarButtonItems = [listVideoButton,videoButton]
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: backButton, style: .done,target: self, action: #selector(backButtonTapped))
    }
    
    
    
    
    @objc func backButtonTapped(){
        Utilities.vibrate()
        let controller = HomeViewController()
        let navController = UINavigationController(rootViewController: controller)
        
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        guard let window = view.window else { return }
        window.layer.add(transition, forKey: kCATransition)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: false, completion: nil)
        
    }
    
    
    @objc func didTapListViedeosButton(sender: AnyObject){
        Utilities.vibrate()
        
        navigateToRecordingList()
        
    }
    
    
    private func navigateToRecordingList(){
        let controller = RecordingListViewController()
        let navController = UINavigationController(rootViewController: controller)
        
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        guard let window = view.window else { return }
        window.layer.add(transition, forKey: kCATransition)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: false, completion: nil)
    }
    
    @objc   func didTapTakeVideoButton(sender: AnyObject){
        Utilities.vibrate()
        let controller = CameraViewController()
        let navController = UINavigationController(rootViewController: controller)
        
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        guard let window = view.window else { return }
        window.layer.add(transition, forKey: kCATransition)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: false, completion: nil)
        
    }
    
    
    
    
    @objc private func didTapUpdate(){
        print("Tap Edit")
        Utilities.vibrate()
        if let tag =  tagTextField.text{
            CoreDataManager.shared.update(identifier: videoID, tag: tag.safeDatabaseKey())
        }
        navigateToRecordingList()
        
        
    }
    
}


extension UpdateTagViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if(textField == tagTextField) {
            didTapUpdate()
            
        }
        
        
        return true
    }
}
