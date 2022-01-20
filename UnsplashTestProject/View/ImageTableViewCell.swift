//
//  TableViewCell.swift
//  UnsplashTestProject
//
//  Created by NODIR KARIMOV on 19/01/22.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    
    static let identifier = "identifier"
    
    var cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    var userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(cellImageView)
        contentView.addSubview(userNameLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        NSLayoutConstraint.activate([

            cellImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 3),
            cellImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            cellImageView.widthAnchor.constraint(equalToConstant: 80),
            cellImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 3),
            
            userNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            userNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

}
