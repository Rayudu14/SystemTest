//
//  RowDataCell.swift
//  WiproTest
//
//  Created by Raidu on 7/2/20.
//  Copyright © 2020 Raidu. All rights reserved.
//

import UIKit
import SDWebImage

class RowDataCell: UITableViewCell {
    
    var descriptionlblBottomConstraint : NSLayoutConstraint!
    private let rowTitleLbl : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
    //    lbl.backgroundColor = .red
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        return lbl
    }()
    private let rowDescriptionLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        lbl.sizeToFit()
 //       lbl.backgroundColor = .green
        return lbl
    }()
    let rowImage : UIImageView = {
        let imgView = UIImageView()
     //   imgView.backgroundColor = .orange
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    
    var row : Rows? {
        didSet {
            rowImage.image = UIImage(named: "placeholder")
            if let imgUrl = row?.imageHref {
                rowImage.sd_setImage(with: URL(string: imgUrl), placeholderImage: UIImage(named: "placeholder"))
            }
            rowTitleLbl.text = row?.title
            rowDescriptionLabel.text = row?.description
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(rowTitleLbl)
        self.contentView.addSubview(rowImage)
        self.contentView.addSubview(rowDescriptionLabel)
        
        rowImage.translatesAutoresizingMaskIntoConstraints = false
        rowTitleLbl.translatesAutoresizingMaskIntoConstraints = false
        rowDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        rowTitleLbl.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5).isActive = true
        rowTitleLbl.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5).isActive = true
        rowTitleLbl.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5).isActive = true
        
        rowImage.topAnchor.constraint(equalTo: rowTitleLbl.bottomAnchor, constant: 5).isActive = true
        rowImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5).isActive = true
        rowImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        rowImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        rowDescriptionLabel.topAnchor.constraint(equalTo: rowImage.bottomAnchor, constant: 5).isActive = true
        rowDescriptionLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5).isActive = true
        rowDescriptionLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5).isActive = true
        rowDescriptionLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
