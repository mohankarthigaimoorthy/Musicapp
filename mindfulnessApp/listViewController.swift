//
//  listViewController.swift
//  mindfulnessApp
//
//  Created by Mohan K on 03/02/23.
//

import UIKit
import AVFoundation
import AVKit
import MediaPlayer

struct positiveVibes {
    var text : String
    var old : String
    init(text: String, old: String) {
        self.text = text
        self.old = text
    }
}
class listViewController: UIViewController, AVAudioPlayerDelegate {
    
    @IBOutlet weak var listView: UICollectionView!
    
    @IBOutlet weak var collectionList: UIImageView!
    
    @IBOutlet weak var searchbtn: UIButton!
    
    @IBOutlet weak var musicSlider: UISlider!
    
    
    @IBOutlet weak var PlayButton: UIButton!
    
    @IBOutlet weak var optionbtn: UIButton!
    
    
    @IBOutlet weak var musicviewView: UIView!
    
    
    var MoneyHeist = [positiveVibes]()
    
    var isMix = false
    var randomInt = 0
    var nowplayingInfo = [String : Any]()
    var audioPlayer = AVAudioPlayer()
    var activeSong = 0
    var songList: [String] = []
    var progresBarTimer: Timer!
    var progressValue: Float = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        listView.register(listTypeCollectionViewCell.nib(), forCellWithReuseIdentifier: listTypeCollectionViewCell.identifier)
       
        MoneyHeist.append(positiveVibes(text: "masterPeace", old: "Peace"))
        MoneyHeist.append(positiveVibes(text: "mastercalm", old: "calm"))
        MoneyHeist.append(positiveVibes(text: "masterHappy", old: "Happy"))
        MoneyHeist.append(positiveVibes(text: "masterKind", old: "Kind"))
        MoneyHeist.append(positiveVibes(text: "masterPassion", old: "Passion"))
        MoneyHeist.append(positiveVibes(text: "masterJoy", old: "Joy"))
        MoneyHeist.append(positiveVibes(text: "masterBrain", old: "Brain"))
        MoneyHeist.append(positiveVibes(text: "masterPeace", old: "Peace"))
        MoneyHeist.append(positiveVibes(text: "mastercalm", old: "calm"))
        MoneyHeist.append(positiveVibes(text: "masterHappy", old: "Happy"))
        MoneyHeist.append(positiveVibes(text: "masterKind", old: "Kind"))
        MoneyHeist.append(positiveVibes(text: "masterPassion", old: "Passion"))
        MoneyHeist.append(positiveVibes(text: "masterJoy", old: "Joy"))
        MoneyHeist.append(positiveVibes(text: "masterBrain", old: "Brain"))
        // Do any additional setup after loading the view.
        
        getSongs()
        prepareSong()
        
        musicSlider.value = 0
        musicSlider.minimumValue = 0
        musicviewView.layer.cornerRadius = 20
        
        musicSlider.isUserInteractionEnabled = false
        listView.dataSource = self
        listView.delegate = self
        
        DispatchQueue.main.async {
            self.listView.reloadData()
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(trackViewController.tappedMe))
        collectionList.addGestureRecognizer(tap)
        collectionList.isUserInteractionEnabled = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        audioPlayer.pause()
    }
    @objc func tappedMe() {
        
        
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "albumViewController") as?  albumViewController else { return}
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func btnPlay(_ sender: Any) {
        if audioPlayer.isPlaying {
            audioPlayer.pause()
            trackAudio()
            PlayButton.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
        }
        else {
            audioPlayer.play()
            updateTime()
            PlayButton.setImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
        }
    }
    
    func trackAudio() {
        var normalizedTime = Float (audioPlayer.currentTime * 100.0 / audioPlayer.duration)
        musicSlider.setValue(normalizedTime, animated: true)
    }
    
    func updateTime() {
        progresBarTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
    }
    
    @objc func update (_ timer: Timer) {
        trackAudio()
    }
    func prepareSong() {
        do {
            let audioPath = Bundle.main.path(forResource: songList[activeSong], ofType: ".mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!)  as URL )
            audioPlayer.prepareToPlay()
            audioPlayer.delegate = self
            
            musicSlider.maximumValue = Float(audioPlayer.duration)
            
        }
        catch{
            print(error.localizedDescription)
        }
    }
    
    func getSongs()
    {
        let folderUrl = URL(fileURLWithPath: Bundle.main.resourcePath!)
        do {
            let path = try
            FileManager.default.contentsOfDirectory(at: folderUrl, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            for song_ in path{
                var songName = song_.absoluteString
                if songName.contains(".mp3")
                {
                    let fileString = songName.components(separatedBy: "/")
                    songName = fileString[fileString.count - 1]
                    songName = songName.replacingOccurrences(of: "%20", with: "")
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
            let  audioPath = Bundle.main.path(forResource: activeSong, ofType: ".mp3")
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

extension listViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MoneyHeist.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = listView.dequeueReusableCell(withReuseIdentifier: "listTypeCollectionViewCell", for: indexPath) as!
        listTypeCollectionViewCell
        cell.headingTopic.text = MoneyHeist[indexPath.row].text
        cell.subTopics.text = MoneyHeist[indexPath.row].old
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 20) / 2
        print("\(width)")
        return CGSize(width: width, height:200)
        
    }
  
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let  position = indexPath.item
        
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "trackViewController") as?  trackViewController else { return}
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
