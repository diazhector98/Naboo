//
//  ClassmateTableViewCell.swift
//  StudyGroup
//
//  Created by Hector Díaz Aceves on 28/01/18.
//  Copyright © 2018 HectorDiaz. All rights reserved.
//

import UIKit

class ClassmateTableViewCell: UITableViewCell {
    
    
    let lName: UILabel = {
    
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-Bold", size: 24)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    
    }()
    
    
    let lEmail: UILabel = {
        
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 20)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(lName)
        self.addSubview(lEmail)
        
        lName.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        lName.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        lName.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        lName.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        lEmail.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        lEmail.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        lEmail.topAnchor.constraint(equalTo: lName.bottomAnchor).isActive = true
        lEmail.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

        
        
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
