//
//  IndividualGroupViewController.swift
//  StudyGroup
//
//  Created by Hector Díaz Aceves on 25/11/17.
//  Copyright © 2017 HectorDiaz. All rights reserved.
//

import UIKit
import Firebase
import AlgoliaSearch

class IndividualGroupViewController: UIViewController {
    
    
    /*
 
     MARK: Algolia Search

 
 */

    
    
    /*
 
 
     MARK: View variables
 
 */
    
    var Group: GroupObject? {
    
        didSet {
        
            lGroupName.text = Group?.sGroupName
            ivGroupIcon.image = UIImage(named: "GroupIconLarge\((Group?.iGroupIcon)!+1)")
        }
    
    }
    var blackView: UIView?

    var numberOfQuestions: Int = Int()
    
    var questions:[QuestionObject] = [QuestionObject]()
    
    var classmates:[UserObject] = [UserObject]()
    
    var bHasBlackView: Bool = false
    
    var bHasAddedQuestion: Bool = false
    
    var trueFalseQuestions: [Bool] = [Bool]()
    
    /*
 
     MARK: UI elements
 
 */
    
    lazy var btnBack : UIButton = {
    
        let button = UIButton(type: .system)
        button.tintColor = .black
        button.setImage(UIImage(named: "backButton"), for: .normal)
        button.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    
    }()
    
