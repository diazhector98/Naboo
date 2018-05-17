//
//  AddPeopleView.swift
//  StudyGroup
//
//  Created by Hector Díaz Aceves on 08/01/18.
//  Copyright © 2018 HectorDiaz. All rights reserved.
//

import UIKit

class AddPeopleView: UIView {
    
    
    let lAddClassmate: UILabel = {
    
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-Bold", size: 36)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Add Classmate"
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    
    
    }()
    
    let tfEmail: UITextField = {
    
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Enter email"
        return tf
    }()
    
    let btnAdd: UIButton = {
    
        let button = UIButton(type: .system)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 24)
        button.setTitle("Add", for: .normal)
        button.tintColor = UIColor.black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    
    }()
    
    let btnCancel: UIButton = {
    
        let button = UIButton(type: .system)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 20)
        button.tintColor = UIColor.lightGray
        button.setTitle("Cancel", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(lAddClassmate)
        self.addSubview(tfEmail)
        self.addSubview(btnAdd)
        self.addSubview(btnCancel)
        
        
        tfEmail.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        tfEmail.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        tfEmail.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 4/5).isActive = true
        tfEmail.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        lAddClassmate.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        lAddClassmate.bottomAnchor.constraint(equalTo: tfEmail.topAnchor).isActive = true
        lAddClassmate.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        lAddClassmate.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 4/5).isActive = true
        
        btnCancel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        btnCancel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        btnCancel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        btnCancel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        btnAdd.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        btnAdd.topAnchor.constraint(equalTo: tfEmail.bottomAnchor).isActive = true
        btnAdd.bottomAnchor.constraint(equalTo: btnCancel.topAnchor).isActive = true
        btnAdd.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/2).isActive = true
        
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
