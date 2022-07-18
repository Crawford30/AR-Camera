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
        Utilities.vibrate()
        print("Cell: \(indexPath.item) tapped")
        let mediaObject = mediaObjects[indexPath.row]
        let playerViewController = AVPlayerViewController()
        let videoObject  = mediaObject.videoData
        
        if let videoObject = videoObject?.convertToURL() {
            let player  = AVPlayer(url: videoObject)
            playerViewController.player = player
            playerViewController.videoGravity = .resizeAspectFill
            present(playerViewController, animated: true, completion: nil)
            player.play()
        }
        
        
    }
    
    
}



//MARK: - UICollection View Delegate Methods
extension RecordingListViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: myVertCVSpacing, left: myVertCVSpacing, bottom: myVertCVSpacing, right: myVertCVSpacing)
    }
    
}

