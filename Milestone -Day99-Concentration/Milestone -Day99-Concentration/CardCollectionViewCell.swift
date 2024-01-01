//
//  CardCollectionViewCell.swift
//  Milestone -Day99-Concentration
//
//  Created by Maryna Bolotska on 31/12/23.
//

import Foundation
import UIKit


class CardCollectionViewCell: UICollectionViewCell {
    let button: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .blue
        button.setTitleColor(.black, for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 2
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(button)
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview()

        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
