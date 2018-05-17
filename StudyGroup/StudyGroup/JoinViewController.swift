//
//  JoinViewController.swift
//  StudyGroup
//
//  Created by Hector Díaz Aceves on 07/02/18.
//  Copyright © 2018 HectorDiaz. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn

class JoinViewController: UIViewController, GIDSignInDelegate {

    var groupsController: GroupsViewController?
    
    var loginController: LoginViewController?
    
    let ivBackKids: UIImageView = {
        
        let iv = UIImageView()
        iv.image = UIImage(named: "backKids")
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
        
    }()
    
    let ivMiddleKids: UIImageView = {
        
        let iv = UIImageView()
        iv.image = UIImage(named: "middleKids")
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
        
    }()
    
    let ivFrontKid: UIImageView = {
        
        let iv = UIImageView()
        iv.image = UIImage(named: "frontKid")
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
        
    }()
    
    
    lazy var btnJoin: UIButton = {
        
        let button = UIButton(type: .system)
        button.setTitle("Join.", for: .normal)
        button.tintColor = .black
        button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 20)
        button.addTarget(self, action: #selector(handleJoin), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
        
    }()
    
    lazy var btnGoogleJoin: GIDSignInButton = {
        
        let button = GIDSignInButton()
        //button.setTitle("Google Join.", for: .normal)
        //button.setImage(UIImage(named: "signInWithGoogle"), for: .normal)
        //button.addTarget(self, action: #selector(handleGoogle), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
        
    }()
    
    
    lazy var btnLoginToggle: UIButton = {
        
        let button = UIButton(type: .system)
        button.setTitle("Already have an account? Login.", for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 20)
        button.tintColor = .black
        button.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
        
    }()
    
    func handleBack(){
    
        self.dismiss(animated: true, completion: nil)
    
    }
    
    
    let vQuoteAndJoinFieldsContainer: JoinFieldsView = {
        
        let view = JoinFieldsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    let vJoinButtonsContainer: UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        vJoinButtonsContainer.addSubview(btnJoin)
        vJoinButtonsContainer.addSubview(btnGoogleJoin)
        vJoinButtonsContainer.addSubview(btnLoginToggle)

        view.addSubview(ivBackKids)
        view.addSubview(ivMiddleKids)
        view.addSubview(ivFrontKid)
        view.addSubview(vQuoteAndJoinFieldsContainer)
        view.addSubview(vJoinButtonsContainer)

        setupComponents()
        // Do any additional setup after loading the view.
    }
    
