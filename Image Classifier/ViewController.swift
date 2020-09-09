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

class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate, UIViewControllerTransitioningDelegate {
    
    var captureSession: AVCaptureSession!
    
    var image: UIImage?
    
    var args: Dictionary<String,Int> = [:]
    var count = 0
    
    @IBOutlet weak var imageClassifierLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .photo
        
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        
        guard let input = try? AVCaptureDeviceInput(device: captureDevice) else { return }
        
        captureSession.addInput(input)
        
        //        try? captureDevice.lockForConfiguration()
        //        captureDevice.activeVideoMinFrameDuration = CMTimeMake(value: 1, timescale: 200)
        //        captureDevice.activeVideoMaxFrameDuration = CMTimeMake(value: 1, timescale: 200)
        //        captureDevice.unlockForConfiguration()
        
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
        
        connection.videoOrientation = AVCaptureVideoOrientation.portrait
        let imageBuffer: CVPixelBuffer = sampleBuffer.imageBuffer!
        let ciimage : CIImage = CIImage(cvPixelBuffer: imageBuffer)
        image = self.convert(cmage: ciimage)
        
        //        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        //        let attachments = CMCopyDictionaryOfAttachments(allocator: kCFAllocatorDefault, target: sampleBuffer, attachmentMode: kCMAttachmentMode_ShouldPropagate)
        //        let ciImage = CIImage(cvImageBuffer: imageBuffer, options: (attachments as! [CIImageOption : Any]))
        //
        //        image = UIImage(ciImage: ciImage)
        
        
        guard let model = try? VNCoreMLModel(for: ImageClassifier().model) else { return }
        
        let coreMLRequest = VNCoreMLRequest(model: model) { (finishedRequest, Error) in
            
            guard let results = finishedRequest.results as? [VNClassificationObservation] else { return }
            
            guard let firstObservation = results.first else { return }
            
            print(firstObservation.identifier, firstObservation.confidence)
            
            DispatchQueue.main.async {
                
                if var iter = self.args[String(firstObservation.identifier)]{
                    iter += 1
                }else{
                    self.args.updateValue(1, forKey: String(firstObservation.identifier))
                }
                
                self.count += 1
                
                if (self.count >= 50){
                    var max = String(firstObservation.identifier)
                    var max_i = self.args[max]
                    for item in self.args {
                        if item.value > max_i! {
                            max = item.key
                            max_i = item.value
                        }
                    }
                    
                    self.imageClassifierLabel.text = max
                    
                    self.count = 0
                    self.args = [:]
                }
                
                
            }
            
        }
        
        try? VNImageRequestHandler(cvPixelBuffer: imageBuffer, options: [:]).perform([coreMLRequest])
    }
    
    // Convert CIImage to CGImage
    func convert(cmage:CIImage) -> UIImage {
        let context:CIContext = CIContext.init(options: nil)
        let cgImage:CGImage = context.createCGImage(cmage, from: cmage.extent)!
        let image:UIImage = UIImage.init(cgImage: cgImage)
        return image
    }
    
    @IBAction func categroy(_ sender: Any) {
        let categroyVC = storyboard!.instantiateViewController(withIdentifier: "CategoryVC") as! CategroyViewController
        
        categroyVC.transitioningDelegate = self
        categroyVC.modalPresentationStyle = .fullScreen
        present(categroyVC, animated: true, completion: nil)
        
    }
    
}

extension ViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "takePhoto" {
            let vc = segue.destination as! DetailViewController
            vc.image = self.image
            vc.name = self.imageClassifierLabel.text
        }
    }
    
}

