//
//  MainViewController.swift
//  Milestone -Day99-Concentration
//
//  Created by Maryna Bolotska on 25/12/23.
//

import UIKit
import SnapKit



class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    let images: [UIImage] = [
//        UIImage(named: "1"),
//        UIImage(named: "2"),
//        UIImage(named: "3"),
//        UIImage(named: "4"),
//    ].compactMap { $0 }
    var imageNames: [String] = []
    let baseImageNames = ["image1", "image2", "image3"]

    lazy var images = Array(repeating: baseImageNames, count: 2).flatMap { $0 }
    
    
    let reuseIdentifier = "ImageCell"
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        
      
        
        imageNames = Array(repeating: baseImageNames, count: 2).flatMap { $0 }
    }
    
    private func setupCollectionView() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        let layout = UICollectionViewFlowLayout()
            layout.minimumInteritemSpacing = 50 
            layout.minimumLineSpacing = 50
            collectionView.collectionViewLayout = layout
    }
    
   
    
    
    // MARK: UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return images.count
  
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ImageCell

       
        
        
        cell.imageName = images[indexPath.row]
        
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
           // Specify the minimum line spacing (vertical spacing between cells in the same column)
           return 50 // Adjust as needed
       }
  
}

