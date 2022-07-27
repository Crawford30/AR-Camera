//
//  RecordingListViewController.swift
//  AR Camera
//
//  Created by Joel Crawford on 7/5/22.
//

import UIKit
import AVFoundation
import AVKit

class RecordingListViewController: UIViewController {
    
    var myCurrentButton: Int = 0
    var mediaObjects =  [CDMediaObject]()
    let myVertCVSpacing:  CGFloat = CGFloat( 8.0 )
    private var listVdeosCollectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavItem()
        self.view.backgroundColor = .blue
        configureCollectionView()
        fetchVideos()
    }
    
    
    //MARK: - Fetch Videos From Core Data
    private func fetchVideos(){
        mediaObjects = CoreDataManager.shared.fetchMediaObjects()
        DispatchQueue.main.async {
            self.listVdeosCollectionView?.reloadData()
        }
    }
    
    
    
    //MARK: - Nav Item
    private func setNavItem(){
        self.navigationItem.leftItemsSupplementBackButton = true
        navigationItem.title = "Recording List"
        let videoImage   = UIImage(systemName: "video.fill")!
        let refresh = UIImage(systemName: "arrow.counterclockwise.icloud")!
        let backButton =   UIImage(systemName: "chevron.left")!
        let videoButton = UIBarButtonItem(image: videoImage,  style: .plain, target: self, action: #selector(didTapTakeVideoButton))
        let refreshButton = UIBarButtonItem(image: refresh,  style: .plain, target: self, action: #selector(didTapListViedeosButton))
        navigationItem.rightBarButtonItems = [refreshButton,videoButton]
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
        fetchVideos()
        
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
    
    
    
    
    
    //MARK: - CREATE CUSTOM MENU
    private  func prepCustomMenu() {
        let tempView: UIView          = UIView.init()    // Fill screen with invisible view to disable taps in back
        tempView.tag                  = 1000
        tempView.frame                = self.view.frame
        tempView.backgroundColor      = UIColor.clear
        self.view.addSubview( tempView )
        
        //-----------------------------------------------------------------------------------
        var buttonRect: CGRect = CGRect.zero
        buttonRect.origin.x    = listVdeosCollectionView!.frame.origin.x + 40
        buttonRect.origin.y    = 0
        buttonRect.size.width  = listVdeosCollectionView!.frame.size.width - 80.0
        buttonRect.size.height = 44
        let buttonGap:CGFloat  = 10.0 // vertical gap between buttons
        
        //-----------------------------------------------------------------------------------
        let bgLabel: UILabel       = UILabel.init()
        bgLabel.backgroundColor    = UIColor.white
        var bgRect: CGRect         = CGRect.zero
        bgRect.origin.x            = listVdeosCollectionView!.frame.origin.x + 20
        bgRect.origin.y            = 0
        bgRect.size.width          = listVdeosCollectionView!.frame.size.width - 60.0
        bgRect.size.height         = ( buttonRect.size.height * 4.0 ) + ( buttonGap * 5.0 )
        bgLabel.frame              = bgRect
        tempView.addSubview( bgLabel )
        bgLabel.layer.cornerRadius = 10.0
        bgLabel.clipsToBounds      = true
        bgLabel.center             = self.view.center
        
        
        
        //-----------------------------------------------------------------------------------
        
        let playVideoButton:  UIButton            = UIButton.init()
        playVideoButton.backgroundColor           = UIColor(named: "myLightGray")
        playVideoButton.titleLabel?.textAlignment = .center
        playVideoButton.titleLabel?.font          = UIFont.boldSystemFont(ofSize: 20.0 )
        playVideoButton.setTitleColor( UIColor(named: "myGreenTint"), for: .normal)
        playVideoButton.setTitle("Play Video", for: .normal )
        playVideoButton.addTarget(self, action: #selector( self.playVideoAction(_:) ), for: .touchUpInside )
        tempView.addSubview( playVideoButton )
        playVideoButton.layer.cornerRadius         = 8.0
        playVideoButton.clipsToBounds              = true
        buttonRect.origin.y                        = bgLabel.frame.origin.y + buttonGap
        playVideoButton.frame                      = buttonRect
        buttonRect.origin.y += buttonRect.size.height + buttonGap
        
        //-----------------------------------------------------------------------------------
        
        
        
        let editVideoButton: UIButton             = UIButton.init()
        editVideoButton.backgroundColor           = UIColor(named: "myLightGray")
        editVideoButton.titleLabel?.textAlignment = .center
        editVideoButton.titleLabel?.font          = UIFont.boldSystemFont(ofSize: 20.0 )
        editVideoButton.setTitleColor( UIColor(named: "myGreenTint"), for: .normal)
        editVideoButton.setTitle("Edit Video Tag", for: .normal )
        editVideoButton.addTarget(self, action: #selector( self.editVideoTagAction ), for: .touchUpInside )
        tempView.addSubview( editVideoButton )
        editVideoButton.layer.cornerRadius         = 8.0
        editVideoButton.clipsToBounds              = true
        editVideoButton.frame                      = buttonRect
        buttonRect.origin.y += buttonRect.size.height + buttonGap
        
        //-----------------------------------------------------------------------------------
        
        
        let deleteVideoButton: UIButton             = UIButton.init()
        deleteVideoButton.backgroundColor           = UIColor(named: "myLightGray")
        deleteVideoButton.titleLabel?.textAlignment = .center
        deleteVideoButton.titleLabel?.font          = UIFont.boldSystemFont(ofSize: 20.0 )
        deleteVideoButton.setTitleColor( UIColor.red, for: .normal)
        deleteVideoButton.setTitle("Delete", for: .normal )
        deleteVideoButton.addTarget(self, action: #selector( self.deleteVideo ), for: .touchUpInside )
        tempView.addSubview( deleteVideoButton )
        deleteVideoButton.layer.cornerRadius        = 8.0
        deleteVideoButton.clipsToBounds             = true
        deleteVideoButton.frame = buttonRect
        buttonRect.origin.y += buttonRect.size.height + buttonGap
        
        
        //-----------------------------------------------------------------------------------
        
        let cancelMenuButton: UIButton              = UIButton.init()
        cancelMenuButton.backgroundColor            = UIColor(named: "myLightGray")
        cancelMenuButton.setTitleColor( UIColor.red, for: .normal)
        cancelMenuButton.titleLabel?.textAlignment  = .center
        cancelMenuButton.titleLabel?.font           = UIFont.boldSystemFont(ofSize: 20.0 )
        cancelMenuButton.setTitle("Cancel", for: .normal )
        cancelMenuButton.addTarget(self, action:#selector( self.handleCancel ), for: .touchUpInside )
        tempView.addSubview( cancelMenuButton )
        cancelMenuButton.frame = buttonRect
        cancelMenuButton.layer.cornerRadius         = 8.0
        cancelMenuButton.clipsToBounds              = true
        
    }
    
    
    
    
    //MARK:- POPUP VIEW ACTIONS
    @objc func playVideoAction(_ sender: UIButton) {
        Utilities.vibrate()
        sender.tag = myCurrentButton
        let mediaObject = mediaObjects[myCurrentButton]
        let playerViewController = AVPlayerViewController()
        let videoObject  = mediaObject.videoData
        
        if let videoObject = videoObject?.convertToURL() {
            let player  = AVPlayer(url: videoObject)
            playerViewController.player = player
            playerViewController.videoGravity = .resizeAspectFill
            present(playerViewController, animated: true, completion: nil)
            player.play()
        }
        
        self.view.viewWithTag(1000)?.removeFromSuperview()
    }
    
    
    //MARK: - TODO EDIT
    @objc func editVideoTagAction(_ sender: UIButton) {
        Utilities.vibrate()
        sender.tag = myCurrentButton
        let mediaObject = mediaObjects[myCurrentButton]
        
        let shared = MediaObjectSingleton.shared
        if let tag = mediaObject.caption{
            shared.setUserTag(theTag: tag)
        }
       
        let controller = UpdateTagViewController()
        let navController = UINavigationController(rootViewController: controller)
        
        
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        guard let window = view.window else { return }
        window.layer.add(transition, forKey: kCATransition)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: false, completion: nil)
        
//        print("TAG: \(mediaObject.caption)")
        
      
        self.view.viewWithTag(1000)?.removeFromSuperview()
        
    }
    
    
    //MARK: - DELETE ACTION
    @objc func deleteVideo(sender: UIButton) {
        Utilities.vibrate()
        sender.tag = myCurrentButton
        let mediaObject = mediaObjects[myCurrentButton]
        let alertController = UIAlertController(title: "Delete Media", message: "Are you sure that you want to delete this item? Please, note that this action can not be undone.", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [unowned self] (alertAction) in
            self.deleteMediaObject(mediaObject)
            fetchVideos()
        }
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        present(alertController, animated: true)
        self.view.viewWithTag(1000)?.removeFromSuperview()
    }
    
    //MARK: - CANCEL
    @objc func handleCancel() {
        Utilities.vibrate()
        self.view.viewWithTag(1000)?.removeFromSuperview()
    }
    
    
    
    //MARK: - DELETE FUNCTION
    private func deleteMediaObject(_ mediaObject: CDMediaObject) {
        CoreDataManager.shared.deleteMediaObject(mediaObject)
        let index = mediaObjects.firstIndex(of: mediaObject)
        if let index = index {
            mediaObjects.remove(at: index)
        }
    }
    
    
    
    //MARK: - CONFIGURE COLLECTION VIEW
    private func configureCollectionView(){
        let myCellSize: CGSize = CGSize( width: (view.frame.size.width)-12, height: view.frame.size.height/2)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = myVertCVSpacing
        layout.minimumInteritemSpacing = myVertCVSpacing
        layout.itemSize = myCellSize
        
        //layout.itemSize = CGSize(width: view.frame.size.width, height: view.frame.size.height )
        listVdeosCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        guard let listVdeosCollectionView = listVdeosCollectionView else {
            return
        }
        listVdeosCollectionView.register(VideoCollectionViewCell.self, forCellWithReuseIdentifier: VideoCollectionViewCell.identifier)
        listVdeosCollectionView.dataSource = self
        listVdeosCollectionView.delegate = self
        view.addSubview(listVdeosCollectionView)
        listVdeosCollectionView.frame = view.bounds
        
        listVdeosCollectionView.reloadData()
    }
    
}



//MARK: - UICollection View Data Source Methods
extension RecordingListViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mediaObjects.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = listVdeosCollectionView?.dequeueReusableCell(withReuseIdentifier: VideoCollectionViewCell.identifier, for: indexPath) as? VideoCollectionViewCell
        let mediaObject = mediaObjects[indexPath.row]
        let interval = mediaObject.endDate! - mediaObject.createDate!
        
        if let second = interval.second {
            if(second <= 1 ){
                cell!.dateLabel.text = " Video Duration: \(second) Second"
            }else {
                cell!.dateLabel.text = " Video Duration: \(second) Seconds"
            }
        }
    
        if let tag = mediaObject.caption {
            cell!.tagLabel.text = " Tag: \(tag)"
        }
        if let videoData = mediaObject.videoData,
           let videoURL =  videoData.convertToURL()  {
            let image = videoURL.videoPreviewThumbnail() ?? UIImage(systemName: "heart")
            cell!.myImageView.image = image
        }
        return cell!
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        myCurrentButton = indexPath.item
        prepCustomMenu()
    }
    
    
    
   
}



//MARK: - UICollection View Delegate Methods
extension RecordingListViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: myVertCVSpacing, left: myVertCVSpacing, bottom: myVertCVSpacing, right: myVertCVSpacing)
    }
}

