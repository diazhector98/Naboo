//
//  QuestionView.swift
//  StudyGroup
//
//  Created by Hector Díaz Aceves on 20/12/17.
//  Copyright © 2017 HectorDiaz. All rights reserved.
//

import UIKit

class QuestionView: UIView {
    /*
 
     MARK: Option Functions
     
     */
    
    var optionAFunc: (() -> (Void))!
    
    var optionBFunc: (() -> (Void))!
    
    var optionCFunc: (() -> (Void))!
    
    var optionDFunc: (() -> (Void))!
    
    func handleOptionA(){
        optionAFunc()
    }
    func handleOptionB(){
        optionBFunc()
    }
    func handleOptionC(){
        optionCFunc()
    }
    func handleOptionD(){
        optionDFunc()
    }
    
    func setFunctionA(_ function: @escaping()-> Void){
        self.optionAFunc = function
    }
    func setFunctionB(_ function: @escaping() -> Void){
        self.optionBFunc = function
    }
    func setFunctionC(_ function: @escaping() -> Void){
        self.optionCFunc = function
    }
    func setFunctionD(_ function: @escaping() -> Void){
        self.optionDFunc = function
    }
    
    /*
 
     MARK: UI Elements
 
     */

    //Question
    
    let lSingleQuestion: UILabel = {
    
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-Bold", size: 70)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    
    
    }()
    
    let ivQuestion: UIImageView = {
    
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    
    }()
    
    let lSubQuestion: UILabel = {
    
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-Bold", size: 18)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    
    }()
    
