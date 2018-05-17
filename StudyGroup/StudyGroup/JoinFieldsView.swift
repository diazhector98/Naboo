//
//  JoinFieldsView.swift
//  StudyGroup
//
//  Created by Hector Díaz Aceves on 28/01/18.
//  Copyright © 2018 HectorDiaz. All rights reserved.
//

import UIKit

class JoinFieldsView: UIView {

    let lQuoteJoin: UILabel = {
        
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "Helvetica-Bold", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Unleash the true power of\nyour study group."
        label.numberOfLines = 0;
        return label
        
    }()
    
    
    let tfUsername: UITextField = {
        
        let tf = UITextField()
        tf.placeholder = "Name"
        tf.font = UIFont(name: "Helvetica-Bold", size: 20)
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
        
    }()
    
    let vUsernameLine: UIView = {
        
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    let tfEmailJoin: UITextField = {
        
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.font = UIFont(name: "Helvetica-Bold", size: 20)
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
        
    }()
    
    let vEmailJoinLine: UIView = {
        
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    let tfJoinPassword: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.isSecureTextEntry = true
        tf.font = UIFont(name: "Helvetica-Bold", size: 20)
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let vJoinPasswordLine: UIView = {
        
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(lQuoteJoin)
        self.addSubview(tfUsername)
        self.addSubview(vUsernameLine)
        self.addSubview(tfEmailJoin)
        self.addSubview(vEmailJoinLine)
        self.addSubview(tfJoinPassword)
        self.addSubview(vJoinPasswordLine)
        
        
        lQuoteJoin.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        lQuoteJoin.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 9/10).isActive = true
        lQuoteJoin.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/5).isActive = true
        lQuoteJoin.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        tfUsername.topAnchor.constraint(equalTo: lQuoteJoin.bottomAnchor, constant: 10).isActive = true
        tfUsername.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        tfUsername.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 9/10).isActive = true
        tfUsername.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/6).isActive = true
        
        vUsernameLine.topAnchor.constraint(equalTo: tfUsername.bottomAnchor, constant: 1).isActive = true
        vUsernameLine.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 9/10).isActive = true
        vUsernameLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        vUsernameLine.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        tfEmailJoin.topAnchor.constraint(equalTo: vUsernameLine.bottomAnchor, constant: 10).isActive = true
        tfEmailJoin.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        tfEmailJoin.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 9/10).isActive = true
        tfEmailJoin.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/6).isActive = true
        
        vEmailJoinLine.topAnchor.constraint(equalTo: tfEmailJoin.bottomAnchor, constant: 1).isActive = true
        vEmailJoinLine.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 9/10).isActive = true
        vEmailJoinLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        vEmailJoinLine.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        tfJoinPassword.topAnchor.constraint(equalTo: vEmailJoinLine.bottomAnchor, constant: 10).isActive = true
        tfJoinPassword.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        tfJoinPassword.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 9/10).isActive = true
        tfJoinPassword.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/6).isActive = true
        
        vJoinPasswordLine.topAnchor.constraint(equalTo: tfJoinPassword.bottomAnchor, constant: 1).isActive = true
        vJoinPasswordLine.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 9/10).isActive = true
        vJoinPasswordLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        vJoinPasswordLine.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        
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
