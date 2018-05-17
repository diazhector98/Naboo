//
//  GroupIconCollectionViewCell.swift
//  StudyGroup
//
//  Created by Hector Díaz Aceves on 08/12/17.
//  Copyright © 2017 HectorDiaz. All rights reserved.
//

import UIKit

class GroupIconCollectionViewCell: UICollectionViewCell {
    
    let ivIcon: UIImageView = {
    
        let iv = UIImageView()
        iv.alpha = 0.4
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    
    }()
    
    let vGlow: UIView = {
    
        let view = UIView()
        view.backgroundColor = .yellow
        view.alpha = 0.5
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(ivIcon)
        
        ivIcon.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        ivIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        ivIcon.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 9/10).isActive = true
        ivIcon.heightAnchor.constraint(equalTo: ivIcon.widthAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