    func setupComponents(){
    
        ivBackKids.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        ivBackKids.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: view.frame.width).isActive = true
        ivBackKids.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/7).isActive = true
        ivBackKids.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 3/4).isActive = true
        
        ivMiddleKids.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        ivMiddleKids.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: view.frame.width).isActive = true
        ivMiddleKids.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/6).isActive = true
        ivMiddleKids.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2).isActive = true
        
        ivFrontKid.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        ivFrontKid.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: view.frame.width).isActive = true
        ivFrontKid.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/5).isActive = true
        ivFrontKid.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/4).isActive = true
        
        
        
        vQuoteAndJoinFieldsContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        vQuoteAndJoinFieldsContainer.topAnchor.constraint(equalTo: ivFrontKid.bottomAnchor, constant: 10).isActive = true
        vQuoteAndJoinFieldsContainer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 9/10).isActive = true
        vQuoteAndJoinFieldsContainer.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 3/7).isActive = true
        
        
        vJoinButtonsContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        vJoinButtonsContainer.topAnchor.constraint(equalTo: vQuoteAndJoinFieldsContainer.bottomAnchor, constant: 10).isActive = true
        vJoinButtonsContainer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 9/10).isActive = true
        vJoinButtonsContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    
        
        btnGoogleJoin.centerXAnchor.constraint(equalTo: vJoinButtonsContainer.centerXAnchor).isActive = true
        btnGoogleJoin.heightAnchor.constraint(equalTo: vJoinButtonsContainer.heightAnchor, multiplier: 1/4).isActive = true
        btnGoogleJoin.centerYAnchor.constraint(equalTo: vJoinButtonsContainer.centerYAnchor).isActive = true
        btnGoogleJoin.widthAnchor.constraint(equalTo: vJoinButtonsContainer.widthAnchor, multiplier: 9/10).isActive = true
        
        btnJoin.bottomAnchor.constraint(equalTo: btnGoogleJoin.topAnchor, constant: -10).isActive = true
        btnJoin.centerXAnchor.constraint(equalTo: vJoinButtonsContainer.centerXAnchor).isActive = true
        btnJoin.heightAnchor.constraint(equalTo: vJoinButtonsContainer.heightAnchor, multiplier: 1/4).isActive = true
        btnJoin.widthAnchor.constraint(equalTo: vJoinButtonsContainer.widthAnchor, multiplier: 9/10).isActive = true
        
        btnLoginToggle.centerXAnchor.constraint(equalTo: vJoinButtonsContainer.centerXAnchor).isActive = true
        btnLoginToggle.topAnchor.constraint(equalTo: btnGoogleJoin.bottomAnchor, constant: 10).isActive = true
        btnLoginToggle.widthAnchor.constraint(equalTo: vJoinButtonsContainer.widthAnchor, constant: 9/10).isActive = true
        btnLoginToggle.heightAnchor.constraint(equalTo: vJoinButtonsContainer.heightAnchor, multiplier: 1/4).isActive = true

    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func handleJoin(){
        
        //Create variables for name, email and password
        
        guard let sEmail = vQuoteAndJoinFieldsContainer.tfEmailJoin.text, let sName = vQuoteAndJoinFieldsContainer.tfUsername.text, let sPassword = vQuoteAndJoinFieldsContainer.tfJoinPassword.text else {
            
            handleErrorAlert("Error in variable declaration")
            
            return
            
            
        }
        
        Auth.auth().createUser(withEmail: sEmail, password: sPassword) { (user, error) in
            
            if error != nil {
                
                self.handleErrorAlert(error.debugDescription)
                
                return
                
            }
            
            guard let sUserId = user?.uid else {
                
                self.handleErrorAlert("Id error")
                return
                
            }
            
            let values = ["name": sName, "email": sEmail]
            
            self.registerUserIntoDatabase(id: sUserId, values: values as [String:AnyObject])
            
        }
        
        
    }
    
    /*
     
     Function that adds the user to the Firebase database and
     
     */
    
    fileprivate func registerUserIntoDatabase(id : String, values : [String:AnyObject]){
        
        let refDatabase = Database.database().reference()
        
        let refUsers = refDatabase.child("Users")
        
        let refUser = refUsers.child(id)
        
        //self.loginController?.handleDismiss()
        
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        
        refUser.updateChildValues(values) { (error, ref) in
            
            if error != nil {
                
                self.handleErrorAlert(error.debugDescription)
                
                return
                
            }
            
            let user = UserObject()
            
            user.setValuesForKeys(values)
            
            self.groupsController?.fetchGroups()
            
            self.groupsController?.setupUserUI(user: user)
            
            //self.loginController?.handleDismiss()
            
            self.dismiss(animated: true, completion: nil)
            
        }
        
        //        let refEmailId = refDatabase.child("EmailId")
        //
        //        refEmailId.updateChildValues([values["email"] as! String:id])
        
    }
    
    /*
     
     MARK: Google
     
     
     */
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if let error = error {
            // ...
            return
        }
        
        print(user.profile.email)
        print(user.profile.name)
        
        let values = ["name" : user.profile.name, "email" : user.profile.email]
        
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        
        Auth.auth().signIn(with: credential) { (user, error) in
            
            if let error = error {
                
                return
                
            }
            
            guard let sUserId = user?.uid else {return}
            
            
            self.registerUserIntoDatabase(id: sUserId, values: values as [String:AnyObject])
            
            //self.groupsController?.setUserData()
            
            print("Sign In of Google from login handlers")
            
            //self.dismiss(animated: true, completion: nil)
            
            
        }
        
        
    }
    
    func isValidEmailAddress(email: String) -> Bool{
        
        var isValid = true
        
        let emailRegex = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        
        do {
            
            let regex = try NSRegularExpression(pattern: emailRegex)
            
            let nsString = email as NSString
            
            let results = regex.matches(in: email, range: NSRange(location: 0, length: nsString.length))
            
            if(results.count == 0){
                
                isValid = false
                
            }
            
        } catch let error as NSError {
            
            isValid = false
            
        }
        
        
        return isValid
        
    }
    
    func handleAlert(title: String, subtitle: String ){
        
        
        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            
            alert.dismiss(animated: true, completion: nil)
            
        }))
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
    func handleErrorAlert(_ error: String){
        
        
        let alert = UIAlertController(title: "Oops", message: error, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            
            alert.dismiss(animated: true, completion: nil)
            
        }))
        
        present(alert, animated: true, completion: nil)
        
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
