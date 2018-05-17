//
//  IndividualGroup+Handlers.swift
//  StudyGroup
//
//  Created by Hector Díaz Aceves on 23/01/18.
//  Copyright © 2018 HectorDiaz. All rights reserved.
//

import Foundation
import Firebase

extension IndividualGroupViewController {

    
    func fetchGroupQuestions(){
        
        
        questions.removeAll()
        
        
        guard let groupId = Group?.sGroupId else {
            return
        }
        
        let refDatabase = Database.database().reference()
        let refGroups = refDatabase.child("Groups")
        let refGroup = refGroups.child(groupId)
        
        //Observe questions in the group
        refGroup.child("questions").observe(.childAdded, with: { (snapshot) in
            
            let questionId = snapshot.key
            
            let refQuestion = refDatabase.child("Questions").child(questionId)
            
            refQuestion.observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String:AnyObject]{
                    
                    print(dictionary)
                    
                    let question = QuestionObject()
                    
                    question.sQuestionId = snapshot.key
                    question.sQuestionText = dictionary["question"] as! String
                    question.sAnswer = dictionary["answer"] as! String

                    
                    if(dictionary["option1"] != nil){
                        
                        self.trueFalseQuestions.append(false)
                    
                        question.sOption1 = dictionary["option1"] as! String
                        question.sOption2 = dictionary["option2"] as! String
                        question.sOption3 = dictionary["option3"] as! String
                    
                        
                    } else {
                    
                        self.trueFalseQuestions.append(true)

                    
                    }
                    if(dictionary["imageUrl"] != nil){
                        
                        question.sImageId = dictionary["imageUrl"] as! String
                        
                    }
                    
                    self.questions.append(question)
                    
                    self.numberOfQuestions += 1;
                    
                    self.tryRefreshingTable()
                    
                }
                
            }, withCancel: { (error) in
                
                self.handleErrorAlert(error: error.localizedDescription)
                
            })
            
            
        }) { (error) in
            
            self.handleErrorAlert(error: error.localizedDescription)
        }
        
        
    }
    
    func fetchClassmates(){
        
        let groupId = Group?.sGroupId
        let refGroupClassmates = Database.database().reference().child("Groups").child(groupId!).child("classmates")
        
        refGroupClassmates.observe(.childAdded, with: { (snapshot) in
            
            let classmateId = snapshot.key
            
            let refClassmate = Database.database().reference().child("Users").child(classmateId)
            
            refClassmate.observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    
                    let user = UserObject()
                    
                    user.name = dictionary["name"] as! String
                    user.email = dictionary["email"] as! String
                    user.id = snapshot.key
                    
                    self.classmates.append(user)
                    
                    self.tryRefreshingTable()

                    
                }
                
                
            }, withCancel: { (error) in
                
                self.handleErrorAlert(error: error.localizedDescription)
            })
            
            
        }) { (error) in
            
            
        }
        
    }
    
    func addClassmateInGroup(email: String, groupId: String){
    
        if(!isValidEmailAddress(email: email)){
            
            handleErrorAlert(error: "Invalid email address")
            
            btnAddPerson.isEnabled = true
            
        }
        
        let refGroups = Database.database().reference().child("Groups")
        let refGroup = refGroups.child(groupId)
        
        let refUsers = Database.database().reference().child("Users")
        
        firebaseTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(hasFoundUser), userInfo: nil, repeats: true)
        
        refUsers.observe(.childAdded, with: { (snapshot) in
            
            self.iDataFlowCount += 1;
            
            if let dictionary = snapshot.value as? [String:AnyObject]{
                
                if (email == dictionary["email"] as! String){
                    
                    let refClassmatesGroups = Database.database().reference().child("Users").child(snapshot.key).child("groups")
                    
                    refClassmatesGroups.updateChildValues([(self.Group?.sGroupId)! : 1])
                    
                    let refGroup_Users = refGroup.child("classmates")
                    
                    let classmateId = snapshot.key
                    
                    refGroup_Users.updateChildValues([classmateId: 1])
                    
                    let refClassmate = Database.database().reference().child("Users").child(classmateId)
                    
                    refClassmate.observeSingleEvent(of: .value, with: { (snapshot) in
                        
                        if let dictionary = snapshot.value as? [String: AnyObject] {
                            
                            let user = UserObject()
                            
                            user.name = dictionary["name"] as! String
                            user.email = dictionary["email"] as! String
                            user.id = snapshot.key
                                                        
                        }
                        
                        
                        
                    }, withCancel: { (error) in
                        
                        self.handleErrorAlert(error: error.localizedDescription)
                        
                    })
                    
                    
                    self.timer?.invalidate()
                    
                    self.handleDismissAddClassmate()
                    
                    return
                    
                }
                
                
            }
            
        }) { (error) in
            
            self.handleErrorAlert(error: "Unable to fetch users from the database")
        }
        

    
    }
    
    func handleAddClassmate(){
        
        let sClassmateEmail = vAddClassmate.tfEmail.text
        
        if(!isValidEmailAddress(email: sClassmateEmail!)){
            
            handleErrorAlert(error: "Invalid email address")
            
            btnAddPerson.isEnabled = true
            
        }
        
        addClassmateInGroup(email: sClassmateEmail!, groupId: (self.Group?.sGroupId)!)
        
    }
    
    fileprivate func tryRefreshingTable(){
        
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(handleReloadData), userInfo: nil, repeats: false)
        
    }
    
    
    func deleteQuestionFromFirebase(questionId: String, index: Int){
        
        let action = UIAlertAction(title: "Yes", style: .default) { (action) in
            
            print(questionId)
            
            let ref = Database.database().reference().child("Groups").child((self.Group?.sGroupId)!)
            
            let refGroupQuestions = ref.child("questions")
            
            let refGroupQuestion = refGroupQuestions.child(questionId)
            
            refGroupQuestion.observe(.value, with: { (snapshot) in
                
                snapshot.ref.removeValue(completionBlock: { (error, ref) in
                    
                    if error != nil {
                        
                        self.handleErrorAlert(error: "There's been an error")
                        
                    }
                    
                    self.handleAlert(title: "Question deleted", message: "The question has been deleted")
                    
                })
                
                
            }) { (error) in
                
                self.handleErrorAlert(error: "Error")
                
            }
            
            print(self.questions.count)
            self.questions.remove(at: index)
            self.tryRefreshingTable()
            self.handleDismissQuestionPreview()
            
        }
        
        let alertController = UIAlertController(title: "Delete question?", message: "This question will no longer be available.", preferredStyle: .alert)
        
        alertController.addAction(action)
        alertController.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
        
        
    }

    
}
