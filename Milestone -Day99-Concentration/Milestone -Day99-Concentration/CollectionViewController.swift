//
//  CollectionViewController.swift
//  Milestone -Day99-Concentration
//
//  Created by Maryna Bolotska on 26/12/23.
//

import UIKit

//private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {
  
    let baseImageNames = ["1", "2", "3", "4"]
    lazy var imageNames = Array(repeating: baseImageNames, count: 2).flatMap { $0 }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageNames.shuffle()
        

    }

 

    // MARK: UICollectionViewDataSource

 


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNames.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
    
        
        let imageName = imageNames[indexPath.item]
//        cell.image.image = UIImage(named: imageName)
        cell.image.image = UIImage(named: "cover")
        return cell
    }

    
    @IBAction func buttonPressed(_ sender: UIButton) {
      
        
    }
    
}
