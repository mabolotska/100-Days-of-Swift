//
//  CollectionViewCell.swift
//  Milestone -Day99-Concentration
//
//  Created by Maryna Bolotska on 26/12/23.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    let baseImageNames = ["1", "2", "3", "4"]
    lazy var imageNames = Array(repeating: baseImageNames, count: 2).flatMap { $0 }
    
    
    @IBOutlet weak var image: UIImageView!
    
    
    
    func configure(with imagen: UIImage?) {
        image?.image = imagen
       }

    
    
    @IBAction func buttonPresssed(_ sender: UIButton) {
        
        image.image = UIImage(systemName: "jkh")
    }
    
}
