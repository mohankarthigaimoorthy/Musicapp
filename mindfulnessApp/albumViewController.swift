//
//  albumViewController.swift
//  mindfulnessApp
//
//  Created by Mohan K on 02/02/23.
//

import UIKit
import AVFoundation
import AVKit
import MediaPlayer

class albumViewController: UIViewController, AVAudioPlayerDelegate {
    
    struct  Time {
        var library: String
        var list: String
        var image: String
        init(library: String, list: String, image: String) {
            self.library = library
            self.list = list
            self.image = image
        }
    }

    
    
    
    @IBOutlet weak var songBtn: UIButton!
    
    @IBOutlet weak var musicView: UIView!
    
    @IBOutlet weak var albumImg: UIImageView!
    
    @IBOutlet weak var playBtn: UIButton!
    
    @IBOutlet weak var musicList: UITableView!
    
    @IBOutlet weak var progressSlider: UISlider!
    
    
    @IBOutlet weak var optionBtn: UIButton!
    
    @IBOutlet weak var searchBtn: UIButton!
    
    
    
    var isMix = false
    var randomInt = 0
    var nowplayingInfo = [String : Any]()
    var audioPlayer = AVAudioPlayer()
    var activeSong = 0
    var songList : [String] = []
    var progressBarTimer: Timer!
//    var progressState: progressState = .Start
    var progressValue: Float = 0.0
 
    var problem = [Time]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        problem.append(Time(library: "Positivity", list: "SPB", image: "image1"))
        problem.append(Time(library: "Peaceful", list: "MSV", image: "image2"))
        problem.append(Time(library: "Peaceful", list: "ANIRUDH", image: "image3"))
        problem.append(Time(library: "virutual", list: "YUVAN", image: "image4"))
        problem.append(Time(library: "Peaceful", list: "GV", image: "image5"))
        problem.append(Time(library: "virutual", list: "YUVAN", image: "image4"))
        problem.append(Time(library: "Peaceful", list: "GV", image: "image5"))
        
        getSongs()
        prepareSong()
//        pauseSong()
        
        progressSlider.value = 0
        progressSlider.minimumValue = 0
        
       
        let tap = UITapGestureRecognizer(target: self, action: #selector(tappedMe))
        albumImg.addGestureRecognizer(tap)
        albumImg.isUserInteractionEnabled = true
        
      
        musicView.layer.cornerRadius = 20
        musicList.delegate = self
        musicList.dataSource = self
        DispatchQueue.main.async {
            self.musicList.reloadData()
        }
        // Do any additional setup after loading the view.
        
        progressSlider.isUserInteractionEnabled = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
    audioPlayer.pause()
//    audioPlayer.currentItem = nil
    }
    @objc func pingMe() {
        nextsong()
    }
    
    @objc func tappedMe() {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "listViewController") as?  listViewController else { return}
        self.navigationController?.pushViewController(vc, animated: true)
    }
   
    @IBAction func playButton(_ sender: UIButton) {
        if audioPlayer.isPlaying {
            audioPlayer.pause()
            trackAudio()
            playBtn.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
        } else {
            audioPlayer.play()
            updateTime()
            playBtn.setImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
        }
    }
    
    func trackAudio() {
        var normalizedTime = Float(audioPlayer.currentTime * 100.0 / audioPlayer.duration)
        progressSlider.setValue(normalizedTime, animated: true)
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
            
            progressSlider.maximumValue = Float(audioPlayer.duration)
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func getSongs() {
        let folderUrl = URL(fileURLWithPath: Bundle.main.resourcePath!)
        do{
            let path = try FileManager.default.contentsOfDirectory(at: folderUrl, includingPropertiesForKeys: nil, options:
                    .skipsHiddenFiles)
            for song_ in path{
                var songName = song_.absoluteString
                if songName.contains(".mp3")
                {
                    let fileString = songName.components(separatedBy: "/")
                    songName = fileString[fileString.count - 1]
                    songName = songName.replacingOccurrences(of: "%20", with: "")
                    songName = songName.replacingOccurrences(of: ".mp3", with: "")
                    songList.append(songName)
                    print(songName)
                }
            }
        }
        
        catch{
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
        catch{
            print(error.localizedDescription)
        }
    }
    
    func pauseSong() {
        if audioPlayer.isPlaying {
            audioPlayer.pause()
        }
    }
    
    func nextsong() {
        if isMix {
            if randomInt < songList.count - 1 {
                randomInt += 1
                activeSong = randomInt
                playThisSong(activeSong: songList[activeSong])
               
                updateTime()
                audioPlayer.play()
                playBtn.setImage(UIImage(systemName: "pause.circle.fill"), for: .normal)

            }else{
                randomInt = 0
                activeSong = 0
                playThisSong(activeSong: songList[activeSong])
               
                updateTime()
                audioPlayer.play()
                playBtn.setImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
            }
            
        }else{
            if activeSong < songList.count - 1 {
                activeSong += 1
                if activeSong > songList.count {
                    activeSong = 0
                    return
                }
                playThisSong(activeSong: songList[activeSong])
              
                updateTime()
                audioPlayer.play()
                playBtn.setImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
            }else{
                activeSong = 0
                playThisSong(activeSong: songList[activeSong])
              
                updateTime()
                audioPlayer.play()
                playBtn.setImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
            }
        }
    }
}

extension albumViewController: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return problem.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = musicList.dequeueReusableCell(withIdentifier: "albumListTableViewCell", for: indexPath) as! albumListTableViewCell

        cell.albumImg.image = UIImage(named: problem[indexPath.row].image)
        cell.trackTitle.text = problem[indexPath.row].library
        cell.artistName.text = problem[indexPath.row].list

        let position = indexPath.row
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let position = indexPath.row
 
        if position == 0 {
            
            nextsong()
        }
        else if position == 1 {

            nextsong()
        }
        else if position == 2 {

            nextsong()
        }
        else if position == 3 {

            nextsong()
        }
        else if position == 4 {

            nextsong()
        }
        else if position == 5 {

            nextsong()
        }
        else if position == 6 {

            nextsong()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
        
    }
}
