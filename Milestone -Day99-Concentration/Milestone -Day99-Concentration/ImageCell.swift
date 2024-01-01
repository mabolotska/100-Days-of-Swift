//
//  ImageCell.swift
//  Milestone -Day99-Concentration
//
//  Created by Maryna Bolotska on 25/12/23.
//

import UIKit
import SnapKit

class ImageCell: UICollectionViewCell {
    var isFlipped = false
    var imageName: String? {
            didSet {
                // Update the button image when the imageName is set
                if let imageName = imageName {
                    button.setImage(UIImage(named: imageName), for: .normal)
                }
            }
        }
    
    // MARK: - Init
    
    let button: UIButton = {
        let button = UIButton()
    //    button.setTitle("Show Text", for: .normal)
       
        return button
    }()
    
    var isTextVisible: Bool = false {
        didSet {
            let buttonText = isTextVisible ? "Your Text" : "Show Text"
            button.setTitle(buttonText, for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(button)
        
        if isFlipped == true {
            button.backgroundColor = .blue
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        } else {
            button.backgroundColor = .red
            button.addTarget(self, action: #selector(buttonTappedTwo), for: .touchUpInside)
        }
        
        button.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.width.equalTo(100)
        }
        
        // Add action to button
     //   button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc private func buttonTapped() {
        isTextVisible.toggle()
    }
    
    @objc private func buttonTappedTwo() {
      
    }
}