    lazy var btnAddPerson : UIButton = {
        
        let button = UIButton(type: .system)
        button.tintColor = .black
        button.setImage(UIImage(named: "classmatesIcon"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(handleDisplayClassmates), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    let ivGroupIcon : UIImageView = {
    
        let iv = UIImageView()
        iv.image = UIImage(named: "GroupIcon1Shadow")
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    
    }()
    
    let lGroupName: UILabel = {
    
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Mathematics II"
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: "Helvetica-Bold", size: 36)
        return label
    
    }()
    
    let vFirstLine: UIView = {
    
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    
    }()
    
    lazy var btnStudy : UIButton = {
        
        let button = UIButton(type: .system)
        button.tintColor = .black
        button.setImage(UIImage(named: "StudyButton"), for: .normal)
        button.addTarget(self, action: #selector(handleStudy), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    lazy var btnFlash : UIButton = {
    
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "FlashButton"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(handleFlash), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    
    
    }()
    
    let lMyQuestions: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "My Questions"
        label.font = UIFont(name: "Helvetica-Bold", size: 24)
        return label
        
    }()
    
    let vQuestionsLine: UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
        
    }()
    
    lazy var tvQuestions: UITableView = {
    
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.prefetchDataSource = self
        tv.separatorStyle = .none
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    
    }()
    
    lazy var btnAddQuestion : UIButton = {
        
        let button = UIButton(type: .custom)
        button.tintColor = .clear
        button.addTarget(self, action: #selector(handleAddQuestion), for: .touchUpInside)
        button.setImage(UIImage(named: "AddGroupButton"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    //MARK: Classmates View UI Elements
    
    
    //View
    let vClassmates: UIView = {
    
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 50
        view.clipsToBounds = true
        view.layer.borderWidth = 10
        view.layer.borderColor = UIColor.black.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    
    }()
    
    //Label classmates
    let lClassmates: UILabel = {
        
        let label = UILabel()
        label.text = "Classmates"
        label.font = UIFont(name: "Helvetica-Bold", size: 40)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //Tableview
    lazy var tvClassmates: UITableView = {
        
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
        
    }()
    
    //Add Button
    lazy var btnAdd: UIButton = {
        
        let btn = UIButton(type: .system)
        btn.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 24)
        btn.tintColor = .black
        btn.titleLabel?.textAlignment = .center
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(handleDisplayAddClassmate), for: .touchUpInside)
        btn.setTitle("Add", for: .normal)
        return btn
    }()
    
    //Ok Button
    lazy var btnOk: UIButton = {
        
        let btn = UIButton(type: .system)
        btn.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 24)
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        btn.tintColor = .darkGray
        btn.titleLabel?.textAlignment = .center
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(handleHideClassmatesView), for: .touchUpInside)
        btn.setTitle("Ok", for: .normal)
        return btn
        
    }()
    
    
    
    //MARK: Add Classmate View UI Elements
    
    lazy var vAddClassmate: AddPeopleView = {
    
        let view = AddPeopleView()
        view.layer.borderWidth = 10
        view.layer.cornerRadius = 30;
        view.clipsToBounds = true
        view.layer.borderColor = UIColor.black.cgColor
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.btnAdd.addTarget(self, action: #selector(handleAddClassmate), for: .touchUpInside)
        view.btnCancel.addTarget(self, action: #selector(handleDismissAddClassmate), for: .touchUpInside)
        return view
        
    }()
    
    
    
    /*
 
     MARK: Containers
 
 */
    
    let vTopButtons: UIView = {
    
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    
    }()
    
    let vIconAndName: UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    let vButton: UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    let vQuestions: UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    let vAddQuestionButton: UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    /*
 
     MARK: Button Functions
 
     */
    
    func handleChangeNewQuestionStatus(){
    
        self.bHasAddedQuestion = true
    
    }
    
    func handleBack(){
        
        if(bHasAddedQuestion){
        
            print("Added question");
        
        } else {
        
            print("Did not add question");
        
        }
    
        self.dismiss(animated: true, completion: nil)
    
    }
    
    var classmatesView: ClassmatesView?
    
    func handleDisplayClassmates(){
        
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            
            self.blackView?.alpha = 0.5
            self.vClassmates.frame.origin.x += self.view.frame.width
            
        }, completion: { (completed) in
            
        })

        
    }
    
    func handleHideClassmatesView(){
    
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { 
            
            self.blackView?.alpha = 0

            self.vClassmates.frame.origin.x -= self.view.frame.width
            
            
        }) { (completed) in
            
        }
        
    
    }
    
    func handleDisplayAddClassmate(){
        
        let alertController = UIAlertController(title: "Add Classmate", message: "Enter email.", preferredStyle: .alert)
        
        let addAction = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let emailTextField = alertController.textFields![0] as UITextField
            
            let email = emailTextField.text
            
            self.addClassmateInGroup(email: email!, groupId: (self.Group?.sGroupId!)!)
            
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "name@mail.com"
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(addAction)
        
        self.present(alertController, animated: true, completion: nil)
        
        
        
//        handleHideClassmatesView()
//        
//        //btnAddPerson.isEnabled = false
//        
//        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 8, initialSpringVelocity: 8, options: .curveEaseIn, animations: { 
//            
//            self.blackView?.alpha = 0.5
//
//            self.vAddClassmate.frame.origin.x -= self.view.frame.width
//            
//        }, completion: nil)
    
    
    }
    
    func handleDismissAddClassmate(){
    
        btnAddPerson.isEnabled = true
        
        vAddClassmate.tfEmail.text = ""

        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 8, initialSpringVelocity: 8, options: .curveEaseIn, animations: {
            
            self.blackView?.alpha = 0
            self.vAddClassmate.frame.origin.x += self.view.frame.width
            
        }, completion: nil)

    }
    
    var firebaseTimer: Timer?
    
    var iDataCount: Int = 0;
    var iDataFlowCount: Int = 0;
        
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
    
    func hasFoundUser(){
    
        if(iDataFlowCount != iDataCount){
        
            iDataCount = iDataFlowCount
        
            return
        }
    }
    
    func handleStudy(){
        
        if(questions.count == 0){
        
            handleErrorAlert(error: "There are no questions! Add one by pressing the icon on the bottom.")
            
            return
        
        
        }
    
        let controller = StudyViewController()
        
        
        //Gets order of the questions. So if there are 3 questions, the order might be 0,2,1 or 
        //2,1,0 etc.
        let questionOrder = getRandomArray(numberOfElements: questions.count, maxValue: questions.count)
        
        print(questionOrder)
        
        //Gets the answer's index for every question. So question 0 might have its answer index at three. If the question is true or false it simply adds 1 if its true or 0 if its false.
        let answersOrder = getRandomAnswersArray(numberOfElements: questions.count)
        
        print(answersOrder)
        
        controller.trueFalseQuestion = trueFalseQuestions
        controller.answerOrder = answersOrder
        controller.questionOrder = questionOrder
        controller.Group = Group
        controller.qArrQuestions = questions
        present(controller, animated: true, completion: nil)
    
    }
    
