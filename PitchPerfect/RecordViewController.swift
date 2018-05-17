//
//  RecordViewController.swift
//  PitchPerfect
//
//  Created by shamsher ahmed on 15/05/18.


import UIKit
import  AVFoundation

class RecordViewController: UIViewController ,AVAudioRecorderDelegate{

    @IBOutlet weak var stopRecording: UIButton!
    @IBOutlet weak var recordLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recordLabel.text = "Tap to record"
        stopRecording.isEnabled = false
        recordButton.isEnabled = true
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func startRecording(_ sender: Any) {
        
        recordLabel.text = "Recording in progress"
        stopRecording.isEnabled = true
        recordButton.isEnabled = false
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        //File Name
        let recordingName = "recordedVoice.wav"
        // Combining the file and directory path
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        //print(filePath)
        
        //Creating Audio Session for recording audio
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag{
            print("Audio Recording finished")
            performSegue(withIdentifier: "stopRecordingSegue", sender: audioRecorder.url)
        }else{
            print("Recording didn't saved successfully")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "stopRecordingSegue"{
            let playAVC = segue.destination as! PlaySoundsViewController
            let audioRecordUrl = sender as! URL
            playAVC.recordedAudioUrl = audioRecordUrl
        }
    }
    @IBAction func stopRecording(_ sender: Any) {
        stopRecording.isEnabled = false
        recordButton.isEnabled = true
        
        recordLabel.text = "Tap to record"
        
        let audioSession = AVAudioSession.sharedInstance();
        try! audioSession.setActive(false)
        
        // Audio recording is finished and it will be triggered when recording is finished.
        audioRecorder.stop()
        
    }
}

