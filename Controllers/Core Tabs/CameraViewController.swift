//
//  CameraViewController.swift
//  AR Camera
//
//  Created by Joel Crawford on 7/1/22.
//

import UIKit
import Photos

class CameraViewController: UIViewController {
    
    let docsDir: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! //documnet directory
    var popUpWindow:PopupWindow!
    var filename: String =  ""

    
    @IBOutlet weak var cameraButton: CustomButton!
    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var toggleCameraButton: UIButton!
    
    @IBOutlet weak var galleryButton: UIButton!
    @IBOutlet weak var cameraSelectionButton: UIButton!
    @IBOutlet weak var videoCameraButton: UIButton!
    @IBOutlet weak var toggleFlashButton: UIButton!
    
    var cameraConfig: CameraConfiguration!
    let imagePickerController = UIImagePickerController()
    
    var videoRecordingStarted: Bool = false {
        didSet{
            if videoRecordingStarted {
                self.cameraButton.backgroundColor = UIColor.red
            } else {
                self.cameraButton.backgroundColor = UIColor.white
            }
        }
    }
    
    func checkPermission(completion: @escaping ()->Void) {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized:
            print("Access is granted by user")
            completion()
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({
                (newStatus) in
                print("status is \(newStatus)")
                if newStatus ==  PHAuthorizationStatus.authorized {
                    /* do stuff here */
                    completion()
                    print("success")
                }
            })
            print("It is not determined until now")
        case .restricted:
            // same same
            print("User do not have access to photo album.")
        case .denied:
            // same same
            print("User has denied the permission.")
        default: return
        }
        
    }
    
    fileprivate func registerNotification() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: NSNotification.Name(rawValue: "App is going background"), object: nil)
        
        notificationCenter.addObserver(self, selector: #selector(appCameToForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    @objc func appMovedToBackground() {
        if videoRecordingStarted {
            videoRecordingStarted = false
            self.cameraConfig.stopRecording { (error) in
                print(error ?? "Video recording error")
            }
        }
    }
    
    @IBAction func gotoGallery(_ sender: Any) {
        Utilities.vibrate()
        checkPermission(completion: {
            DispatchQueue.main.async {
            self.imagePickerController.sourceType = .photoLibrary
            self.imagePickerController.delegate = self
            self.imagePickerController.mediaTypes = ["public.image", "public.movie"]
            self.present(self.imagePickerController, animated: true, completion: nil)
            }
        })
    }
    
    @objc func appCameToForeground() {
        print("app enters foreground")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cameraConfig = CameraConfiguration()
        cameraConfig.setup { (error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            try? self.cameraConfig.displayPreview(self.previewImageView)
        }
        self.cameraButton.setImage(#imageLiteral(resourceName: "camera"), for: .normal)
        self.cameraButton.tintColor = UIColor.black
        self.galleryButton.setImage(#imageLiteral(resourceName: "photo_icon"), for: .normal)
        registerNotification()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    //MARK: - TOGGLE FLASH
    @IBAction func toggleFlash(_ sender: Any) {
        Utilities.vibrate()
        if cameraConfig.flashMode == .on {
            cameraConfig.flashMode = .off
            self.toggleFlashButton.setImage(#imageLiteral(resourceName: "flash_off"), for: .normal)
        } else if cameraConfig.flashMode == .off {
            cameraConfig.flashMode = .on
            self.toggleFlashButton.setImage(#imageLiteral(resourceName: "flash_on"), for: .normal)
        } else {
            cameraConfig.flashMode = .auto
            self.toggleFlashButton.setImage(#imageLiteral(resourceName: "flash_auto"), for: .normal)
        }
    }
    
    @objc fileprivate func showToastForSaved() {
        showToast(message: "Saved!", fontSize: 12.0)
    }
    
    @objc fileprivate func showToastForRecordingStopped() {
        showToast(message: "Recording Stopped", fontSize: 12.0)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            showToast(message: "Could not save!! \n\(error)", fontSize: 12)
        } else {
            showToast(message: "Saved", fontSize: 12.0)
            self.galleryButton.setImage(image, for: .normal)
        }
    }
    
    @objc func video(_ video: String, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        Utilities.vibrate()
        if let error = error {
            // we got back an error!
            
            showToast(message: "Could not save!! \n\(error)", fontSize: 12)
        } else {
            
//            let alertController = UIAlertController(title: "Enter Tag", message: "", preferredStyle: UIAlertController.Style.alert)
//
//            let saveAction = UIAlertAction(title: "OK",
//                                   style: UIAlertAction.Style.default) { (action: UIAlertAction) in
//
//                               if let alertTextField = alertController.textFields?.first, alertTextField.text != nil {
//                                   print("And the text is... \(alertTextField.text!)!")
//                                   //str.trimmingCharacters(in: .whitespacesAndNewlines)
//                                   let replaced  = video.replacingOccurrences(of: "output", with: alertTextField.text!)
//                                   let formattedString = replaced.trimmingCharacters(in: .whitespacesAndNewlines).safeDatabaseKey()
//                                                  print("TAG: \(formattedString)")
//                               }
//             }
//
//            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {
//                    (action : UIAlertAction!) -> Void in })
//            alertController.addTextField { (textField : UITextField!) -> Void in
//                    textField.placeholder = "Enter Tag Here"
//                }
//                alertController.addAction(saveAction)
//                alertController.addAction(cancelAction)
//
//            self.present(alertController, animated: true, completion: nil)
            
            showToast(message: "Saved", fontSize: 12.0)
        }
        print("VIDEO LOCATION: \(video)")
    }
    
    @IBAction func didTapOnTakePhotoButton(_ sender: Any) {
        Utilities.vibrate()
        if self.cameraConfig.outputType == .photo {
            self.cameraConfig.captureImage { (image, error) in
                guard let image = image else {
                    print(error ?? "Image capture error")
                    return
                }
                self.previewImageView.image = image
                UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
            }
        } else {
            if videoRecordingStarted {
                videoRecordingStarted = false
                self.cameraConfig.stopRecording { (error) in
                    print(error ?? "Video recording error")
                }
            } else if !videoRecordingStarted {
                videoRecordingStarted = true
                self.cameraConfig.recordVideo(fileName: filename) { (url, error) in
                    guard let url = url else {
                        print(error ?? "Video recording error")
                        return
                    }
                    
                    print("URL: \(url)")
                    
                    
                    let alertController = UIAlertController(title: "Enter Tag", message: "", preferredStyle: UIAlertController.Style.alert)
                
                    let saveAction = UIAlertAction(title: "OK",
                                           style: UIAlertAction.Style.default) { (action: UIAlertAction) in

                                       if let alertTextField = alertController.textFields?.first, alertTextField.text != nil {
                                           print("And the text is... \(alertTextField.text!)!")
                                           //str.trimmingCharacters(in: .whitespacesAndNewlines)
                                           //let replaced  = video.replacingOccurrences(of: "output", with: alertTextField.text!)
                                           let formattedString = alertTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines).safeDatabaseKey()
                                                          print("TAG: \(formattedString)")
                                           
                                           self.filename = formattedString
                                       }
                     }
                    
                    let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {
                            (action : UIAlertAction!) -> Void in })
                    alertController.addTextField { (textField : UITextField!) -> Void in
                            textField.placeholder = "Enter Tag Here"
                        }
                        alertController.addAction(saveAction)
                        alertController.addAction(cancelAction)
                        
                    self.present(alertController, animated: true, completion: nil)
                    
                    UISaveVideoAtPathToSavedPhotosAlbum(url.path, self, #selector(self.video(_:didFinishSavingWithError:contextInfo:)), nil)
                }
            }
        }
    }
    
    
    @IBAction func toggleCamera(_ sender: Any) {
        Utilities.vibrate()
        do {
            try cameraConfig.switchCameras()
        } catch {
            print(error.localizedDescription)
        }
        
//        switch cameraConfig.currentCameraPosition {
//        case .some(.front):
//            self.toggleCameraButton.setImage(#imageLiteral(resourceName: "camera_front"), for: .normal)
//        case .some(.rear):
//            self.toggleCameraButton.setImage(#imageLiteral(resourceName: "camera_rear"), for: .normal)
//        default:
//            return
//        }
    }
    @IBAction func selectVideoMode(_ sender: Any) {
        Utilities.vibrate()
        self.cameraConfig.outputType = .video
        self.cameraButton.setImage(#imageLiteral(resourceName: "videocam"), for: .normal)
    }
    @IBAction func selectCameraMode(_ sender: Any) {
        Utilities.vibrate()
        self.cameraConfig.outputType = .photo
        self.cameraButton.setImage(#imageLiteral(resourceName: "camera"), for: .normal)
    }
    
    
    
    func createDir(dir: String) {
        let fullDirPath = docsDir + "/" + dir
        print(fullDirPath) //Remove later when uploading to Appstore
        let fileManager     = FileManager.default
        var isDirectory: ObjCBool = false
        if !fileManager.fileExists(atPath: fullDirPath, isDirectory: &isDirectory) {
            // Only create the directory if it does not already exist
            do {
                try FileManager.default.createDirectory(atPath: fullDirPath, withIntermediateDirectories: true, attributes: nil)
                print("Subdirectory " + dir + " created")
            } catch {
                print(error)
            }
        }
    }
}


extension CameraViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.galleryButton.contentMode = .scaleAspectFit
            self.galleryButton.setImage( pickedImage, for: .normal)
        }
        if let videoURL = info[UIImagePickerController.InfoKey.mediaURL] as? URL {
            print("videoURL:\(String(describing: videoURL))")
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
