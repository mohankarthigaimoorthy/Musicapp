//
//  trackViewController.swift
//  mindfulnessApp
//
//  Created by Mohan K on 02/02/23.
//

import UIKit

struct Track {
    var text: String
    var test: String
    var image: String
    init(text: String, test: String, image: String) {
        self.text = text
        self.test = test
        self.image = image
    }
}

class trackViewController: UIViewController {

    @IBOutlet weak var posterImg: UIImageView!
    @IBOutlet weak var topicsTable: UITableView!
    @IBOutlet weak var myImage: UIImageView!
    
    var demo = [Track]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        demo.append(Track(text: "Positivity", test: "one", image: "image 9"))
        demo.append(Track(text: "Peaceful", test: "two", image: "image 8"))
        demo.append(Track(text: "Peaceful", test: "three", image: "image 9"))
        demo.append(Track(text: "Spritual", test: "four", image: "image 10"))
        demo.append(Track(text: "virutual", test: "five", image: "image 9"))
        demo.append(Track(text: "Peaceful", test: "Six", image: "image 8"))
        // Do any additional setup after loading the view.
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tappedMe))
        posterImg.addGestureRecognizer(tap)
        posterImg.isUserInteractionEnabled = true
        
        topicsTable.delegate = self
        topicsTable.dataSource = self
        DispatchQueue.main.async {
            self.topicsTable.reloadData()        }
        myImage.layer.cornerRadius = myImage.layer.frame.width / 2
    }
    
    @objc func tappedMe() {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "albumViewController") as?  albumViewController else { return}
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

extension trackViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return demo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = topicsTable.dequeueReusableCell(withIdentifier: "spritualTableViewCell", for: indexPath) as! spritualTableViewCell
        cell.cellImage.image = UIImage(named: demo[indexPath.row].image)
        cell.tagsLbl.text = demo[indexPath.row].text
     
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let position = indexPath.row
        
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "albumViewController") as?  albumViewController else { return}
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
