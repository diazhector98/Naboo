//
//  GroupsViewController.swift
//  StudyGroup
//
//  Created by Hector Díaz Aceves on 25/11/17.
//  Copyright © 2017 HectorDiaz. All rights reserved.
//

import UIKit
import Firebase
import MessageUI

class GroupsViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    /*
     MARK: User variables
     
     - Name
     - Email
 */
    
    var sUserName = String()
    var sUserEmail = String()
    
    /*
 
     Mark: Class variables
 */
    
    var arrGroups:[GroupObject] = [GroupObject]()
    var idGroupsNumber = [String: Int]()
    
    var arrQuestionsCount:[Int] = [Int]()
    var arrClassmatesCount:[Int] = [Int]()

    
    var iNumberOfGroups: Int = 0;
    
    /*
 
     MARK: Sidebar
 
 */
    
    
    lazy var menuLauncher: SideMenuLauncher = {
    
        let launcher = SideMenuLauncher()
        launcher.homeController = self
        return launcher
    }()
    
    
    /*
 
     MARK: UI Elements
     - Top Bar
      - Sidebar button
      - Group Label
      - Profile button
      - Underline view
     - Table View
     - Add Group Button
 
 
 */
    
    lazy var btnSideBar: UIButton = {
    
        let button = UIButton(type: .system)
        button.tintColor = .black
        button.setImage(UIImage(named: "SideBarButton"), for: .normal)
        button.addTarget(self, action: #selector(handleSideBar), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    
    }()
    
    let lGroups: UILabel = {
    
        let label = UILabel()
        label.text = "Groups"
        label.font = UIFont(name: "Helvetica-Bold", size: 36)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    
    }()
    
    let btnProfile: UIButton = {
        
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "ProfileButton"), for: .normal)
        button.addTarget(self, action: #selector(handleProfile), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    let vUnderline: UIView = {
    
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    
    }()
    

    
    lazy var tvGroups: UITableView = {
    
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    
    }()
    
    let btnAddGroup: UIButton = {
    
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "AddGroupButton"), for: .normal)
        button.addTarget(self, action: #selector(handleAddGroup), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
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
    
    let vGroupsContainer: UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    let vAddButtonContainer: UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    /*
 
     MARK: Button Functions
 
 
     */
    
    func handleProfile(){
    
    
    
    }
    
    func handleSideBar(){
    
        menuLauncher.showMenu(name: sUserName, info: sUserEmail)
    
    }
    
    func handleAddGroup(){
    
        let controller = NewGroupViewController()
        controller.groupsController = self
        present(controller, animated: true, completion: nil)
    
    }
    
    func handleAbout(){
    
        let controller = AboutViewController()
        controller.groupsController = self
        present(controller, animated: true, completion: nil)
    }
    
    func handleHelp(){
    
        let controller = HelpViewController()
        controller.groupsController = self
        present(controller, animated: true, completion: nil)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let index = self.tvGroups.indexPathForSelectedRow {
        
            self.tvGroups.deselectRow(at: index, animated: true)
        
        }
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkIfUserIsLoggedIn()
        fetchGroups()
        
        view.backgroundColor = .white
        
        //Register cell class to tableview
        
        tvGroups.register(GroupTableViewCell.self, forCellReuseIdentifier: "cellId")
        
        //Add elements to containers
        
        vTopBarContainer.addSubview(btnSideBar)
        vTopBarContainer.addSubview(lGroups)
        vTopBarContainer.addSubview(vUnderline)
        
        vGroupsContainer.addSubview(tvGroups)
        self.tvGroups.tableFooterView = UIView()
        
        vAddButtonContainer.addSubview(btnAddGroup)
        
        //Add containers to view
        
        view.addSubview(vTopBarContainer)
        view.addSubview(vGroupsContainer)
        view.addSubview(vAddButtonContainer)
        
        //Configure sizes and positions
        
        setupComponents()
        // Do any additional setup after loading the view.
    }
    
    func setupComponents(){
    
        //Size and positions of containers
        
        vTopBarContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        vTopBarContainer.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        vTopBarContainer.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        vTopBarContainer.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        vGroupsContainer.topAnchor.constraint(equalTo: vTopBarContainer.bottomAnchor, constant: 20).isActive = true
        vGroupsContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        vGroupsContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        vGroupsContainer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 9/10).isActive = true
        
        vAddButtonContainer.widthAnchor.constraint(equalToConstant: 70).isActive = true
        vAddButtonContainer.heightAnchor.constraint(equalToConstant: 70).isActive = true
        vAddButtonContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        vAddButtonContainer.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        
        //Size and positions of elements
        
        lGroups.centerXAnchor.constraint(equalTo: vTopBarContainer.centerXAnchor).isActive = true
        lGroups.centerYAnchor.constraint(equalTo: vTopBarContainer.centerYAnchor).isActive = true
        lGroups.widthAnchor.constraint(equalTo: vTopBarContainer.widthAnchor, multiplier: 2/5).isActive = true
        lGroups.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        btnSideBar.leftAnchor.constraint(equalTo: vTopBarContainer.leftAnchor, constant: 20).isActive = true
        btnSideBar.centerYAnchor.constraint(equalTo: vTopBarContainer.centerYAnchor).isActive = true
        btnSideBar.widthAnchor.constraint(equalToConstant: 30).isActive = true
        btnSideBar.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        vUnderline.bottomAnchor.constraint(equalTo: vTopBarContainer.bottomAnchor).isActive = true
        vUnderline.rightAnchor.constraint(equalTo: vTopBarContainer.rightAnchor, constant: -35).isActive = true
        vUnderline.leftAnchor.constraint(equalTo: btnSideBar.leftAnchor, constant: 15).isActive = true
        vUnderline.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        tvGroups.widthAnchor.constraint(equalTo: vGroupsContainer.widthAnchor, multiplier: 9/10).isActive = true
        tvGroups.heightAnchor.constraint(equalTo: vGroupsContainer.heightAnchor).isActive = true
        tvGroups.centerYAnchor.constraint(equalTo: vGroupsContainer.centerYAnchor).isActive = true
        tvGroups.centerXAnchor.constraint(equalTo: vGroupsContainer.centerXAnchor).isActive = true
        
        btnAddGroup.centerXAnchor.constraint(equalTo: vAddButtonContainer.centerXAnchor).isActive = true
        btnAddGroup.centerYAnchor.constraint(equalTo: vAddButtonContainer.centerYAnchor).isActive = true
        btnAddGroup.widthAnchor.constraint(equalTo: vAddButtonContainer.widthAnchor).isActive = true
        btnAddGroup.heightAnchor.constraint(equalTo: vAddButtonContainer.heightAnchor).isActive = true
        

    
    }
    
    /*
     MARK: Firebase
 */
    
    func fetchGroups(){
    
        guard let sUserId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let refDatabase = Database.database().reference()
        let refUsers = refDatabase.child("Users")
        let refUser = refUsers.child(sUserId)
        let refUserGroups = refUser.child("groups")
        
        refUserGroups.observe(.childAdded, with: { (snapshot) in
            
            let groupId = snapshot.key
            
            let refGroup = refDatabase.child("Groups").child(groupId)
            
            refGroup.observe(.childChanged, with: { (snapshot) in
                
                if(snapshot.key == "name"){
                
                    let iGroupNumber = self.idGroupsNumber[groupId]!
                    
                    let newGroup = self.arrGroups[iGroupNumber]
                    
                    newGroup.sGroupName = snapshot.value! as! String
                    
                    self.arrGroups[iGroupNumber] = newGroup
                    
                    self.tryRefreshingTable()
                    
                }
                
                
            })
            
            refGroup.observeSingleEvent(of: .value, with: { (snapshot) in
                
                
                if let dictionary = snapshot.value as? [String:AnyObject] {
                    
                    let sGroupId = snapshot.key
                    let sGroupName = dictionary["name"] as! String
                    let iGroupIcon = dictionary["icon"] as! Int
                    
                    if let classmatesDictionary = dictionary["classmates"] as? [String:AnyObject] {
                        print(classmatesDictionary.count)
                        self.arrClassmatesCount.append(classmatesDictionary.count)
                    
                    } else {
                    
                        self.arrClassmatesCount.append(0)

                    }
                    
                    if let questionsDictionary = dictionary["questions"] as? [String:AnyObject] {
                       
                        self.arrQuestionsCount.append(questionsDictionary.count)

                    } else {
                    
                        self.arrQuestionsCount.append(0)

                    
                    }
                    
                    
                    let group = GroupObject(iGroupIcon: iGroupIcon, sGroupId: sGroupId, sGroupName: sGroupName)
                    
                    self.arrGroups.append(group)
                    self.idGroupsNumber[group.sGroupId!] = self.iNumberOfGroups
                    
                    self.iNumberOfGroups += 1
                    
                    self.tryRefreshingTable()
                
                }
                
                
            }, withCancel: nil)
            
            
            
        }, withCancel: nil)
        
        
        tryRefreshingTable()
    
    
    }
    
    /*
 
     MARK: Email
 
 */
    
    
    func configureMailController() -> MFMailComposeViewController {
        
        let mfViewController = MFMailComposeViewController()
        
        mfViewController.mailComposeDelegate = self
        
        mfViewController.setToRecipients(["diazhector98@gmail.com"])
        
        mfViewController.setSubject("Feedback")
        
        mfViewController.setMessageBody("This is a cool app", isHTML: false)
        
        return mfViewController
        
        
    }
    
    func sendEmail(){
    
        let mailController = configureMailController()
        
        if (MFMailComposeViewController.canSendMail()){
        
            self.present(mailController, animated: true, completion: nil)
        
        } else {
        
            handleErrorAlert("It seems your device can't send an email")
        
        }
    
    }
    
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        controller.dismiss(animated: true, completion: nil)
        
        
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
    
    
    var timer: Timer?
    
    fileprivate func tryRefreshingTable(){
        
        self.timer?.invalidate()
        
        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(handleReloadData), userInfo: nil, repeats: false
        )
    }
    
    func handleReloadData(){
        
        DispatchQueue.main.async {
            
            self.menuLauncher.lProfileInfo.text = "\(self.iNumberOfGroups) Groups"
            self.tvGroups.reloadData()
        }
        
        
    }
    

}

