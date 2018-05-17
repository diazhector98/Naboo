//
//  HelpViewController.swift
//  StudyGroup
//
//  Created by Hector Díaz Aceves on 04/02/18.
//  Copyright © 2018 HectorDiaz. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController, UIScrollViewDelegate {
    
    var groupsController: GroupsViewController?
    
    var iPage = 0;
    
    lazy var scrollView: UIScrollView = {
    
        let sv = UIScrollView()
        sv.delegate = self
        sv.alwaysBounceHorizontal = true
        sv.isScrollEnabled = true
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.isPagingEnabled = true
        sv.showsHorizontalScrollIndicator = false
        return sv
    
    }()
    
    var ivPaging: UIImageView = {
    
        let iv = UIImageView()
        iv.image = UIImage(named: "helpPage1")
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    
    }()
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        iPage = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        
        ivPaging.image = UIImage(named: "helpPage\(iPage+1)")
        
        

    }
    
    let lHelp:UILabel = {
    
        let label = UILabel()
        label.text = "Help"
        label.font = UIFont(name: "Helvetica-Bold", size: 36)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    
    }()
    
    lazy var btnBack: UIButton = {
    
        let button = UIButton(type: .system)
        button.tintColor = UIColor.black
        button.setImage(UIImage(named: "backButton"), for: .normal)
        button.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    
    }()
    
    func handleBack(){
    
        self.dismiss(animated: true, completion: nil)
    
    }
    
    var imageArray = [UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(btnBack)
        
        btnBack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        btnBack.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        btnBack.widthAnchor.constraint(equalToConstant: 30).isActive = true
        btnBack.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        view.addSubview(lHelp)
        
        lHelp.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lHelp.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        lHelp.widthAnchor.constraint(equalToConstant: 100).isActive = true
        lHelp.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        
        scrollView.frame = CGRect(x: view.frame.minX, y: view.frame.minY + 100 , width: view.frame.width, height: view.frame.height * 4/5)
        
        imageArray = [#imageLiteral(resourceName: "SS1"),#imageLiteral(resourceName: "SS2"),#imageLiteral(resourceName: "SS3")]
        
        for i in 0...imageArray.count-1 {
        
            let xPosition = CGFloat(i) * self.view.frame.width
            
            let imageView = UIImageView()
            
            imageView.image = imageArray[i]
            
            imageView.contentMode = .scaleAspectFit
            
            imageView.frame = CGRect(x: xPosition, y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
            
            scrollView.contentSize.width = scrollView.frame.width * CGFloat(i+1)
            
            scrollView.addSubview(imageView)
        
        }
        
        view.addSubview(ivPaging)
        
        ivPaging.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        ivPaging.heightAnchor.constraint(equalToConstant: 30).isActive = true
        ivPaging.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        ivPaging.widthAnchor.constraint(equalToConstant: 60).isActive = true

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