    //Options
    //A
    lazy var vOptionAContainer: UIView = {
    
        let view = UIView()
        let gr = UIGestureRecognizer(target: self, action: #selector(handleOptionA))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(gr)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.layer.borderWidth = 4
        view.layer.borderColor = UIColor.black.cgColor
        return view
    
    }()
    
    let ivIconA: UIImageView = {
    
        let iv = UIImageView()
        let gr = UIGestureRecognizer(target: self, action: #selector(handleOptionA))
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(gr)
        iv.image = UIImage(named: "optionAIcon")
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    
    }()
    
    let lOptionA: UILabel = {
    
        let label = UILabel()
        label.text = "34.8"
        let gr = UIGestureRecognizer(target: self, action: #selector(handleOptionA))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(gr)
        label.numberOfLines = 0
        label.font = UIFont(name: "Helvetica", size: 18)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label

    
    }()
    
    //B
    lazy var vOptionBContainer: UIView = {
        
        let view = UIView()
        let gr = UIGestureRecognizer(target: self, action: #selector(handleOptionB))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(gr)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.layer.borderWidth = 4
        view.layer.borderColor = UIColor.black.cgColor
        return view
        
    }()
    
    let ivIconB: UIImageView = {
        
        let iv = UIImageView()
        iv.image = UIImage(named: "optionBIcon")
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
        
    }()
    
    let lOptionB: UILabel = {
        
        let label = UILabel()
        label.text = "34.8"
        label.numberOfLines = 0
        label.font = UIFont(name: "Helvetica", size: 18)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
        
    }()
    
    //C
    
    lazy var vOptionCContainer: UIView = {
        
        let view = UIView()
        let gr = UIGestureRecognizer(target: self, action: #selector(handleOptionC))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(gr)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.layer.borderWidth = 4
        view.layer.borderColor = UIColor.black.cgColor
        return view
        
    }()
    
    let ivIconC: UIImageView = {
        
        let iv = UIImageView()
        iv.image = UIImage(named: "optionCIcon")
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
        
    }()
    
    let lOptionC: UILabel = {
        
        let label = UILabel()
        label.text = "34.8"
        label.numberOfLines = 0
        label.font = UIFont(name: "Helvetica", size: 18)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
        
    }()
    
    //D
    
    lazy var vOptionDContainer: UIView = {
        
        let view = UIView()
        let gr = UIGestureRecognizer(target: self, action: #selector(handleOptionD))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(gr)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.layer.borderWidth = 4
        view.layer.borderColor = UIColor.black.cgColor
        return view
        
    }()
    
    let ivIconD: UIImageView = {
        
        let iv = UIImageView()
        iv.image = UIImage(named: "optionDIcon")
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
        
    }()
    
    let lOptionD: UILabel = {
        
        let label = UILabel()
        label.text = "34.8"
        label.numberOfLines = 0
        label.font = UIFont(name: "Helvetica", size: 18)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //Add icons and labels to options containers
        
        vOptionAContainer.addSubview(ivIconA)
        vOptionAContainer.addSubview(lOptionA)
        
        vOptionAContainer.addSubview(ivIconB)
        vOptionAContainer.addSubview(lOptionB)
        
        vOptionAContainer.addSubview(ivIconC)
        vOptionAContainer.addSubview(lOptionC)
        
        vOptionAContainer.addSubview(ivIconD)
        vOptionAContainer.addSubview(lOptionD)
        
        //Add image or question
        
        if(ivQuestion.image != nil){
        
            self.addSubview(ivQuestion)
            self.addSubview(lSubQuestion)
            
            //Add constraints

            ivQuestion.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
            ivQuestion.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            ivQuestion.widthAnchor.constraint(equalTo: self.widthAnchor, constant: 9/10).isActive = true
            ivQuestion.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 3/7).isActive = true
            
            lSubQuestion.topAnchor.constraint(equalTo: ivQuestion.bottomAnchor, constant: 10).isActive = true
            lSubQuestion.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            lSubQuestion.heightAnchor.constraint(equalToConstant: 50).isActive = true
            lSubQuestion.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/2).isActive = true
            
            
        } else {
            self.addSubview(lSingleQuestion)
            
            //Add constraints

            lSingleQuestion.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
            lSingleQuestion.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            lSingleQuestion.widthAnchor.constraint(equalToConstant: 300).isActive = true
            lSingleQuestion.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/3).isActive = true
        
        }
        
        //Add options
        
        self.addSubview(vOptionAContainer)
        self.addSubview(vOptionBContainer)
        self.addSubview(vOptionCContainer)
        self.addSubview(vOptionDContainer)
        
        //Add constraints
        
        //Option Containers
        vOptionCContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        vOptionCContainer.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        vOptionCContainer.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 2/5).isActive = true
        vOptionCContainer.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        vOptionDContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        vOptionDContainer.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        vOptionDContainer.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 2/5).isActive = true
        vOptionDContainer.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        vOptionAContainer.bottomAnchor.constraint(equalTo: vOptionCContainer.topAnchor, constant: -30).isActive = true
        vOptionAContainer.widthAnchor.constraint(equalTo: vOptionCContainer.widthAnchor).isActive = true
        vOptionAContainer.heightAnchor.constraint(equalTo: vOptionCContainer.heightAnchor).isActive = true
        vOptionAContainer.leftAnchor.constraint(equalTo: vOptionCContainer.leftAnchor).isActive = true
        
        vOptionBContainer.bottomAnchor.constraint(equalTo: vOptionDContainer.topAnchor, constant: -30).isActive = true
        vOptionBContainer.widthAnchor.constraint(equalTo: vOptionDContainer.widthAnchor).isActive = true
        vOptionBContainer.heightAnchor.constraint(equalTo: vOptionDContainer.heightAnchor).isActive = true
        vOptionBContainer.rightAnchor.constraint(equalTo: vOptionDContainer.rightAnchor).isActive = true
        
        //Option icons and labels
        
        //a
        ivIconA.centerYAnchor.constraint(equalTo: vOptionAContainer.centerYAnchor).isActive = true
        ivIconA.leftAnchor.constraint(equalTo: vOptionAContainer.leftAnchor, constant: 10).isActive = true
        ivIconA.heightAnchor.constraint(equalToConstant: 45).isActive = true
        ivIconA.widthAnchor.constraint(equalToConstant: 45).isActive = true
        
        lOptionA.leftAnchor.constraint(equalTo: ivIconA.rightAnchor, constant: 10).isActive = true
        lOptionA.rightAnchor.constraint(equalTo: vOptionAContainer.rightAnchor, constant: -10).isActive = true
        lOptionA.centerYAnchor.constraint(equalTo: vOptionAContainer.centerYAnchor).isActive = true
        lOptionA.heightAnchor.constraint(equalTo: vOptionAContainer.heightAnchor, multiplier: 9/10).isActive = true
        //b
        ivIconB.centerYAnchor.constraint(equalTo: vOptionBContainer.centerYAnchor).isActive = true
        ivIconB.leftAnchor.constraint(equalTo: vOptionBContainer.leftAnchor, constant: 10).isActive = true
        ivIconB.heightAnchor.constraint(equalToConstant: 45).isActive = true
        ivIconB.widthAnchor.constraint(equalToConstant: 45).isActive = true
        
        lOptionB.leftAnchor.constraint(equalTo: ivIconB.rightAnchor, constant: 10).isActive = true
        lOptionB.rightAnchor.constraint(equalTo: vOptionBContainer.rightAnchor, constant: -10).isActive = true
        lOptionB.centerYAnchor.constraint(equalTo: vOptionBContainer.centerYAnchor).isActive = true
        lOptionB.heightAnchor.constraint(equalTo: vOptionBContainer.heightAnchor, multiplier: 9/10).isActive = true
        //c
        ivIconC.centerYAnchor.constraint(equalTo: vOptionCContainer.centerYAnchor).isActive = true
        ivIconC.leftAnchor.constraint(equalTo: vOptionCContainer.leftAnchor, constant: 10).isActive = true
        ivIconC.heightAnchor.constraint(equalToConstant: 45).isActive = true
        ivIconC.widthAnchor.constraint(equalToConstant: 45).isActive = true
        
        lOptionC.leftAnchor.constraint(equalTo: ivIconC.rightAnchor, constant: 10).isActive = true
        lOptionC.rightAnchor.constraint(equalTo: vOptionCContainer.rightAnchor, constant: -10).isActive = true
        lOptionC.centerYAnchor.constraint(equalTo: vOptionCContainer.centerYAnchor).isActive = true
        lOptionC.heightAnchor.constraint(equalTo: vOptionCContainer.heightAnchor, multiplier: 9/10).isActive = true
        //d
        ivIconD.centerYAnchor.constraint(equalTo: vOptionDContainer.centerYAnchor).isActive = true
        ivIconD.leftAnchor.constraint(equalTo: vOptionDContainer.leftAnchor, constant: 10).isActive = true
        ivIconD.heightAnchor.constraint(equalToConstant: 45).isActive = true
        ivIconD.widthAnchor.constraint(equalToConstant: 45).isActive = true
        
        lOptionD.leftAnchor.constraint(equalTo: ivIconD.rightAnchor, constant: 10).isActive = true
        lOptionD.rightAnchor.constraint(equalTo: vOptionDContainer.rightAnchor, constant: -10).isActive = true
        lOptionD.centerYAnchor.constraint(equalTo: vOptionDContainer.centerYAnchor).isActive = true
        lOptionD.heightAnchor.constraint(equalTo: vOptionDContainer.heightAnchor, multiplier: 9/10).isActive = true
        
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