    func getRandomAnswersArray(numberOfElements: Int) -> [Int]{
    
        var intArray: [Int] = [Int]()
        
        for i in 1...numberOfElements {
            
            if(!trueFalseQuestions[i-1]){
        
            var value: Int = Int(arc4random_uniform(4))
            
            intArray.append(value)
                
            } else {
                
                print(questions[i-1].sQuestionText)
                print(questions[i-1].sAnswer)
            
                if(questions[i-1].sAnswer! == "true"){
                
                    intArray.append(1)

                } else {
                
                    print("Answer is not true")
                    intArray.append(0)
                
                }
                
            }
            
        }
                
        return intArray
        
    }
    
    func getRandomArray(numberOfElements: Int, maxValue: Int) -> [Int]{
    
        var intArray: [Int] = [Int]()
        
        for i in 1...numberOfElements{

            var value: Int = Int(arc4random_uniform(UInt32(maxValue)))
            
            while(intArray.contains(value)){
            
                value = Int(arc4random_uniform(UInt32(maxValue)))
                
            }
            
            
            intArray.append(value)
        }
        
        return intArray;
    
    }
    
    func handleFlash(){
    
        let controller = FlashViewController()
        controller.group = Group
        controller.questions = questions
        
        self.present(controller, animated: true, completion: nil)
    
    }
    
    func handleAddQuestion(){
    
        let controller = NewQuestionViewController()
        
        controller.Group = Group
        
        present(controller, animated: true, completion: nil)
    
    }
    
    
    //MARK: View
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("Group has appeared")
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        blackView = UIView(frame: self.view.frame)
        
        blackView?.backgroundColor = UIColor.black
        
        blackView?.alpha = 0
        
        view.backgroundColor = .white
        
        fetchGroupQuestions()
        fetchClassmates()
        
        //Add elements to containers
        
        vTopButtons.addSubview(btnBack)
        vTopButtons.addSubview(btnAddPerson)
        
        vIconAndName.addSubview(ivGroupIcon)
        vIconAndName.addSubview(lGroupName)
        vIconAndName.addSubview(vFirstLine)
        
        vButton.addSubview(btnFlash)
        vButton.addSubview(btnStudy)
        
        vQuestions.addSubview(lMyQuestions)
        vQuestions.addSubview(vQuestionsLine)
        vQuestions.addSubview(tvQuestions)
        
        vAddQuestionButton.addSubview(btnAddQuestion)
        
        vClassmates.addSubview(lClassmates)
        vClassmates.addSubview(tvClassmates)
        vClassmates.addSubview(btnAdd)
        vClassmates.addSubview(btnOk)
        
        //Add containers to view
        view.addSubview(vIconAndName)
        view.addSubview(vTopButtons)
        view.addSubview(vButton)
        view.addSubview(vQuestions)
        view.addSubview(vAddQuestionButton)

        view.addSubview(blackView!)
        
        view.addSubview(vClassmates)
        view.addSubview(vAddClassmate)
        
        //Setup sizes and positions
        
        setupClassmatesViewComponents()
        setupComponents()
        
        //Setup questions table view
        
        tvClassmates.register(ClassmateTableViewCell.self, forCellReuseIdentifier: "classmateCell")
        tvQuestions.register(QuestionTableViewCell.self, forCellReuseIdentifier: "cellId")

