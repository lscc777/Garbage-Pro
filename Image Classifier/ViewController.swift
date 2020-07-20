//
//  ViewController.swift
//  Image Classifier
//
//  Created by 刘思程 on 2020/7/10.
//  Copyright © 2020 刘思程. All rights reserved.
//

import UIKit
import AVKit
import Vision

class ViewController: UIViewController,AVCapturePhotoCaptureDelegate, AVCaptureVideoDataOutputSampleBufferDelegate {

    var captureSession: AVCaptureSession!
    
    @IBOutlet weak var imageClassifierLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .photo
        
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        
        guard let input = try? AVCaptureDeviceInput(device: captureDevice) else { return }
        
        captureSession.addInput(input)
        
        captureSession.startRunning()
        
        let capturePreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        view.layer.addSublayer(capturePreviewLayer)
        capturePreviewLayer.frame = view.frame
        capturePreviewLayer.bounds.size.height = self.view.bounds.size.height - 200
        
        let captureDataOutput = AVCaptureVideoDataOutput()
        captureDataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        captureSession.addOutput(captureDataOutput)
        
    }
    
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
        guard let model = try? VNCoreMLModel(for: ImageClassifier().model) else { return }
        
        let coreMLRequest = VNCoreMLRequest(model: model) { (finishedRequest, Error) in
            
            guard let results = finishedRequest.results as? [VNClassificationObservation] else { return }
            
            guard let firstObservation = results.first else { return }
            
            print(firstObservation.identifier, firstObservation.confidence)
            
            DispatchQueue.main.async {
                self.imageClassifierLabel.text = String(firstObservation.identifier) 
            }
            
        }
        
        try? VNImageRequestHandler(cvPixelBuffer: imageBuffer, options: [:]).perform([coreMLRequest])
    }

    
}