/*
 
 MARK: Tableview
 
 */


extension GroupsViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func checkIfUserIsLoggedIn(){
    
        if Auth.auth().currentUser?.uid == nil {
        
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        } else {
        
            print("It is logged in")
            print(Auth.auth().currentUser?.uid)
            setUserData()
        
        }
        
    
    }
    
    func handleLogout(){
    
        do{
        
            try Auth.auth().signOut()
        
        } catch let LogoutError {
        
            handleErrorAlert(LogoutError.localizedDescription)
        
        }
        
        
        arrGroups.removeAll()
        
        let controller = LoginViewController()
        
        controller.groupsController = self
        
        present(controller, animated: true, completion: nil)
        
    }
    
    func handleErrorAlert(_ error: String){
        
        let alert = UIAlertController(title: "Oops", message: error, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }

    
    func setUserData(){
        
        //Fetching current user data from the database
        
        //Getting id of current user
        guard let sId = Auth.auth().currentUser?.uid else {
            return
        }
        
        //Getting user info from the database
        Database.database().reference().child("Users").child(sId).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String:AnyObject] {
            
                //Creating a new User object
                let user = UserObject()
                
                user.name = dictionary["name"] as! String
                user.email = dictionary["email"] as! String
                user.id = snapshot.key
                
                //The name of the values in the child should correspond to the names of the variables in the object(i.e name and email)
//                user.setValuesForKeys(dictionary)
//                
                
                self.setupUserUI(user: user)
            
            }
            
        
        }, withCancel: nil)
        
    
    
    }
 
    
    //Set UI elements from current user
    
    func setupUserUI(user : UserObject){
        
        sUserName = user.name!
        sUserEmail = user.email!
    
    
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrGroups.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! GroupTableViewCell
        
        cell.lGroupName.text = arrGroups[indexPath.row].sGroupName
        cell.lGroupQuestions.text = "\(arrQuestionsCount[indexPath.row]) questions · \(arrClassmatesCount[indexPath.row]) classmates"
        
        let sIconName = "GroupIcon\(arrGroups[indexPath.row].iGroupIcon!+1)"
        cell.ivIcon.image = UIImage(named: sIconName)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let controller = IndividualGroupViewController()
        
        controller.Group = arrGroups[indexPath.row]
        
        present(controller, animated: true, completion: nil)
        
        
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let editGroupAction = UITableViewRowAction(style: .normal, title: "Change Name") { (action, indexPath) in
            
            let group = self.arrGroups[indexPath.row]
            
            let userId = Auth.auth().currentUser?.uid
            
            let changeNameAlert = UIAlertController(title: "Change name of \(group.sGroupName!)", message: "Enter a new name", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            let changeNameAction = UIAlertAction(title: "Change", style: .default, handler: { (action) in
                
                
                let textField = changeNameAlert.textFields![0] as UITextField
                
                let sNewName = textField.text!
                
                self.changeName(group: group, sNewName: sNewName, userId: userId!)
                
                print(sNewName)
                
                
            })
            
            changeNameAlert.addTextField(configurationHandler: { (textField) in
                
                
            })
            
            changeNameAlert.addAction(cancelAction)
            changeNameAlert.addAction(changeNameAction)
            
            self.present(changeNameAlert, animated: true, completion: nil)
            
            print("Yep");
            
        }
        
        let leaveGroupAction = UITableViewRowAction(style: .default, title: "Leave Group") { (action, indexPath) in
            
            let leaveGroupMenu = UIAlertController(title: "Leave group?", message: "You won't be able to access this study group unless a classmate adds you", preferredStyle: .alert)
            
            let leaveAction = UIAlertAction(title: "Yes, leave.", style: .default, handler: { (action) in
                
                let group = self.arrGroups[indexPath.row]
                
                let userId = Auth.auth().currentUser?.uid
                
                self.leaveGroup(group: group, userId: userId!)
                
                self.arrGroups.remove(at: indexPath.row)
                
                self.tvGroups.deleteRows(at: [indexPath], with: .fade)
                
                self.tvGroups.reloadData()
                
            })
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            leaveGroupMenu.addAction(leaveAction)
            leaveGroupMenu.addAction(cancelAction)
            
            self.present(leaveGroupMenu, animated: true, completion: nil)
            
            
        }
        
        editGroupAction.backgroundColor = UIColor.black
        
        return [leaveGroupAction, editGroupAction]
    }
    
    func changeName(group: GroupObject, sNewName: String, userId: String){
    
        
        let refGroups = Database.database().reference().child("Groups")
        
        let refGroup = refGroups.child(group.sGroupId!)
        
        refGroup.updateChildValues(["name":sNewName])
    
    }
    
    func leaveGroup(group: GroupObject, userId: String){
    
        let refGroups = Database.database().reference().child("Groups")
        
        let refGroup = refGroups.child(group.sGroupId!)
        
        let refGroupClassmates = refGroup.child("classmates")
        
        refGroupClassmates.child(userId).observe(.value, with: { (snapshot) in
            
            snapshot.ref.removeValue(completionBlock: { (error, ref) in
                
                if error != nil{
                
                    self.handleErrorAlert("Couldn't leave group.")
                
                }
                
                
            })
            
            
        }) { (error) in
            
            self.handleErrorAlert("Couldn't leave group.")
        }
        
        let refUsers = Database.database().reference().child("Users")
        
        let refUser = refUsers.child(userId)
        
        refUser.child("groups").child(group.sGroupId!).observe(.value, with: { (snapshot) in
            
            snapshot.ref.removeValue(completionBlock: { (error, ref) in
                
                if error != nil {
                
                    self.handleErrorAlert("Error removing you from the group.")

                    self.tryRefreshingTable()
                }
                
            })
            
            
        }) { (error) in
            
            self.handleErrorAlert("Error removing you from the group.")
            
        }
        
        
    
    
    }



}
