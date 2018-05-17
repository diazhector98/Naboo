//
//  SideMenuCell.swift
//  StudyGroup
//
//  Created by Hector Díaz Aceves on 29/12/17.
//  Copyright © 2017 HectorDiaz. All rights reserved.
//

import UIKit

class SideMenuCell: Base {
    
    override var isHighlighted: Bool {
    
        didSet {
        
            backgroundColor = isHighlighted ? UIColor.white : UIColor.black
            
            lName.textColor = isHighlighted ? UIColor.black : UIColor.white
            
            ivIcon.tintColor = isHighlighted ? UIColor.black : UIColor.white

        }
    
    }
    
    var menuOption: SideMenuOption? {
        
        didSet {
        
            lName.text = menuOption?.sName
            
            if let sImageName = menuOption?.sImageName {
            
                ivIcon.image = UIImage(named: sImageName)?.withRenderingMode(.alwaysTemplate)
                
                ivIcon.tintColor = .black
            
            }
        }
    
    }
    
    let lName: UILabel = {
    
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Helvetica-Bold", size: 24)
        label.text = "Option"
        return label
    
    }()
    
    let ivIcon: UIImageView = {
    
        let iv = UIImageView()
        iv.image = UIImage(named: "backButton")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(lName)
        addSubview(ivIcon)
        
        addConstraintWithFormat(format: "H:|-8-[v0(30)]-8-[v1]|", views: ivIcon, lName)
        
        addConstraintWithFormat(format: "V:|[v0]|", views: lName)
        addConstraintWithFormat(format: "V:[v0(30)]", views: ivIcon)
        
        addConstraint(NSLayoutConstraint(item: ivIcon, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
    
    func addConstraintWithFormat(format: String, views: UIView...){
    
        var dViews = [String: UIView]()
        
        for(index, view) in views.enumerated() {
        
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            dViews[key] = view
        
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: dViews))
    
    }

}

class Base: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
    
    
    }

}
