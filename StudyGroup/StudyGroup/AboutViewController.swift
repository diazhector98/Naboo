//
//  AboutViewController.swift
//  StudyGroup
//
//  Created by Hector Díaz Aceves on 29/01/18.
//  Copyright © 2018 HectorDiaz. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    var groupsController: GroupsViewController?
    
    
    /*

     MARK: UIElements
 
 */
    lazy var btnBack : UIButton = {
    
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "backButton"), for: .normal)
        button.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        button.setImage(UIImage(named: "backButtonPushed"), for: UIControlState.highlighted)
        return button
    
    }()
    
    let ivAppIcon: UIImageView = {
    
        let iv = UIImageView()
        iv.image = UIImage(named: "NabooNameLogo")
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let lDescription: UILabel = {
    
        let label = UILabel()
        label.numberOfLines = 0;
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: "Helvetica-Light", size: 24)
        label.text = "Naboo is an app that every study group needs. A simple plataform to connect your classmates by sharing questions in order to study together anytime, anywhere. "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    let lVersionCredits: UILabel = {
    
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "Helvetica-Light", size: 18)
        label.text = "Version 1.0.30"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    
    
    }()
    
    /*

     MARK: UI Containers
 
 */
    
    let vLogoAndDescription: UIView = {
    
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view;
    }()
    
    let vVersionAndCredits: UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view;
    }()
    
    /*
 
     MARK: Button functions
 
 */
    
    func handleBack(){
    
        self.dismiss(animated: true, completion: nil)
    
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(btnBack)
        
        vLogoAndDescription.addSubview(ivAppIcon)
        vLogoAndDescription.addSubview(lDescription)
        vVersionAndCredits.addSubview(lVersionCredits)
        
        view.addSubview(vLogoAndDescription)
        view.addSubview(vVersionAndCredits)
        
        
        btnBack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        btnBack.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        btnBack.widthAnchor.constraint(equalToConstant: 30).isActive = true
        btnBack.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        vLogoAndDescription.topAnchor.constraint(equalTo: btnBack.bottomAnchor, constant: 10).isActive = true
        vLogoAndDescription.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        vLogoAndDescription.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        vLogoAndDescription.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/2).isActive = true
        
        vVersionAndCredits.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        vVersionAndCredits.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        vVersionAndCredits.heightAnchor.constraint(equalToConstant: 80).isActive = true
        vVersionAndCredits.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        
        ivAppIcon.centerXAnchor.constraint(equalTo: vLogoAndDescription.centerXAnchor).isActive = true
        ivAppIcon.topAnchor.constraint(equalTo: vLogoAndDescription.topAnchor, constant: 10).isActive = true
        ivAppIcon.widthAnchor.constraint(equalTo: vLogoAndDescription.widthAnchor, multiplier: 1/2).isActive = true
        ivAppIcon.heightAnchor.constraint(equalTo: ivAppIcon.widthAnchor).isActive = true
        
        lDescription.topAnchor.constraint(equalTo: ivAppIcon.bottomAnchor, constant: 10).isActive = true
        lDescription.centerXAnchor.constraint(equalTo: vLogoAndDescription.centerXAnchor).isActive = true
        lDescription.bottomAnchor.constraint(equalTo: vLogoAndDescription.bottomAnchor, constant: -10).isActive = true
        lDescription.widthAnchor.constraint(equalTo: vLogoAndDescription.widthAnchor, multiplier: 4/5).isActive = true
        
        lVersionCredits.bottomAnchor.constraint(equalTo: vVersionAndCredits.bottomAnchor, constant: -20).isActive = true
        lVersionCredits.leftAnchor.constraint(equalTo: vVersionAndCredits.leftAnchor, constant: 20).isActive = true
        lVersionCredits.heightAnchor.constraint(equalToConstant: 60).isActive = true
        lVersionCredits.rightAnchor.constraint(equalTo: vVersionAndCredits.rightAnchor, constant: -20).isActive = true
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
