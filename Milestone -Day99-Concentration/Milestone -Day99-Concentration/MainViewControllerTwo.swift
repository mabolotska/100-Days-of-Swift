//
//  MainViewControllerTwo.swift
//  Milestone -Day99-Concentration
//
//  Created by Maryna Bolotska on 28/12/23.
//

import UIKit
import SnapKit

class MainViewControllerTwo: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var images: [UIImage?] = [UIImage(named: "1"), UIImage(named: "2"), UIImage(named: "1"), UIImage(named: "2"), UIImage(named: "1"), UIImage(named: "2"), UIImage(named: "1"), UIImage(named: "2"), UIImage(named: "1"), UIImage(named: "2"), UIImage(named: "1"), UIImage(named: "3"),UIImage(named: "3"),UIImage(named: "4"),UIImage(named: "4"),].shuffled()
        var selectedImages: [UIImage] = []
       var isFlipped = true
        
        let reuseIdentifier = "MyCellTwo"
        private let collectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.backgroundColor = .white
            return collectionView
        }()

        override func viewDidLoad() {
            super.viewDidLoad()
            setupCollectionView()
            
          
        }
        
        private func setupCollectionView() {
            view.backgroundColor = .white
            view.addSubview(collectionView)
            
            collectionView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(MyCellTwo.self, forCellWithReuseIdentifier: reuseIdentifier)
            
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MyCellTwo
        
//        if isFlipped {
//            cell.button.backgroundColor = .blue
//            cell.button.addTarget(self, action: #selector(buttonTappedTwo(_:)), for: .touchUpInside)
//        } else {
//            let image = images[indexPath.item]
//            cell.button.setBackgroundImage(image, for: .normal)
//            cell.button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
//           
//        }
        
 

        return cell
        
       
    }
    
 
               // MARK: Button Action

               @objc private func buttonTapped(_ sender: UIButton) {
                   guard let image = sender.backgroundImage(for: .normal) else { return }

                   if selectedImages.contains(image) {
                       // Hiding buttons if both buttons with the same image are pressed
                       collectionView.visibleCells
                           .compactMap { $0 as? MyCellTwo }
                           .filter { $0.button.backgroundImage(for: .normal) == image }
                           .forEach { $0.button.isHidden = true }
                   } else {
                       // Show image
                       // Your logic to show the image goes here
                       print("Show image for \(image)")
                       selectedImages.append(image)
                   }
               }
    
    @objc private func buttonTappedTwo(_ sender: UIButton) {
        sender.backgroundColor = .green
    }
    
    
//
//        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//               // Specify the minimum line spacing (vertical spacing between cells in the same column)
//               return 50 // Adjust as needed
//           }
      
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           // Return the size you want for each cell
           return CGSize(width: 90, height: 90)
       }
    }



class MyCellTwo: UICollectionViewCell {
    var isFlipped = true {
        didSet {
            let backColor = isFlipped ? UIColor.gray : UIColor.blue
            
            button.backgroundColor = backColor
        }
    }
    
    
    let button: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 2
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        contentView.addSubview(button)
        button.snp.makeConstraints { make in
        //    make.edges.equalToSuperview().inset(10)
            make.height.equalTo(70)
            make.width.equalTo(70)
        }
    }
}
