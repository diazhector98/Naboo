//
//  ClassmatesView.swift
//  StudyGroup
//
//  Created by Hector Díaz Aceves on 22/01/18.
//  Copyright © 2018 HectorDiaz. All rights reserved.
//

import UIKit

class ClassmatesView: UIView {
    
    let lClassmates: UILabel = {
    
        let label = UILabel()
        label.text = "Classmates"
        label.font = UIFont(name: "Helvetica-Bold", size: 40)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let tvClassmates: UITableView = {
    
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    
    }()
    
    let btnAdd: UIButton = {
    
        let btn = UIButton(type: .system)
        btn.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 24)
        btn.tintColor = .black
        btn.titleLabel?.textAlignment = .center
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Add", for: .normal)
        return btn
    }()
    
    let btnOk: UIButton = {
    
        
        let btn = UIButton(type: .system)
        btn.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 24)
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        btn.tintColor = .darkGray
        btn.titleLabel?.textAlignment = .center
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Ok", for: .normal)
        return btn
    
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        self.layer.cornerRadius = 50
        self.clipsToBounds = true
        self.layer.borderWidth = 10
        self.layer.borderColor = UIColor.black.cgColor
        
        self.addSubview(lClassmates)
        self.addSubview(tvClassmates)
        self.addSubview(btnAdd)
        self.addSubview(btnOk)
        
        lClassmates.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        lClassmates.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        lClassmates.heightAnchor.constraint(equalToConstant: 60).isActive = true
        lClassmates.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 4/5).isActive = true
        
        btnOk.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        btnOk.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        btnOk.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btnOk.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        btnAdd.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        btnAdd.bottomAnchor.constraint(equalTo: btnOk.topAnchor, constant: -10).isActive = true
        btnAdd.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/3).isActive = true
        btnAdd.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        tvClassmates.topAnchor.constraint(equalTo: lClassmates.bottomAnchor, constant: 10).isActive = true
        tvClassmates.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        tvClassmates.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        tvClassmates.bottomAnchor.constraint(equalTo: btnAdd.topAnchor, constant: -10).isActive = true
        
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
