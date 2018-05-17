//
//  NewGroupViewController.swift
//  StudyGroup
//
//  Created by Hector Díaz Aceves on 25/11/17.
//  Copyright © 2017 HectorDiaz. All rights reserved.
//

import UIKit
import Firebase

class NewGroupViewController: UIViewController {
    
    /*
 
     MARK: Class variables
 
 
     */
    
    var groupsController: GroupsViewController?
    
    var bChoosingIcon = false
    var bHasSelectedIcon = false
    
    var ipIconSelected:IndexPath = IndexPath()
    
    /*
 
     MARK: UIElements
     
     - Top Bar
      - Back Button
      - New Group Label
     - Name Text Field
     - Name TF Line
     - Next Button
     
     - Choose Icon Label
     - Group Icons Collection View
     - Create button
 
 
 */
    
    
    lazy var btnBack: UIButton = {
    
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "backButton"), for: .normal)
        button.setImage(UIImage(named: "backButtonPushed"), for: UIControlState.highlighted)
        button.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        return button
    
    }()
    
    let lNewGroup: UILabel = {
    
        let label = UILabel()
        label.text = "New Group"
        label.font = UIFont(name: "Helvetica-Bold", size: 36)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    
    }()
    
    let tfName: UITextField = {
    
        let tf = UITextField()
        tf.placeholder = "Enter name"
        tf.font = UIFont(name: "Helvetica-Bold", size: 24)
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    
    }()
    
    let vNameLine: UIView = {
    
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    
    }()
    
    lazy var btnNext: UIButton = {
    
        let button = UIButton(type: .system)
        button.tintColor = .black
        button.setTitle("Next", for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 24)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return button
    
    }()
    
    let lChooseIcon: UILabel = {
        
        let label = UILabel()
        label.text = "Choose Icon"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    var cvIcons: UICollectionView!
    
    lazy var btnCreate: UIButton = {
    
        let button = UIButton(type: .system)
        button.setTitle("Create", for: .normal)
        button.tintColor = .black
        button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 24)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleCreate), for: .touchUpInside)
        return button
    
    }()
    
    
    /*
 
     MARK: Containers
 
 
 */
    
    let vTopBarContainer: UIView = {

        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    
    }()
    
    let vTextFieldAndButtonContainer: UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    let vIconsContainer: UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()

    
    /*
     MARK: Button Functions
 */
    
    func handleBack(){
    
        if(bChoosingIcon){
        
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.3, options: .curveEaseIn, animations: {
                
                self.vTextFieldAndButtonContainer.frame.origin.x += self.view.frame.width
                self.cvIcons.frame.origin.x += self.view.frame.width
                self.btnCreate.frame.origin.x += self.view.frame.width

                
            }, completion: nil)
            
            bChoosingIcon = false

        
        } else {
        
            //groupsController?.fetchGroups()
            
            self.dismiss(animated: true, completion: nil)
        
        }
        
    }
    
    func handleNext(){
    
        view.endEditing(true)
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.3, options: .curveEaseIn, animations: { 
            
            self.vTextFieldAndButtonContainer.frame.origin.x -= self.view.frame.width
            self.cvIcons.frame.origin.x -= self.view.frame.width
            self.btnCreate.frame.origin.x -= self.view.frame.width

            
            
        }, completion: nil)
        
        bChoosingIcon = true
    
    }
    
    func handleCreate(){
    
        
        let sGroupName = tfName.text
        
        if(!bHasSelectedIcon){
        
            handleErrorAlert("Please select an icon")
        
        } else {
        
            if(sGroupName == ""){
                handleErrorAlert("Group name can't be empty")
                return
            }
            
            handleAddGroupToDatabase(groupName: sGroupName!, icon: ipIconSelected.row)
            
            self.dismiss(animated: true, completion: nil)
            
            
        }
        
        
        
    
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        //Add elements to containers
        
        vTopBarContainer.addSubview(btnBack)
        vTopBarContainer.addSubview(lNewGroup)
        //vTopBarContainer.addSubview(lChooseIcon)
        
        vTextFieldAndButtonContainer.addSubview(tfName)
        vTextFieldAndButtonContainer.addSubview(vNameLine)
        vTextFieldAndButtonContainer.addSubview(btnNext)
        
        //Add containers to view
        
        view.addSubview(vTopBarContainer)
        view.addSubview(vTextFieldAndButtonContainer)
        
        //Setup colection view of icons
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
        let iconWidth = view.frame.width / 4
        let iconHeight = view.frame.height / 8
        
        layout.itemSize = CGSize(width: iconWidth, height: iconHeight)
        
        cvIcons = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        cvIcons.backgroundColor = .white
        cvIcons.register(GroupIconCollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
        cvIcons.translatesAutoresizingMaskIntoConstraints = false
        cvIcons.allowsSelection = true
        cvIcons.delegate = self
        cvIcons.dataSource = self
        
        view.addSubview(cvIcons)
        view.addSubview(btnCreate)
        
        //Setup positions and sizes
        
        setupComponents()
        
        
        

        // Do any additional setup after loading the view.
    }
    
    func setupComponents(){
    
        //Containers
        
        vTopBarContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        vTopBarContainer.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        vTopBarContainer.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        vTopBarContainer.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        vTextFieldAndButtonContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        vTextFieldAndButtonContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        vTextFieldAndButtonContainer.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/5).isActive = true
        vTextFieldAndButtonContainer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 9/10).isActive = true
        
        //Elements in containers
        
        lNewGroup.centerXAnchor.constraint(equalTo: vTopBarContainer.centerXAnchor).isActive = true
        lNewGroup.centerYAnchor.constraint(equalTo: vTopBarContainer.centerYAnchor).isActive = true
        lNewGroup.widthAnchor.constraint(equalTo: vTopBarContainer.widthAnchor, multiplier: 2/5).isActive = true
        lNewGroup.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        btnBack.leftAnchor.constraint(equalTo: vTopBarContainer.leftAnchor, constant: 20).isActive = true
        btnBack.centerYAnchor.constraint(equalTo: vTopBarContainer.centerYAnchor).isActive = true
        btnBack.widthAnchor.constraint(equalToConstant: 30).isActive = true
        btnBack.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        tfName.topAnchor.constraint(equalTo: vTextFieldAndButtonContainer.topAnchor).isActive = true
        tfName.widthAnchor.constraint(equalTo: vTextFieldAndButtonContainer.widthAnchor, multiplier: 9/10).isActive = true
        tfName.heightAnchor.constraint(equalToConstant: 30).isActive = true
        tfName.centerXAnchor.constraint(equalTo: vTextFieldAndButtonContainer.centerXAnchor).isActive = true
        
        vNameLine.topAnchor.constraint(equalTo: tfName.bottomAnchor, constant: 5).isActive = true
        vNameLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        vNameLine.widthAnchor.constraint(equalTo: tfName.widthAnchor).isActive = true
        vNameLine.centerXAnchor.constraint(equalTo: tfName.centerXAnchor).isActive = true
        
        btnNext.bottomAnchor.constraint(equalTo: vTextFieldAndButtonContainer.bottomAnchor).isActive = true
        btnNext.centerXAnchor.constraint(equalTo: vTextFieldAndButtonContainer.centerXAnchor).isActive = true
        btnNext.widthAnchor.constraint(equalTo: vTextFieldAndButtonContainer.widthAnchor, multiplier: 1/4).isActive = true
        btnNext.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        btnCreate.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        btnCreate.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 5/10).isActive = true
        btnCreate.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btnCreate.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: view.frame.width).isActive = true
        
        cvIcons.topAnchor.constraint(equalTo: vTopBarContainer.bottomAnchor, constant: 10).isActive = true
        cvIcons.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 9/10).isActive = true
        cvIcons.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: view.frame.width).isActive = true
        cvIcons.bottomAnchor.constraint(equalTo: btnCreate.topAnchor, constant: -20).isActive = true
        
        
        
    }
    
    /*
 
     MARK: Firebase
 */
    
    func handleAddGroupToDatabase(groupName : String, icon : Int){
    
        let refDatabase = Database.database().reference()
        let refGroups = refDatabase.child("Groups")
        let refGroup = refGroups.childByAutoId()
        
        let refUsers = refDatabase.child("Users")
        let sCurrentUserId = Auth.auth().currentUser?.uid
        let refCurrentUser = refUsers.child(sCurrentUserId!)
        let refUser_Groups = refCurrentUser.child("groups")
        
        var values: [String:AnyObject] = ["name" : groupName as AnyObject, "icon" : icon as NSNumber, "owner" : sCurrentUserId! as AnyObject]
        
        
        let refGroup_Users = refGroup.child("classmates")
        
        
        refGroup.updateChildValues(values) { (error, ref) in
            
            if error != nil {
            
                self.handleErrorAlert("Error in connection");
                
                return
            }
            
        }
        
        refUser_Groups.updateChildValues([refGroup.key : 1])
        refGroup_Users.updateChildValues([sCurrentUserId!: 1])
        
    
    }
    
    /*
 
 
     Error functions
 
 */
    
    func handleErrorAlert(_ error: String){
        
        
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            
            alert.dismiss(animated: true, completion: nil)
            
        }))
        
        present(alert, animated: true, completion: nil)
        
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     
     MARK: Keyboard
     */
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        
        textField.resignFirstResponder()
        return true
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
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



extension NewGroupViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as? GroupIconCollectionViewCell
        
        cell?.ivIcon.image = UIImage(named: "GroupIcon\(indexPath.row+1)")
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        bHasSelectedIcon = true
        
        let previousCell = collectionView.cellForItem(at: ipIconSelected) as? GroupIconCollectionViewCell
        
        previousCell?.ivIcon.alpha = 0.4
        
        let cell = collectionView.cellForItem(at: indexPath) as? GroupIconCollectionViewCell
        
        cell?.ivIcon.alpha = 1
        
        ipIconSelected = indexPath
        
    }
    




}
