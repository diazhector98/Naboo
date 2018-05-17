//
//  StatusView.swift
//  StudyGroup
//
//  Created by Hector Díaz Aceves on 18/01/18.
//  Copyright © 2018 HectorDiaz. All rights reserved.
//

import UIKit

class StatusView: UIView {
    
    var iTotalQuestions: Int?
    
    var iCorrectAnswers: Int? {
        
        didSet {
        
            lRatio.text = "\(iCorrectAnswers!) / \(iTotalQuestions!)";
            
        }
    
    }
    
    var bChoseCorrectAnswer: Bool? {
    
        didSet {
        
            if(bChoseCorrectAnswer!){
            
                lRightWrong.text = "Right!"
                
                lRatio.textColor = UIColor(red:0.30, green:0.85, blue:0.39, alpha:1.0)
            
            } else {
                
                lRightWrong.text = "Wrong!"
                
                lRatio.textColor = UIColor(red:1.00, green:0.23, blue:0.19, alpha:1.0)
            }
            
        
        }
    
    
    }
    
    
    let lRightWrong: UILabel = {
    
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Right!"
        label.font = UIFont(name: "Helvetica-Bold", size: 36)
        label.textAlignment = .center
        return label
    
    
    }()
    
    let lRatio: UILabel = {
    
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.text = "1/2"
        label.font = UIFont(name: "Helvetica-Bold", size: 64)
        //Change colors
        label.textColor = UIColor(red:0.30, green:0.85, blue:0.39, alpha:1.0)
        label.textAlignment = .center
        return label
    }()
    
    let btnKeepGoing: UIButton = {
    
        let btn = UIButton(type: .system)
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        btn.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 36)
        btn.tintColor = UIColor.black
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Keep Going", for: .normal)
        return btn
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        self.layer.borderWidth = 10
        self.layer.cornerRadius = 50
        self.layer.borderColor = UIColor.black.cgColor
        self.clipsToBounds = true
        
        self.addSubview(lRightWrong)
        self.addSubview(lRatio)
        self.addSubview(btnKeepGoing)
        
        lRatio.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        lRatio.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        lRatio.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 4/7).isActive = true
        lRatio.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        lRightWrong.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        lRightWrong.heightAnchor.constraint(equalToConstant: 50).isActive = true
        lRightWrong.bottomAnchor.constraint(equalTo: lRatio.topAnchor, constant: 0).isActive = true
        lRightWrong.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/2).isActive = true
        
        btnKeepGoing.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        btnKeepGoing.topAnchor.constraint(equalTo: lRatio.bottomAnchor, constant: 0).isActive = true
        btnKeepGoing.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btnKeepGoing.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/2).isActive = true
        
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
