//
//  QuestionPreviewView.swift
//  StudyGroup
//
//  Created by Hector Díaz Aceves on 31/01/18.
//  Copyright © 2018 HectorDiaz. All rights reserved.
//

import UIKit

class QuestionPreviewView: UIView {
    
    let lQuestion: UILabel = {
    
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "Helvetica-Bold", size: 50)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    
    }()
    
    
    
    lazy var btnEdit: UIButton = {
        
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 36)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.tintColor = .darkGray
        button.setTitle("Edit", for: .normal)
        button.addTarget(self, action: #selector(handleEdit), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    var editFunction: (() -> (Void))!
    
    func handleEdit(){
    
        editFunction()
    
    }
    
    func setEditFunc(_ function: @escaping() -> Void){
    
        self.editFunction = function
    
    }
    
    lazy var btnDelete: UIButton = {
    
        let button = UIButton(type: .system)
        button.tintColor = UIColor.red
        button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 36)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setTitle("Delete", for: .normal)
        button.addTarget(self, action: #selector(handleDelete), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    
    }()
    
    var deleteFunc: (() -> (Void))!

    func handleDelete(){
    
        deleteFunc()
    
    }
    func setDeleteFunction(_ function: @escaping()->Void){
    
        self.deleteFunc = function
    
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(lQuestion)
        self.addSubview(btnEdit)
        self.addSubview(btnDelete)
        
        self.layer.borderWidth = 10
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = 50
        self.clipsToBounds = true
        
        
        self.backgroundColor = .white
        
        lQuestion.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        lQuestion.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        lQuestion.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 4/5).isActive = true
        lQuestion.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/2).isActive = true
        
        btnEdit.topAnchor.constraint(equalTo: lQuestion.bottomAnchor, constant: 10).isActive = true
        btnEdit.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        btnEdit.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4).isActive = true
        btnEdit.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        btnDelete.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        btnDelete.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        btnDelete.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btnDelete.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4).isActive = true
        
        
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
