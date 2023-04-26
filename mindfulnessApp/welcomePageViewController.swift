//
//  welcomePageViewController.swift
//  mindfulnessApp
//
//  Created by Mohan K on 01/02/23.
//

import UIKit

struct Peace {
    var text: String
    var new: String
    init (text: String, new: String) {
        self.text = text
        self.new = new
    }
}
class welcomePageViewController: UIViewController {

    
    @IBOutlet weak var welcome: UIView!
    
    
    @IBOutlet weak var welcomePage: UICollectionView!
    
    var calm = [Peace]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        welcomePage.register(peacfulCollectionViewCell.nib(), forCellWithReuseIdentifier: peacfulCollectionViewCell.identifier)
        mercy()
        calm.append(Peace(text: "innerPeace", new: "mental Illeness"))
        calm.append(Peace(text: "outerPeace", new: "through friends"))
        calm.append(Peace(text: "worldPeace", new: "keep support"))
        
        welcome.layer.cornerRadius = 15
    }
    
    func mercy(){
        welcomePage.dataSource = self
        welcomePage.delegate = self
        
        DispatchQueue.main.async {
            self.welcomePage.reloadData()
        }
    }
    

}

extension welcomePageViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return calm.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = welcomePage.dequeueReusableCell(withReuseIdentifier: "peacfulCollectionViewCell", for: indexPath) as! peacfulCollectionViewCell
        cell.headingLbl.text = calm[indexPath.row].text
        cell.concernLbl.text = calm[indexPath.row].new
        return cell
    }
    func collectionView(_ collectionView: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        let width = (collectionView.accessibilityFrame.width - 100) / 3
        return CGSize(width: 200, height: 500)
    }
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        let  position = indexPath.item
        
        if position == 0 {
            guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "trackViewController") as?  trackViewController else { return}
            self.navigationController?.pushViewController(vc, animated: true)
        } else if position == 1 {
            guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "listViewController") as?  listViewController else { return}
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "listViewController") as?  listViewController else { return}
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
//        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "albumViewController") as?  albumViewController else { return}
//        self.navigationController?.pushViewController(vc, animated: true)
//        present(vc, animated:  true)
    }
}