        // Do any additional setup after loading the view.
    }
    
    func setupClassmatesViewComponents(){
    
        vClassmates.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -view.frame.width).isActive = true
        vClassmates.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        vClassmates.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 4/5).isActive = true
        vClassmates.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 2/3).isActive = true
        
        lClassmates.topAnchor.constraint(equalTo: vClassmates.topAnchor, constant: 20).isActive = true
        lClassmates.centerXAnchor.constraint(equalTo: vClassmates.centerXAnchor).isActive = true
        lClassmates.heightAnchor.constraint(equalToConstant: 60).isActive = true
        lClassmates.widthAnchor.constraint(equalTo: vClassmates.widthAnchor, multiplier: 4/5).isActive = true
        
        btnOk.bottomAnchor.constraint(equalTo: vClassmates.bottomAnchor, constant: -20).isActive = true
        btnOk.centerXAnchor.constraint(equalTo: vClassmates.centerXAnchor).isActive = true
        btnOk.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btnOk.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        btnAdd.centerXAnchor.constraint(equalTo: vClassmates.centerXAnchor).isActive = true
        btnAdd.bottomAnchor.constraint(equalTo: btnOk.topAnchor, constant: -10).isActive = true
        btnAdd.widthAnchor.constraint(equalTo: vClassmates.widthAnchor, multiplier: 1/3).isActive = true
        btnAdd.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        tvClassmates.topAnchor.constraint(equalTo: lClassmates.bottomAnchor, constant: 10).isActive = true
        tvClassmates.widthAnchor.constraint(equalTo: vClassmates.widthAnchor).isActive = true
        tvClassmates.centerXAnchor.constraint(equalTo: vClassmates.centerXAnchor).isActive = true
        tvClassmates.bottomAnchor.constraint(equalTo: btnAdd.topAnchor, constant: -10).isActive = true
        
    
    }
    
    func setupComponents(){
        
        
        //Containers
        vTopButtons.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        vTopButtons.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        vTopButtons.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        vTopButtons.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        vIconAndName.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        vIconAndName.topAnchor.constraint(equalTo: vTopButtons.topAnchor).isActive = true
        vIconAndName.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/3).isActive = true
        vIconAndName.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 9/10).isActive = true
        
        vButton.topAnchor.constraint(equalTo: vIconAndName.bottomAnchor, constant: 0).isActive = true
        vButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        vButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/8).isActive = true
        vButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 3/4).isActive = true
        
        vQuestions.topAnchor.constraint(equalTo: vButton.bottomAnchor, constant: 10).isActive = true
        vQuestions.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 9/10).isActive = true
        vQuestions.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        vQuestions.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        vAddQuestionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        vAddQuestionButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        vAddQuestionButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        vAddQuestionButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        //UI Elements
        
        btnBack.leftAnchor.constraint(equalTo: vTopButtons.leftAnchor, constant: 20).isActive = true
        btnBack.centerYAnchor.constraint(equalTo: vTopButtons.centerYAnchor).isActive = true
        btnBack.widthAnchor.constraint(equalToConstant: 30).isActive = true
        btnBack.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        btnAddPerson.rightAnchor.constraint(equalTo: vTopButtons.rightAnchor, constant: -20).isActive = true
        btnAddPerson.centerYAnchor.constraint(equalTo: vTopButtons.centerYAnchor).isActive = true
        btnAddPerson.widthAnchor.constraint(equalToConstant: 30).isActive = true
        btnAddPerson.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        ivGroupIcon.topAnchor.constraint(equalTo: vIconAndName.topAnchor, constant: 20).isActive = true
        ivGroupIcon.heightAnchor.constraint(equalToConstant: 115).isActive = true
        
        ivGroupIcon.widthAnchor.constraint(equalTo: ivGroupIcon.heightAnchor).isActive = true
        ivGroupIcon.centerXAnchor.constraint(equalTo: vIconAndName.centerXAnchor).isActive = true
        
        lGroupName.topAnchor.constraint(equalTo: ivGroupIcon.bottomAnchor, constant: 10).isActive = true
        lGroupName.centerXAnchor.constraint(equalTo: vIconAndName.centerXAnchor).isActive = true
        lGroupName.widthAnchor.constraint(equalTo: vIconAndName.widthAnchor, multiplier: 9/10).isActive = true
        lGroupName.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        vFirstLine.bottomAnchor.constraint(equalTo: lGroupName.bottomAnchor, constant: 1).isActive = true
        vFirstLine.widthAnchor.constraint(equalTo: vIconAndName.widthAnchor, multiplier: 9/10).isActive = true
        vFirstLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        vFirstLine.centerXAnchor.constraint(equalTo: vIconAndName.centerXAnchor).isActive = true
        
        btnFlash.rightAnchor.constraint(equalTo: vButton.centerXAnchor, constant: -5).isActive = true
        btnFlash.heightAnchor.constraint(equalTo: vButton.heightAnchor, multiplier: 9/10).isActive = true
        btnFlash.widthAnchor.constraint(equalTo: vButton.widthAnchor, multiplier: 1/2).isActive = true
        btnFlash.centerYAnchor.constraint(equalTo: vButton.centerYAnchor).isActive = true
        
        btnStudy.leftAnchor.constraint(equalTo: vButton.centerXAnchor, constant: 5).isActive = true
        btnStudy.centerYAnchor.constraint(equalTo: vButton.centerYAnchor).isActive = true
        btnStudy.heightAnchor.constraint(equalTo: vButton.heightAnchor, multiplier: 9/10).isActive = true
        btnStudy.widthAnchor.constraint(equalTo: vButton.widthAnchor, multiplier: 1/2).isActive = true
        
        lMyQuestions.topAnchor.constraint(equalTo: vQuestions.topAnchor, constant: 10).isActive = true
        lMyQuestions.leftAnchor.constraint(equalTo: vQuestions.leftAnchor, constant: 10).isActive = true
        lMyQuestions.heightAnchor.constraint(equalToConstant: 30).isActive = true
        lMyQuestions.rightAnchor.constraint(equalTo: vQuestions.rightAnchor).isActive = true
        
        vQuestionsLine.topAnchor.constraint(equalTo: lMyQuestions.bottomAnchor, constant: 10).isActive = true
        vQuestionsLine.leftAnchor.constraint(equalTo: lMyQuestions.leftAnchor).isActive = true
        vQuestionsLine.widthAnchor.constraint(equalTo: vQuestions.widthAnchor, multiplier: 7/10).isActive = true
        vQuestionsLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        tvQuestions.topAnchor.constraint(equalTo: vQuestionsLine.bottomAnchor, constant: 10).isActive = true
        tvQuestions.widthAnchor.constraint(equalTo: vQuestions.widthAnchor).isActive = true
        tvQuestions.bottomAnchor.constraint(equalTo: vQuestions.bottomAnchor, constant: 0).isActive = true
        tvQuestions.centerXAnchor.constraint(equalTo: vQuestions.centerXAnchor).isActive = true
        
        btnAddQuestion.centerXAnchor.constraint(equalTo: vAddQuestionButton.centerXAnchor).isActive = true
        btnAddQuestion.centerYAnchor.constraint(equalTo: vAddQuestionButton.centerYAnchor).isActive = true
        btnAddQuestion.heightAnchor.constraint(equalTo: vAddQuestionButton.heightAnchor).isActive = true
        btnAddQuestion.widthAnchor.constraint(equalTo: vAddQuestionButton.widthAnchor).isActive = true
        
        //Add Classmate Container
        
        vAddClassmate.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: view.frame.width).isActive = true
        vAddClassmate.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        vAddClassmate.heightAnchor.constraint(equalToConstant: 300).isActive = true
        vAddClassmate.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 4/5).isActive = true
    }
    
    /*
 
     MARK: Firebase
 
 */
       
    func handleErrorAlert(error: String){
        
        let alert = UIAlertController(title: "Oops", message: error, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            
            alert.dismiss(animated: true, completion: nil)
            
        }))
        
        present(alert, animated: true, completion: nil)
        
        
    }
    
    func handleAlert(title: String, message: String){
    
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            
            alert.dismiss(animated: true, completion: nil)
            
        }))
        
        present(alert, animated: true, completion: nil)
    
    }
    
    var timer: Timer?
    
    fileprivate func tryRefreshingTable(){
    
        self.timer?.invalidate()
        
        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(handleReloadData), userInfo: nil, repeats: false
        )
    
    
    }
    
    func handleReloadData(){
    
        DispatchQueue.main.async {
            self.tvClassmates.reloadData()
            self.tvQuestions.reloadData()
        }
    
    
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        
        textField.resignFirstResponder()
        return true
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    /*
 
     MARK: Question preview
 
 */
    var vQuestionPreview: QuestionPreviewView?
    
    func handleQuestionPreview(question : QuestionObject, index : Int){
        
        btnAddPerson.isEnabled = false
        
        if let keyWindow = UIApplication.shared.keyWindow{
            
            self.blackView?.isUserInteractionEnabled = true

            
            blackView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismissQuestionPreview)))
            
            let rect = CGRect(x: keyWindow.frame.midX + keyWindow.frame.width, y: keyWindow.frame.midY, width: keyWindow.frame.width * (9/10), height: keyWindow.frame.height * (1/2))
            
            vQuestionPreview = QuestionPreviewView(frame: rect)
            
            vQuestionPreview?.lQuestion.text = question.sQuestionText
            
            print(question.sQuestionId!)
            
            vQuestionPreview?.setDeleteFunction {
                
                self.deleteQuestionFromFirebase(questionId: question.sQuestionId!, index: index)
                
            }
            
            vQuestionPreview?.setEditFunc {
                
                print("Clicked edit")
                self.handleEditQuestion(question: question)
                
            }
            
            keyWindow.addSubview(vQuestionPreview!)
            
            UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                
                self.blackView?.alpha = 0.5
                
                self.vQuestionPreview?.frame = CGRect(x: keyWindow.frame.midX, y: keyWindow.frame.midY, width: keyWindow.frame.width * (9/10), height: keyWindow.frame.height * (1/2))
                
                self.vQuestionPreview?.center = keyWindow.center
                
                
            }, completion: { (completed) in
                
                
            })
            
            
            
        }
        
    }
    
    func handleDismissQuestionPreview(){
    
        btnAddPerson.isEnabled = true
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.blackView?.alpha = 0
            
            self.blackView?.isUserInteractionEnabled = false
            
            self.vQuestionPreview?.frame = CGRect(x: self.view.frame.midX + self.view.frame.width, y: self.view.frame.midY, width: self.view.frame.width * (9/10), height: self.view.frame.height * (1/2))
            
            if let index = self.tvQuestions.indexPathForSelectedRow {
            
                self.tvQuestions.deselectRow(at: index, animated: true)
            
            }
            
            
        }) { (completed) in
            
            
        }
        
    
    
    }
    
    func handleEditQuestion(question: QuestionObject){
    
        let controller = NewQuestionViewController()
        
        controller.groupController = self
        controller.Question = question
        controller.Group = Group
        
        self.present(controller, animated: true, completion: nil)
    
    }


}

