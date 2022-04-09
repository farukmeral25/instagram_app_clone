//
//  StoryViewController.swift
//  InstagramApp
//
//  Created by Ömer Faruk MERAL on 9.04.2022.
//

import UIKit
import AVFoundation

class StoryViewController: UIViewController {
    
    let buttonTakePhoto : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "Fotograf_Cek").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(StoryViewController.self, action: #selector(buttonTakePhotoPressed), for: .touchUpInside)
        return button
    }()
    
    let buttonBack : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "Ok_Sag").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(StoryViewController.self, action: #selector(buttonBackPressed), for: .touchUpInside)
        return button
    }()

    fileprivate func editView() {
        view.addSubview(buttonTakePhoto)
        buttonTakePhoto.anchor(top: nil, bottom: view.bottomAnchor, leading: nil, trailing: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: -25, paddingRight: 0, width: 80, height: 80)
        buttonTakePhoto.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        view.addSubview(buttonBack)
        buttonBack.anchor(top: view.topAnchor, bottom: nil, leading: nil, trailing: view.trailingAnchor, paddingTop: 25, paddingLeft: 0, paddingBottom: 0, paddingRight: -15, width: 80, height: 80)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        takePhoto()
        editView()
    }
    
    @objc fileprivate func buttonTakePhotoPressed(){
        print("Fotoğraf çek")
    }
    
    @objc fileprivate func buttonBackPressed(){
        dismiss(animated: true,completion: nil)
    }
    
    fileprivate func takePhoto(){
        let captureSession = AVCaptureSession()
        guard let device = AVCaptureDevice.default(for: AVMediaType.video) else { return }
        do {
            let input = try AVCaptureDeviceInput(device: device)
            if captureSession.canAddInput(input){
                captureSession.addInput(input)
            }
        }catch let error {
            print("Camera cannot be accessed: ", error.localizedDescription)
        }
        
        let output = AVCapturePhotoOutput()
        if captureSession.canAddOutput(output){
            captureSession.addOutput(output)
        }
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.frame
        view.layer.addSublayer(previewLayer)
        captureSession.startRunning()
    }

}
