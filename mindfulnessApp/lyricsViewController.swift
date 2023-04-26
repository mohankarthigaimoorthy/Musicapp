//
//  lyricsViewController.swift
//  mindfulnessApp
//
//  Created by Mohan K on 03/02/23.
//

import UIKit
import AVFoundation
import AVKit
import MediaPlayer

class lyricsViewController: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var search: UIButton!
    
    @IBOutlet weak var optionsBtn: UIButton!
    
    
    @IBOutlet weak var playPause: UIButton!
    
    @IBOutlet weak var songSlider: UISlider!
    
    var isMix = false
    var randomInt = 0
    var nowPlayingInfo = [String : Any]()
    var audioPlayer = AVAudioPlayer()
    var activeSong = 0
    var songList : [String] = []
    var progressBarTimer: Timer!
    var progressValue: Float = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        backgroundView.layer.cornerRadius = 20
        getSongs()
        prepareSong()
        
        songSlider.value = 0
        songSlider.minimumValue = 0
        
        songSlider.isUserInteractionEnabled = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        audioPlayer.pause()
    }

    @IBAction func btnPlayPause(_ sender: Any) {
        if audioPlayer.isPlaying {
            audioPlayer.pause()
            trackAudio()
            playPause.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
        }
        else {
            audioPlayer.play()
            updateTime()
            playPause.setImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
        }
    }
    
    func trackAudio() {
        var normalizedTime = Float(audioPlayer.currentTime * 100.0 / audioPlayer.duration)
        songSlider.setValue(normalizedTime, animated: true)
    }
    
    func updateTime() {
        progressBarTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
    }
    
    @objc func update (_ timer: Timer) {
        trackAudio()
    }
    
    func prepareSong() {
        do {
            let audioPath = Bundle.main.path(forResource: songList[activeSong], ofType: ".mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            audioPlayer.prepareToPlay()
            audioPlayer.delegate = self
            
            songSlider.maximumValue = Float(audioPlayer.duration)
        }
        catch {
            print (error.localizedDescription)
        }
    }
    
    func getSongs() {
        let folderUrl = URL(fileURLWithPath: Bundle.main.resourcePath!)
        do {
            let path = try
            FileManager.default.contentsOfDirectory(at: folderUrl, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            for song_ in path {
                var songName = song_.absoluteString
                if songName.contains(".mp3")
                {
                    let fileString = songName.components(separatedBy: "/")
                    songName = fileString[fileString.count - 1]
                    songName = songName.replacingOccurrences(of: ".mp3", with: "")
                    songName = songName.replacingOccurrences(of: ".mp3", with: "")
                    songList.append(songName)
                }
            }
        }
        catch {
            print("err")
        }
    }
    
    func playThisSong(activeSong : String) {
        do {
            let audioPath = Bundle.main.path(forResource: activeSong, ofType: ".mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            audioPlayer.prepareToPlay()
            randomInt = Int.random(in: 0...songList.count)
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func pauseSong() {
        if audioPlayer.isPlaying {
            audioPlayer.pause()
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
