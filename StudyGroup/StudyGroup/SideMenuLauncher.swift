//
//  SideMenuLauncher.swift
//  StudyGroup
//
//  Created by Hector Díaz Aceves on 29/12/17.
//  Copyright © 2017 HectorDiaz. All rights reserved.
//

import UIKit

class SideMenuOption: NSObject {

    let sName: String
    let sImageName: String
    
    init(name: String, imageName: String) {
        
        self.sName = name
        self.sImageName = imageName
    }
    

}

class SideMenuLauncher: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    let vBlackBackground = UIView()
    
    let vProfileContainer: UIView = {
    
        let view = UIView()
        view.backgroundColor = .black
        return view
    
    }()
    
    var lName: UILabel = {
    
        let label = UILabel()
        label.text = "John Smith"
        label.font = UIFont(name: "Helvetica-Bold", size: 36)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    var lProfileInfo: UILabel = {
    
        let label = UILabel()
        label.textColor = .white
        label.text = "3 Groups · 24 Classmates"
        label.font = UIFont(name: "Helvetica-Bold", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        return label
    
    }()
    
    let cvMenu: UICollectionView = {
    
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .black
        return cv
    
    }()
    
    let menuOptions: [SideMenuOption] = {
    
        return [SideMenuOption(name: "Help", imageName: "helpIcon"),SideMenuOption(name: "About", imageName: "helpIcon"),SideMenuOption(name: "Feedback", imageName: "helpIcon"),SideMenuOption(name: "Logout", imageName: "helpIcon")]
    }()
    
    let fCellHeight: CGFloat = 50
    
    func showMenu(name: String, info: String){
    
        if let window = UIApplication.shared.keyWindow {
        
            vBlackBackground.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            vBlackBackground.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            window.addSubview(vBlackBackground)
            window.addSubview(vProfileContainer)
            window.addSubview(cvMenu)
            
            let height : CGFloat = window.frame.height
            
            vProfileContainer.frame = CGRect(x: -(window.frame.width*(3/4)), y: 0, width: window.frame.width * (3/4), height: 200)
            
            vProfileContainer.addSubview(lName)
            vProfileContainer.addSubview(lProfileInfo)
            
            lName.text = name
            lProfileInfo.text = info
            
            lName.leftAnchor.constraint(equalTo: vProfileContainer.leftAnchor, constant: 30).isActive = true
            lName.rightAnchor.constraint(equalTo: vProfileContainer.rightAnchor, constant: -10).isActive = true
            lName.heightAnchor.constraint(equalToConstant: 50).isActive = true
            lName.centerYAnchor.constraint(equalTo: vProfileContainer.centerYAnchor).isActive = true
            
            lProfileInfo.leftAnchor.constraint(equalTo: vProfileContainer.leftAnchor, constant: 30).isActive = true
            lProfileInfo.rightAnchor.constraint(equalTo: vProfileContainer.rightAnchor, constant: -10).isActive = true
            lProfileInfo.heightAnchor.constraint(equalToConstant: 20).isActive = true
            lProfileInfo.topAnchor.constraint(equalTo: lName.bottomAnchor, constant: 10).isActive = true
            
            cvMenu.frame = CGRect(x: -(window.frame.width*(3/4)), y: 200, width: window.frame.width * (3/4), height: height)
            
            vBlackBackground.frame = window.frame
            vBlackBackground.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { 
                
                self.vBlackBackground.alpha = 1
                
                self.cvMenu.frame = CGRect(x: 0, y: 200, width: window.frame.width * (3/4), height: height)
                
                self.vProfileContainer.frame = CGRect(x: 0, y: 0, width: window.frame.width * (3/4), height: 200)
                
            }, completion: nil)
            
        }
    }
    
    var homeController: GroupsViewController?
    
    func handleDismiss(option: SideMenuOption){
    
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { 
            
            self.vBlackBackground.alpha = 0
            
            if let window = UIApplication.shared.keyWindow {
            
                self.cvMenu.frame = CGRect(x: -(window.frame.width*(3/4)), y: 200, width: window.frame.width * (3/4), height: (window.frame.height - 200))
                
                self.vProfileContainer.frame = CGRect(x: -(window.frame.width*(3/4)), y: 0, width: window.frame.width * (3/4), height: 200)
            
            }
            
        }) { (completed) in
            
            if option.sName != ""{
            
                if option.sName == "Logout" {
                
                    self.homeController?.handleLogout()
                    
                } else if option.sName == "About" {
                
                    self.homeController?.handleAbout()
                
                } else if option.sName == "Feedback" {
                
                    self.homeController?.sendEmail()
                
                } else if option.sName == "Help" {
                
                    self.homeController?.handleHelp()
                
                }
            
            
            }
            
        }
        
    
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuOptions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! SideMenuCell
        
        let menuOption = menuOptions[indexPath.row]
        
        cell.menuOption = menuOption
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: cvMenu.frame.width, height: fCellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let option = self.menuOptions[indexPath.row]
        handleDismiss(option: option)
        
    }
    override init() {
        super.init()
        
        cvMenu.delegate = self
        cvMenu.dataSource = self
        cvMenu.register(SideMenuCell.self, forCellWithReuseIdentifier: "cellId")
    }
    
    
}
