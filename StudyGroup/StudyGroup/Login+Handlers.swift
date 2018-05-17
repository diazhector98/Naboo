//
//  Login+Handlers.swift
//  StudyGroup
//
//  Created by Hector Díaz Aceves on 30/12/17.
//  Copyright © 2017 HectorDiaz. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn

extension LoginViewController : GIDSignInDelegate {
    
    /*
     
     MARK: Join
 
     Function that handles the register of a new user with its name, email and password
 
 */
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
        
        refUser.updateChildValues(values) { (error, ref) in
            
            if error != nil {
            
                self.handleErrorAlert(error.debugDescription)
                
                return
            
            }
            
            let user = UserObject()
            
            user.setValuesForKeys(values)
            
            self.groupsController?.fetchGroups()
            
            self.groupsController?.setupUserUI(user: user)

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
    

    
    
    /*
 
     MARK: Login
 
 */
    
    func handleLogin(){
        
        guard let sEmail = tfEmail.text, let sPassword = tfPassword.text else{
        
            handleErrorAlert("Check your email and password")
            
            return
        }
        
        
        Auth.auth().signIn(withEmail: sEmail, password: sPassword) { (user, error) in
            
            if error != nil {
            
                self.handleErrorAlert("Email or Password is Incorrect")
                return
            }
            
            self.groupsController?.fetchGroups()
            self.dismiss(animated: true, completion: nil)
            
        }
        
    }
    
    func handleForgotPassword(){
    
        let alertController = UIAlertController(title: "Forgot password?", message: "Enter your account email.", preferredStyle: .alert)
        
        let actionSend = UIAlertAction(title: "Send email", style: .default) { (alert) in
            
            let tfEmail = alertController.textFields![0] as UITextField
            
            if(self.isValidEmailAddress(email: tfEmail.text!)){
            
                Auth.auth().sendPasswordReset(withEmail: tfEmail.text!, completion: { (error) in
                    
                    if(error != nil){
                    
                        self.handleErrorAlert("Check your email address.")
                    
                        
                    } else {
                    
                        self.handleAlert(title: "Reset password.", subtitle: "An email has been send to your account.")
                    
                    }
                    
                })
            
            } else {
            
                self.handleErrorAlert("Invalid email address.")
            
            
            }
            
            print(tfEmail.text)
            
            
        }
        
        let actionCancel = UIAlertAction(title: "Cancel", style: .default) { (alert) in
            
        }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "whatismypassword@gmail.com"
        }
        
        alertController.addAction(actionSend)
        alertController.addAction(actionCancel)
        
        self.present(alertController, animated: true, completion: nil)
        
        
    
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
    
}
