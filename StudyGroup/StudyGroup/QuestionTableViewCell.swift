//
//  QuestionTableViewCell.swift
//  StudyGroup
//
//  Created by Hector Díaz Aceves on 12/12/17.
//  Copyright © 2017 HectorDiaz. All rights reserved.
//

import UIKit

class QuestionTableViewCell: UITableViewCell {
    
    let lQuestion: UILabel = {
    
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont(name: "Helvetica", size: 24)
        label.adjustsFontSizeToFitWidth = true
        return label
    
    
    }()
    
    let ivQuestion: UIImageView = {
    
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(lQuestion)
        self.addSubview(ivQuestion)
        
        lQuestion.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        lQuestion.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        lQuestion.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        lQuestion.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 3/4).isActive = true
        
        ivQuestion.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        ivQuestion.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        ivQuestion.leftAnchor.constraint(equalTo: lQuestion.rightAnchor, constant: 5).isActive = true
        ivQuestion.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 9/10).isActive = true
        
        
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