extension IndividualGroupViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        print("Prefetch Rows at : \(indexPaths)")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(tableView == tvClassmates){
        
            return classmates.count
        
        }
        
        print(questions.count)
        
        return questions.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(tableView == tvClassmates){
        
            return 60
        
        }
        
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if(tableView == tvQuestions){
            
            let question = questions[indexPath.row]
            
            let userId = Auth.auth().currentUser?.uid
            
            let ref = Database.database().reference().child("Questions").child(question.sQuestionId!)
            
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
            
                if let dictionary = snapshot.value as? [String: AnyObject] {
                
                    if(dictionary["creator"] != nil){
                    
                        if(dictionary["creator"] as! String == userId){
                        
                            self.handleQuestionPreview(question: question, index: indexPath.row)

                        
                        }
                    
                    } else {
                    
                        self.handleQuestionPreview(question: question, index: indexPath.row)
                    }
                    
                
                }
                
                
            })
            
            //handleShowQuestionPreview
            
        
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(tableView == tvClassmates){
        
            print("Do something")
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "classmateCell", for: indexPath) as! ClassmateTableViewCell
            
            cell.lName.text = classmates[indexPath.row].name
            
            cell.lEmail.text = classmates[indexPath.row].email
            
            return cell
        
        } else {
        
            print("Do something else ")

            let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! QuestionTableViewCell
            
            let question = questions[indexPath.row]
            
            cell.lQuestion.text = question.sQuestionText
            
            print(question.sImageId)
            
            cell.ivQuestion.image = UIImage(named: "questionImage")
            
            if(question.sImageId == nil){
                
                cell.ivQuestion.isHidden = true
                
            } else {
                
                cell.ivQuestion.loadImageUsingCacheWithUrlString(urlString: question.sImageId!)
                cell.ivQuestion.isHidden = false
                
            }
            
            return cell
            
        }
        
            
        }
    


}


