//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Mustafa on 27.11.2021.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var audioRecorder: AVAudioRecorder!
    
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopButtonOutlet: UIButton!
    @IBOutlet weak var recordButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        stopButtonOutlet.isEnabled = false
        recordingLabel.text = "Tap to Record"
    }
    
    //Sesi kayıt etme işlemini bu alanda yapıyoruz.
    @IBAction func recordButtonPressed(_ sender: UIButton) {
        stopButtonOutlet.isEnabled = true
        recordButtonOutlet.isEnabled = false
        recordingLabel.text = "Recording in progress..."
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    
    @IBAction func stopButtonPressed(_ sender: UIButton) {
        stopButtonOutlet.isEnabled = false
        recordButtonOutlet.isEnabled = true
        recordingLabel.text = "Recording stopped"
    }
}

