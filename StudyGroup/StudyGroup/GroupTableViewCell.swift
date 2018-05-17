//
//  GroupTableViewCell.swift
//  StudyGroup
//
//  Created by Hector Díaz Aceves on 06/12/17.
//  Copyright © 2017 HectorDiaz. All rights reserved.
//

import UIKit

class GroupTableViewCell: UITableViewCell {
    
    var ivIcon: UIImageView = {
    
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv;
    
    }()
    
    var lGroupName: UILabel = {
    
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-Bold", size: 24)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    
    }()
    
    var lGroupQuestions: UILabel = {

        let label = UILabel()
        label.font = UIFont(name: "Helvetica-Light", size: 18)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    
    }()
    
    let vLine: UIView = {
    
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    
    }()
    

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(ivIcon)
        self.addSubview(lGroupName)
        self.addSubview(lGroupQuestions)
        self.addSubview(vLine)
        
        ivIcon.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        ivIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        ivIcon.widthAnchor.constraint(equalToConstant: 70).isActive = true
        ivIcon.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        lGroupName.leftAnchor.constraint(equalTo: ivIcon.rightAnchor, constant: 15).isActive = true
        lGroupName.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        lGroupName.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 3/10).isActive = true
        lGroupName.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
        
        lGroupQuestions.topAnchor.constraint(equalTo: lGroupName.bottomAnchor, constant: 20).isActive = true
        lGroupQuestions.leftAnchor.constraint(equalTo: lGroupName.leftAnchor).isActive = true
        lGroupQuestions.rightAnchor.constraint(equalTo: lGroupName.rightAnchor).isActive = true
        lGroupQuestions.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/5).isActive = true
        
        vLine.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        vLine.leftAnchor.constraint(equalTo: lGroupName.leftAnchor).isActive = true
        vLine.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        vLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        

        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
