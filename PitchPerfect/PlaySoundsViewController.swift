//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by shamsher ahmed on 16/05/18.


import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    @IBOutlet weak var stopRecording: UIButton!
   
    @IBOutlet weak var echoPlayButton: UIButton!
    @IBOutlet weak var highPitchPlayButton: UIButton!
    @IBOutlet weak var lowPitchPlayButton: UIButton!
    @IBOutlet weak var fastPlayButton: UIButton!
    @IBOutlet weak var slowPlayButton: UIButton!
    @IBOutlet weak var reverbPlayButton: UIButton!
    
    var recordedAudioUrl: URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int {
        case fast = 0 ,slow,high,low,echo,reverb
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI(.notPlaying)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio();
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func stopPlaying(_ sender: Any) {
        print("Stop Button Clicked")
         stopAudio()
    }

    @IBAction func playRecordedAudio(_ sender: UIButton) {
        print("play Audio Button")
        
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
            print("slow")
        case .fast:
            playSound(rate: 1.5)
            print("fast")
        case .low:
            playSound(pitch: 1000)
            print("low")
        case .high:
            playSound(pitch: -1000)
            print("high")
        case .echo:
            playSound(echo: true)
            print("echo")
        case .reverb:
            playSound(reverb: true)
            print("reverb")
        }
        configureUI(.playing)
    }
}
