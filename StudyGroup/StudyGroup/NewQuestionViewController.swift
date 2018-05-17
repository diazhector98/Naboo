//
//  NewQuestionViewController.swift
//  StudyGroup
//
//  Created by Hector Díaz Aceves on 25/11/17.
//  Copyright © 2017 HectorDiaz. All rights reserved.
//

import UIKit
import Firebase

class NewQuestionViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    var bHasImage: Bool = false
    
    var bIsInEditingMode: Bool = false
    
    var questionImageView: UIImageView = UIImageView()
    
    var groupController: IndividualGroupViewController?
    
    var bIsMultipleChoice: Bool = true
    
    var bAnswerIsTrue: Bool = true
    
    var Group: GroupObject? {
    
        didSet{
        
            lGroupName.text = Group?.sGroupName
            ivIcon.image = UIImage(named: "GroupIcon\((Group?.iGroupIcon)!+1)")
        
        
        }
    
    
    }
    
    var Question: QuestionObject? {
    
        didSet{
            
            //Ihe question has an image...
            if(Question?.sImageId != nil){
                
                let imageView = UIImageView()
                bHasImage = true
                imageView.loadImageUsingCacheWithUrlString(urlString: (Question?.sImageId!)!)
                btnImage.setImage(imageView.image, for: .normal)
            
            }
            
    
            if(Question?.sOption1 != nil){
                

                bIsMultipleChoice = true
                
                vTrueContainer.isHidden = true
                vFalseContainer.isHidden = true
                
                ivIcon1.isHidden = false
                tfOption1.isHidden = false
                ivIcon2.isHidden = false
                tfOption2.isHidden = false
                btnRandom2.isHidden = false
                ivIcon3.isHidden = false
                tfOption3.isHidden = false
                btnRandom3.isHidden = false
                ivIcon4.isHidden = false
                tfOption4.isHidden = false
                btnRandom4.isHidden = false
                
                btnTrueFalse.isEnabled = true
                btnMultipleOptions.isEnabled = false
                
                //Assign value of text fields to questions
                
                tfQuestion.text = Question?.sQuestionText
                tfOption1.text = Question?.sAnswer
                tfOption2.text = Question?.sOption1
                tfOption3.text = Question?.sOption2
                tfOption4.text = Question?.sOption3
                //Change icons
                ivIcon1.image = UIImage(named: "optionAIconGreen")
                ivIcon2.image = UIImage(named: "optionBIconRed")
                ivIcon3.image = UIImage(named: "optionCIconRed")
                ivIcon4.image = UIImage(named: "optionDIconRed")
            
            } else {

                bIsMultipleChoice = false
                ivIcon1.isHidden = true
                tfOption1.isHidden = true
                ivIcon2.isHidden = true
                tfOption2.isHidden = true
                btnRandom2.isHidden = true
                ivIcon3.isHidden = true
                tfOption3.isHidden = true
                btnRandom3.isHidden = true
                ivIcon4.isHidden = true
                tfOption4.isHidden = true
                btnRandom4.isHidden = true
                
                btnTrueFalse.isEnabled = false
                btnMultipleOptions.isEnabled = true

                
                print("Handled show true false")
                
                if(Question?.sAnswer == "true"){
                
                    handleTrue()
                    
                
                } else {
                
                    handleFalse()
                
                }
                
            
            
            }
            
            txtvQuestion.text = Question?.sQuestionText


            //Change text to button
            btnAddQuestion.setTitle("Edit", for: .normal)
            btnAddQuestion.titleLabel?.text = "Edit"
            bIsInEditingMode = true
        
        }
    
    }
    
    
    /*
 
 
     MARK: UI elements
 
 */
    
    lazy var btnBack: UIButton = {
    
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "backButton"), for: .normal)
        button.setImage(UIImage(named: "backButtonPushed"), for: .highlighted)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        button.setTitle("Back", for: .normal)
        return button
    
    
    }()
    
    let ivIcon: UIImageView = {
    
        let iv = UIImageView()
        iv.image = UIImage(named: "GroupIcon1")
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    
    }()
    
    let lGroupName: UILabel = {
    
        let label = UILabel()
        label.text = "Mathematics II"
        label.font = UIFont(name: "Helvetica-Bold", size: 30)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    
    }()
    
    lazy var btnImage: UIButton = {
        
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(handleChooseQuestionImage), for: .touchUpInside)
        button.setImage(UIImage(named: "questionImage"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let lQuestion: UILabel = {
    
        let label = UILabel()
        label.text = "Question"
        label.font = UIFont(name: "Helvetica", size: 20)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    
    }()
    
    let txtvQuestion: UITextView = {
    
        let textview = UITextView()
        textview.layer.cornerRadius = 10
        textview.font = UIFont(name: "Helvetica", size: 20)
        textview.backgroundColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 0.34)
        textview.clipsToBounds = true
        textview.translatesAutoresizingMaskIntoConstraints = false
        return textview
    
    }()
    
    let tfQuestion: UITextField = {
    
        let tf = UITextField()
        tf.background = UIImage(named: "textFieldRounded")
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        tf.leftViewMode = .always
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "What is the capital of Mexico?"
        return tf
    
    }()
    
    let lOptions: UILabel = {
        
        let label = UILabel()
        label.text = "Options"
        label.font = UIFont(name: "Helvetica", size: 20)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    lazy var btnMultipleOptions: UIButton = {
    
        let button = UIButton(type: .system)
        button.tintColor = .black
        button.contentMode = .scaleAspectFit
        button.setImage(UIImage(named: "MultipleChoiceIcon"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleShowMultiple), for: .touchUpInside)
        return button;
    
    
    }()
    
    lazy var btnTrueFalse: UIButton = {
        
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "TrueFalseIcon"), for: .normal)
        button.tintColor = .black
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(handleShowTrueFalse), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button;
        
        
    }()
    
    let ivIcon1: UIImageView = {
        
        let iv = UIImageView()
        iv.image = UIImage(named: "optionAIcon")
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
        
    }()
    
    lazy var tfOption1: UITextField = {
        
        let tf = UITextField()
        tf.background = UIImage(named: "textFieldRounded")
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        tf.leftViewMode = .always
        tf.delegate = self
        tf.tag = 1;
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Answer"
        return tf
        
    }()
    
    
    let ivIcon2: UIImageView = {
        
        let iv = UIImageView()
        iv.image = UIImage(named: "optionBIcon")
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
        
    }()
    
    lazy var tfOption2: UITextField = {
        
        let tf = UITextField()
        tf.background = UIImage(named: "textFieldRounded")
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        tf.leftViewMode = .always
        tf.delegate = self
        tf.tag = 2;
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Option 2"
        return tf
        
    }()
    
    lazy var btnRandom2: UIButton = {
        
        let button = UIButton(type: .custom)
        button.isHidden = true
        button.isEnabled = false
        button.tag = 2
        button.addTarget(self, action: #selector(handleRandomize), for: .touchUpInside)
        button.setImage(UIImage(named: "randomIcon"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    let ivIcon3: UIImageView = {
        
        let iv = UIImageView()
        iv.image = UIImage(named: "optionCIcon")
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
        
    }()
    
    lazy var tfOption3: UITextField = {
        
        let tf = UITextField()
        tf.background = UIImage(named: "textFieldRounded")
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        tf.leftViewMode = .always
        tf.delegate = self
        tf.tag = 3;
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Option 3"
        return tf
        
    }()
    
    lazy var btnRandom3: UIButton = {
        
        let button = UIButton(type: .custom)
        button.isHidden = true
        button.isEnabled = false
        button.tag = 3
        button.addTarget(self, action: #selector(handleRandomize), for: .touchUpInside)
        button.setImage(UIImage(named: "randomIcon"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    let ivIcon4: UIImageView = {
        
        let iv = UIImageView()
        iv.image = UIImage(named: "optionDIcon")
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
        
    }()
    
    lazy var tfOption4: UITextField = {
        
        let tf = UITextField()
        tf.background = UIImage(named: "textFieldRounded")
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        tf.leftViewMode = .always
        tf.delegate = self
        tf.tag = 4;
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Option 4"
        return tf
        
    }()
    
    lazy var btnRandom4: UIButton = {
        
        let button = UIButton(type: .custom)
        button.isHidden = true
        button.isEnabled = false
        button.tag = 4
        button.addTarget(self, action: #selector(handleRandomize), for: .touchUpInside)
        button.setImage(UIImage(named: "randomIcon"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    lazy var btnAddQuestion: UIButton = {
        
        let button = UIButton(type: .system)
        button.tintColor = .black
        button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 24)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.addTarget(self, action: #selector(handleAddQuestion), for: .touchUpInside)
        button.setTitle("Add Question", for: .normal)
        return button
        
        
    }()
    
    lazy var btnTrue: UIButton = {
    
        let button = UIButton(type: .system)
        button.setTitle("True", for: .normal)
        button.tintColor = .black
        button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 30)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleTrue), for: .touchUpInside)
        return button;
    
    }()
    
    lazy var btnFalse: UIButton = {
        
        let button = UIButton(type: .system)
        button.setTitle("False", for: .normal)
        button.tintColor = .black
        button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 30)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleFalse), for: .touchUpInside)
        return button;
        
    }()
    
    /*
 
     MARK: UI containers
 
 */
    
    let vTopBar: UIView = {
    
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    
    }()
    
    let vQuestionContainer: UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    let vOptionsContainer: UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    let vTrueContainer: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let vFalseContainer: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let vAddQuestionContainer: UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    /*
 
 
     MARK: Button Function
 
 
 */
    
    
    func handleBack(){
            
        self.dismiss(animated: true, completion: nil)
    
    }
    
    func handleChooseQuestionImage(){
        
        let imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
        
        imagePicker.allowsEditing = true
        
        imagePicker.sourceType = .photoLibrary
        
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        
        present(imagePicker, animated: true, completion: nil)
    
    
    }
    
    func handleShowMultiple(){
        
        bIsMultipleChoice = true
    
        vTrueContainer.isHidden = true
        vFalseContainer.isHidden = true
        
        ivIcon1.isHidden = false
        tfOption1.isHidden = false
        ivIcon2.isHidden = false
        tfOption2.isHidden = false
        btnRandom2.isHidden = false
        ivIcon3.isHidden = false
        tfOption3.isHidden = false
        btnRandom3.isHidden = false
        ivIcon4.isHidden = false
        tfOption4.isHidden = false
        btnRandom4.isHidden = false
        
        btnTrueFalse.isEnabled = true
        btnMultipleOptions.isEnabled = false
        
        
    }
    
    
    func handleShowTrueFalse(){
        
        bIsMultipleChoice = false
    
        vTrueContainer.isHidden = false
        vFalseContainer.isHidden = false
        
        ivIcon1.isHidden = true
        tfOption1.isHidden = true
        ivIcon2.isHidden = true
        tfOption2.isHidden = true
        btnRandom2.isHidden = true
        ivIcon3.isHidden = true
        tfOption3.isHidden = true
        btnRandom3.isHidden = true
        ivIcon4.isHidden = true
        tfOption4.isHidden = true
        btnRandom4.isHidden = true
        
        btnTrueFalse.isEnabled = false
        btnMultipleOptions.isEnabled = true
        
        
    }
    
    func handleTrue(){
        
        bAnswerIsTrue = true
        
        vTrueContainer.backgroundColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        vFalseContainer.backgroundColor = .white
    
    }
    
    func handleFalse(){
        
        bAnswerIsTrue = false
        
        vFalseContainer.backgroundColor = UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 1)
        vTrueContainer.backgroundColor = .white
    
    }
    
    func handleRandomize(sender: UIButton){
        
        let sValue = tfOption1.text
        
        if(sValue?.characters.count != 0){
        
            let iValue = Int(sValue!)
            
            if(iValue != nil){
            
                let iTop = iValue! + 3
                let iLow = iValue! - 3
                var iRandom: Int
                
                repeat{
                    
                    iRandom = Int(arc4random_uniform(UInt32(10))) + iLow
                
                } while (iRandom == iValue)
                
                
                print(sender.tag)
                
                if(sender.tag == 2){
                
                    ivIcon2.image = UIImage(named: "optionBIconRed")
                    tfOption2.text = String(iRandom)
                
                } else if ( sender.tag == 3){
                
                    ivIcon3.image = UIImage(named: "optionCIconRed")
                    tfOption3.text = String(iRandom)
                
                } else {
                
                    ivIcon4.image = UIImage(named: "optionDIconRed")
                    tfOption4.text = String(iRandom)

                }
            
            
            }
        
        }
        
    }
    
    func handleAddQuestion(){
        
        let userId = Auth.auth().currentUser?.uid
        
        //Multiple choice
        
        if(bIsMultipleChoice){
            
            if(txtvQuestion.text == ""){
                handleErrorAlert(error: "Question cant' be empty.")
            } else {
                
                if(tfOption1.text == ""){
                    handleErrorAlert(error: "You must present an answer.")
                } else {
                    if(tfOption2.text == ""||tfOption3.text == ""||tfOption4.text == ""){
                        handleErrorAlert(error: "You must present all the options")
                    } else {
                        
                        addQuestionToDatabase(sQuestion: txtvQuestion.text!, sAnswer: tfOption1.text!, sOption1: tfOption2.text!, sOption2: tfOption3.text!, sOption3: tfOption4.text!, sCreatorId: userId!)
                        
                    }
                }
            }
        
        
        } else {
        
            //True false
            
            addTrueFalseQuestionToDatabase(sQuestion: txtvQuestion.text!, sAnswer: bAnswerIsTrue.description, sCreatorId: userId!)

            
        }
    
    }
    
    func handleErrorAlert(error: String){
    
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            
            alert.dismiss(animated: true, completion: nil)
            
        }))
        
        present(alert, animated: true, completion: nil)
        
    
    }
    
    
    /*
 
     MARK: Image Picking functions
 
     
 */
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        bHasImage = true
        
        handleImageSelected(info as [String: AnyObject])
        
        
        dismiss(animated: true, completion: nil)
        
        
    }
    
    fileprivate func handleImageSelected(_ info: [String: AnyObject]){
        
        var selectedImage: UIImage?
    
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
        
            selectedImage = editedImage
            
        }
        
        if let image = selectedImage{
        
            handleChangeImage(image)
        
        }
    
    
    }
    
    fileprivate func handleChangeImage(_ image: UIImage){
    
        self.questionImageView.image = image;
        
        self.btnImage.setImage(image, for: .normal)
    
    
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
    
    }
    
    /*
 
     MARK: View Creation
 
 
 */
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("View will appear")
        if(bIsMultipleChoice){
        
            vTrueContainer.isHidden = true
            vFalseContainer.isHidden = true

        
        } else {
        
            vTrueContainer.isHidden = false
            vFalseContainer.isHidden = false
        
        }
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        //Define tags for random buttons
        btnRandom2.tag = 2
        btnRandom3.tag = 3
        btnRandom4.tag = 4
        
        //Add ui elements to containers
        
        vTopBar.addSubview(btnBack)
        vTopBar.addSubview(ivIcon)
        vTopBar.addSubview(lGroupName)
        
        vQuestionContainer.addSubview(btnImage)
        vQuestionContainer.addSubview(lQuestion)
        vQuestionContainer.addSubview(txtvQuestion)
        
        vTrueContainer.addSubview(btnTrue)
        vFalseContainer.addSubview(btnFalse)
        
        vOptionsContainer.addSubview(lOptions)
        vOptionsContainer.addSubview(btnMultipleOptions)
        vOptionsContainer.addSubview(btnTrueFalse)
        vOptionsContainer.addSubview(ivIcon1)
        vOptionsContainer.addSubview(tfOption1)
        vOptionsContainer.addSubview(ivIcon2)
        vOptionsContainer.addSubview(tfOption2)
        vOptionsContainer.addSubview(btnRandom2)
        vOptionsContainer.addSubview(ivIcon3)
        vOptionsContainer.addSubview(tfOption3)
        vOptionsContainer.addSubview(btnRandom3)
        vOptionsContainer.addSubview(ivIcon4)
        vOptionsContainer.addSubview(tfOption4)
        vOptionsContainer.addSubview(btnRandom4)
        
        vOptionsContainer.addSubview(vTrueContainer)
        vOptionsContainer.addSubview(vFalseContainer)
        
        vTrueContainer.isHidden = true
        vFalseContainer.isHidden = true

        
        vAddQuestionContainer.addSubview(btnAddQuestion)
        //Add containers to view
        
        view.addSubview(vTopBar)
        view.addSubview(vQuestionContainer)
        view.addSubview(vOptionsContainer)
        view.addSubview(vAddQuestionContainer)
        
        //Setup sizes and positions
        
        setupComponents()
        
        //Setup Keyboard
        
        setupKeyboardObservers()
        

        // Do any additional setup after loading the view.
    }
    
    func setupComponents(){
    
        //Containers
        
        vTopBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        vTopBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        vTopBar.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        vTopBar.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        vQuestionContainer.topAnchor.constraint(equalTo: vTopBar.bottomAnchor, constant: 10).isActive = true
        vQuestionContainer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 9/10).isActive = true
        vQuestionContainer.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/5).isActive = true
        vQuestionContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        vOptionsContainer.topAnchor.constraint(equalTo: vQuestionContainer.bottomAnchor, constant: 10).isActive = true
        vOptionsContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        vOptionsContainer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 9/10).isActive = true
        vOptionsContainer.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/2).isActive = true
        
        vAddQuestionContainer.topAnchor.constraint(equalTo: vOptionsContainer.bottomAnchor, constant: 10).isActive = true
        vAddQuestionContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        vAddQuestionContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        vAddQuestionContainer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 9/10).isActive = true
        
        //UI Elements
        
        /*Top Bar*/
        
        btnBack.leftAnchor.constraint(equalTo: vTopBar.leftAnchor, constant: 20).isActive = true
        btnBack.centerYAnchor.constraint(equalTo: vTopBar.centerYAnchor).isActive = true
        btnBack.widthAnchor.constraint(equalToConstant: 30).isActive = true
        btnBack.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        ivIcon.leftAnchor.constraint(equalTo: btnBack.rightAnchor, constant: 40).isActive = true
        ivIcon.widthAnchor.constraint(equalToConstant: 60).isActive = true
        ivIcon.heightAnchor.constraint(equalTo: ivIcon.widthAnchor).isActive = true
        ivIcon.centerYAnchor.constraint(equalTo: vTopBar.centerYAnchor).isActive = true
        
        lGroupName.leftAnchor.constraint(equalTo: ivIcon.rightAnchor, constant: 20).isActive = true
        lGroupName.rightAnchor.constraint(equalTo: vTopBar.rightAnchor, constant: -20).isActive = true
        lGroupName.heightAnchor.constraint(equalTo: vTopBar.heightAnchor, multiplier: 9/10).isActive = true
        lGroupName.centerYAnchor.constraint(equalTo: vTopBar.centerYAnchor).isActive = true
        
        /*Question*/

        btnImage.leftAnchor.constraint(equalTo: vQuestionContainer.leftAnchor, constant: 10).isActive = true
        btnImage.widthAnchor.constraint(equalTo: vQuestionContainer.widthAnchor, multiplier: 1/4).isActive = true
        btnImage.heightAnchor.constraint(equalTo: vQuestionContainer.heightAnchor, multiplier: 9/10).isActive = true
        btnImage.centerYAnchor.constraint(equalTo: vQuestionContainer.centerYAnchor).isActive = true
        
        
        lQuestion.topAnchor.constraint(equalTo: vQuestionContainer.topAnchor, constant: 10).isActive = true
        lQuestion.centerXAnchor.constraint(equalTo: txtvQuestion.centerXAnchor).isActive = true
        lQuestion.widthAnchor.constraint(equalTo: txtvQuestion.widthAnchor).isActive = true
        lQuestion.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        txtvQuestion.leftAnchor.constraint(equalTo: btnImage.rightAnchor, constant: 20).isActive = true
        txtvQuestion.rightAnchor.constraint(equalTo: vQuestionContainer.rightAnchor, constant: -20).isActive = true
        txtvQuestion.topAnchor.constraint(equalTo: lQuestion.bottomAnchor, constant: 0).isActive = true
        txtvQuestion.bottomAnchor.constraint(equalTo: vQuestionContainer.bottomAnchor, constant: 0).isActive = true
        
        
        /*Options*/
        
        lOptions.topAnchor.constraint(equalTo: vOptionsContainer.topAnchor, constant: 10).isActive = true
        lOptions.leftAnchor.constraint(equalTo: vOptionsContainer.leftAnchor, constant: 10).isActive = true
        lOptions.widthAnchor.constraint(equalTo: vOptionsContainer.widthAnchor, multiplier: 1/5).isActive = true
        lOptions.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        btnMultipleOptions.leftAnchor.constraint(equalTo: lOptions.rightAnchor, constant: 10).isActive = true
        btnMultipleOptions.widthAnchor.constraint(equalToConstant: 100).isActive = true
        btnMultipleOptions.topAnchor.constraint(equalTo: lOptions.topAnchor).isActive = true
        btnMultipleOptions.bottomAnchor.constraint(equalTo: lOptions.bottomAnchor).isActive = true
        
        btnTrueFalse.leftAnchor.constraint(equalTo: btnMultipleOptions.rightAnchor, constant: 10).isActive = true
        btnTrueFalse.widthAnchor.constraint(equalToConstant: 100).isActive = true
        btnTrueFalse.topAnchor.constraint(equalTo: lOptions.topAnchor).isActive = true
        btnTrueFalse.bottomAnchor.constraint(equalTo: lOptions.bottomAnchor).isActive = true
        
        ivIcon1.topAnchor.constraint(equalTo: lOptions.bottomAnchor, constant: 20).isActive = true
        ivIcon1.widthAnchor.constraint(equalToConstant: 45).isActive = true
        ivIcon1.heightAnchor.constraint(equalToConstant: 45).isActive = true
        ivIcon1.leftAnchor.constraint(equalTo: lOptions.leftAnchor).isActive = true
        
        ivIcon2.topAnchor.constraint(equalTo: ivIcon1.bottomAnchor, constant: 20).isActive = true
        ivIcon2.widthAnchor.constraint(equalToConstant: 45).isActive = true
        ivIcon2.heightAnchor.constraint(equalToConstant: 45).isActive = true
        ivIcon2.leftAnchor.constraint(equalTo: lOptions.leftAnchor).isActive = true
        
        ivIcon3.topAnchor.constraint(equalTo: ivIcon2.bottomAnchor, constant: 20).isActive = true
        ivIcon3.widthAnchor.constraint(equalToConstant: 45).isActive = true
        ivIcon3.heightAnchor.constraint(equalToConstant: 45).isActive = true
        ivIcon3.leftAnchor.constraint(equalTo: lOptions.leftAnchor).isActive = true
        
        ivIcon4.topAnchor.constraint(equalTo: ivIcon3.bottomAnchor, constant: 20).isActive = true
        ivIcon4.widthAnchor.constraint(equalToConstant: 45).isActive = true
        ivIcon4.heightAnchor.constraint(equalToConstant: 45).isActive = true
        ivIcon4.leftAnchor.constraint(equalTo: lOptions.leftAnchor).isActive = true
        
        tfOption1.leftAnchor.constraint(equalTo: ivIcon1.rightAnchor, constant: 10).isActive = true
        tfOption1.rightAnchor.constraint(equalTo: vOptionsContainer.rightAnchor, constant: -40).isActive = true
        tfOption1.heightAnchor.constraint(equalToConstant: 40).isActive = true
        tfOption1.centerYAnchor.constraint(equalTo: ivIcon1.centerYAnchor).isActive = true

        tfOption2.leftAnchor.constraint(equalTo: ivIcon2.rightAnchor, constant: 10).isActive = true
        tfOption2.rightAnchor.constraint(equalTo: vOptionsContainer.rightAnchor, constant: -40).isActive = true
        tfOption2.heightAnchor.constraint(equalToConstant: 40).isActive = true
        tfOption2.centerYAnchor.constraint(equalTo: ivIcon2.centerYAnchor).isActive = true
        
        btnRandom2.rightAnchor.constraint(equalTo: vOptionsContainer.rightAnchor).isActive = true
        btnRandom2.leftAnchor.constraint(equalTo: tfOption2.rightAnchor, constant: 10).isActive = true
        btnRandom2.heightAnchor.constraint(equalTo: tfOption2.heightAnchor).isActive = true
        btnRandom2.centerYAnchor.constraint(equalTo: tfOption2.centerYAnchor).isActive = true
        
        tfOption3.leftAnchor.constraint(equalTo: ivIcon3.rightAnchor, constant: 10).isActive = true
        tfOption3.rightAnchor.constraint(equalTo: vOptionsContainer.rightAnchor, constant: -40).isActive = true
        tfOption3.heightAnchor.constraint(equalToConstant: 40).isActive = true
        tfOption3.centerYAnchor.constraint(equalTo: ivIcon3.centerYAnchor).isActive = true
        
        btnRandom3.rightAnchor.constraint(equalTo: vOptionsContainer.rightAnchor).isActive = true
        btnRandom3.leftAnchor.constraint(equalTo: tfOption3.rightAnchor, constant: 10).isActive = true
        btnRandom3.heightAnchor.constraint(equalTo: tfOption3.heightAnchor).isActive = true
        btnRandom3.centerYAnchor.constraint(equalTo: tfOption3.centerYAnchor).isActive = true
        
        tfOption4.leftAnchor.constraint(equalTo: ivIcon4.rightAnchor, constant: 10).isActive = true
        tfOption4.rightAnchor.constraint(equalTo: vOptionsContainer.rightAnchor, constant: -40).isActive = true
        tfOption4.heightAnchor.constraint(equalToConstant: 40).isActive = true
        tfOption4.centerYAnchor.constraint(equalTo: ivIcon4.centerYAnchor).isActive = true
        
        btnRandom4.rightAnchor.constraint(equalTo: vOptionsContainer.rightAnchor).isActive = true
        btnRandom4.leftAnchor.constraint(equalTo: tfOption4.rightAnchor, constant: 10).isActive = true
        btnRandom4.heightAnchor.constraint(equalTo: tfOption4.heightAnchor).isActive = true
        btnRandom4.centerYAnchor.constraint(equalTo: tfOption4.centerYAnchor).isActive = true
        
        //True and false
        
        vTrueContainer.topAnchor.constraint(equalTo: lOptions.bottomAnchor, constant: 30).isActive = true
        vTrueContainer.widthAnchor.constraint(equalTo: vOptionsContainer.widthAnchor, multiplier: 1/3).isActive = true
        vTrueContainer.heightAnchor.constraint(equalToConstant: 100).isActive = true
        vTrueContainer.leftAnchor.constraint(equalTo: vOptionsContainer.leftAnchor, constant: 30).isActive = true
        
        vFalseContainer.topAnchor.constraint(equalTo: lOptions.bottomAnchor, constant: 30).isActive = true
        vFalseContainer.widthAnchor.constraint(equalTo: vOptionsContainer.widthAnchor, multiplier: 1/3).isActive = true
        vFalseContainer.heightAnchor.constraint(equalToConstant: 100).isActive = true
        vFalseContainer.rightAnchor.constraint(equalTo: vOptionsContainer.rightAnchor, constant: -30).isActive = true
        
        btnTrue.centerXAnchor.constraint(equalTo: vTrueContainer.centerXAnchor).isActive = true
        btnTrue.centerYAnchor.constraint(equalTo: vTrueContainer.centerYAnchor).isActive = true
        btnTrue.widthAnchor.constraint(equalTo: vTrueContainer.widthAnchor, multiplier: 9/10).isActive = true
        btnTrue.heightAnchor.constraint(equalTo: vTrueContainer.heightAnchor, multiplier: 1/2).isActive = true
        
        btnFalse.centerXAnchor.constraint(equalTo: vFalseContainer.centerXAnchor).isActive = true
        btnFalse.centerYAnchor.constraint(equalTo: vFalseContainer.centerYAnchor).isActive = true
        btnFalse.widthAnchor.constraint(equalTo: vFalseContainer.widthAnchor, multiplier: 9/10).isActive = true
        btnFalse.heightAnchor.constraint(equalTo: vFalseContainer.heightAnchor, multiplier: 1/2).isActive = true
        
        
        
        /*Add Button*/
        
        btnAddQuestion.centerXAnchor.constraint(equalTo: vAddQuestionContainer.centerXAnchor).isActive = true
        btnAddQuestion.centerYAnchor.constraint(equalTo: vAddQuestionContainer.centerYAnchor).isActive = true
        btnAddQuestion.widthAnchor.constraint(equalTo: vAddQuestionContainer.widthAnchor, multiplier: 1/2).isActive = true
        btnAddQuestion.heightAnchor.constraint(equalTo: vAddQuestionContainer.heightAnchor, multiplier: 1/4).isActive = true

    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
 
     MARK: Firebase
 
 */
    
    //Add question to database
    
    func addQuestionToDatabase(sQuestion: String, sAnswer: String, sOption1: String, sOption2: String, sOption3: String, sCreatorId: String){
        
        
        var values:[String:AnyObject] = ["question": sQuestion as AnyObject, "answer": sAnswer as AnyObject, "option1":sOption1 as AnyObject, "option2":sOption2 as AnyObject, "option3":sOption3 as AnyObject, "creator" : sCreatorId as AnyObject]
        
        if(bIsInEditingMode){
        
            if(true){
            
                if(bHasImage){
                
                    //Has changed the question picture
                    
                    print("It has image")
                    //Get name of image
                    let sImageName = UUID().uuidString
                    
                    //Get reference to storage of firebase
                    
                    let storageRef = Storage.storage().reference().child("question_images").child("\(sImageName).png")
                    
                    //Get image and jpeg represantation. If allowed, upload to storage
                    
                    if let image = questionImageView.image, let uploadData = UIImageJPEGRepresentation(image, 0.1){
                        
                        print("It could be represented as a JPEG")
                        
                        storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                            
                            if (error != nil){
                                self.handleErrorAlert(error: "Error uploading image")
                                return
                            }
                            
                            if let imageUrl = metadata?.downloadURL()?.absoluteString{
                                
                                values = ["question": sQuestion as AnyObject, "answer": sAnswer as AnyObject, "option1":sOption1 as AnyObject, "option2":sOption2 as AnyObject, "option3":sOption3 as AnyObject, "imageUrl": imageUrl as AnyObject, "creator" : sCreatorId as AnyObject]
                                
                                self.uploadToDatabase(values: values)
                                
                            }
                            
                        })
                        
                    }
                    
                    return

                }
                
                //If it hasn't change the image...
                values.updateValue(Question?.sImageId as AnyObject, forKey: "imageUrl")
                bHasImage = true
            }
            
            self.uploadToDatabase(values: values)

            return
        
        }
        
        if(bHasImage){
        
            print("It has image")
            //Get name of image
            let sImageName = UUID().uuidString
            
            //Get reference to storage of firebase
            
            let storageRef = Storage.storage().reference().child("question_images").child("\(sImageName).png")
            
            //Get image and jpeg represantation. If allowed, upload to storage
            
            if let image = questionImageView.image, let uploadData = UIImageJPEGRepresentation(image, 0.1){
                
                print("It could be represented as a JPEG")
                
                storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                    
                    if (error != nil){
                        self.handleErrorAlert(error: "Error uploading image")
                        return
                    }
                    
                    if let imageUrl = metadata?.downloadURL()?.absoluteString{
                    
                        values = ["question": sQuestion as AnyObject, "answer": sAnswer as AnyObject, "option1":sOption1 as AnyObject, "option2":sOption2 as AnyObject, "option3":sOption3 as AnyObject, "imageUrl": imageUrl as AnyObject, "creator" : sCreatorId as AnyObject]
                        
                        self.uploadToDatabase(values: values)

                    }
                    
                })
            
            }
        
            return
        }
        
        self.uploadToDatabase(values: values)
        //Add question to child "Questions"
        
    }
    
    func addTrueFalseQuestionToDatabase(sQuestion: String, sAnswer: String, sCreatorId: String){
    
        var values:[String:AnyObject] = ["question": sQuestion as AnyObject, "answer": sAnswer as AnyObject, "creator" : sCreatorId as AnyObject]
        
        if(bIsInEditingMode){
            
            if(true){
                
                if(bHasImage){
                    
                    //Has changed the question picture
                    
                    print("It has image")
                    //Get name of image
                    let sImageName = UUID().uuidString
                    
                    //Get reference to storage of firebase
                    
                    let storageRef = Storage.storage().reference().child("question_images").child("\(sImageName).png")
                    
                    //Get image and jpeg represantation. If allowed, upload to storage
                    
                    if let image = questionImageView.image, let uploadData = UIImageJPEGRepresentation(image, 0.1){
                        
                        print("It could be represented as a JPEG")
                        
                        storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                            
                            if (error != nil){
                                self.handleErrorAlert(error: "Error uploading image")
                                return
                            }
                            
                            if let imageUrl = metadata?.downloadURL()?.absoluteString{
                                
                                values = ["question": sQuestion as AnyObject, "answer": sAnswer as AnyObject, "imageUrl": imageUrl as AnyObject, "creator" : sCreatorId as AnyObject]
                                
                                self.uploadToDatabase(values: values)
                                
                            }
                            
                        })
                        
                    }
                    
                    return
                    
                }
                
                //If it hasn't change the image...
                values.updateValue(Question?.sImageId as AnyObject, forKey: "imageUrl")
                bHasImage = true
            }
            
            self.uploadToDatabase(values: values)
            
            return
            
        }
        
        if(bHasImage){
            
            print("It has image")
            //Get name of image
            let sImageName = UUID().uuidString
            
            //Get reference to storage of firebase
            
            let storageRef = Storage.storage().reference().child("question_images").child("\(sImageName).png")
            
            //Get image and jpeg represantation. If allowed, upload to storage
            
            if let image = questionImageView.image, let uploadData = UIImageJPEGRepresentation(image, 0.1){
                
                print("It could be represented as a JPEG")
                
                storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                    
                    if (error != nil){
                        self.handleErrorAlert(error: "Error uploading image")
                        return
                    }
                    
                    if let imageUrl = metadata?.downloadURL()?.absoluteString{
                        
                        values = ["question": sQuestion as AnyObject, "answer": sAnswer as AnyObject, "imageUrl": imageUrl as AnyObject, "creator" : sCreatorId as AnyObject]
                        
                        self.uploadToDatabase(values: values)
                        
                    }
                    
                })
                
            }
            
            return
        }
        
        self.uploadToDatabase(values: values)

    
    }
    
    
    
    func uploadToDatabase(values: [String:AnyObject]){
    
        
        let refDatabase = Database.database().reference()
        let refQuestions = refDatabase.child("Questions")
        
        var refQuestion = refQuestions.childByAutoId()
        
        if(bIsInEditingMode && Question != nil){
        
            //If you're actually editing a question, use the same firebase reference
            refQuestion = refQuestions.child((Question?.sQuestionId)!)
        
        }
        
        refQuestion.removeValue()
        
        
        print(values)
        
        refQuestion.updateChildValues(values) { (error, ref) in
            
            if(error != nil){
                
                self.handleErrorAlert(error: "Couldn't add question. Check internet connection.")
                
            }
        }
        
        //Add question id to group id
        
        
        if let groupId = Group?.sGroupId {
            
            let refGroup = refDatabase.child("Groups").child(groupId).child("questions")
            
            refGroup.updateChildValues([refQuestion.key : 1])
            
        }
        
        groupController?.bHasAddedQuestion = true
        
        groupController?.handleChangeNewQuestionStatus()
        
        groupController?.fetchGroupQuestions()
        
        self.dismiss(animated: true, completion: nil)
    
    }
    
    
    /*
 
     MARK: Keyboard & Text Fields
 
 */
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let sValue = textField.text
        let iTag = textField.tag
        
        if let text = sValue as NSString? {
        
        
            let txtAfterUpdate = text.replacingCharacters(in: range, with: string)

            if(txtAfterUpdate.characters.count != 0){
                
                if(iTag == 1){
                    
                    ivIcon1.image = UIImage(named: "optionAIconGreen")

                    if(Int(txtAfterUpdate) != nil){
                        
                        btnRandom2.isHidden = false
                        btnRandom2.isEnabled = true
                        
                        btnRandom3.isHidden = false
                        btnRandom3.isEnabled = true
                        
                        btnRandom4.isHidden = false
                        btnRandom4.isEnabled = true
                        
                    } else {
                        
                        btnRandom2.isHidden = true
                        btnRandom2.isEnabled = false
                        
                        btnRandom3.isHidden = true
                        btnRandom3.isEnabled = false
                        
                        btnRandom4.isHidden = true
                        btnRandom4.isEnabled = false
                        
                    }
                    
                } else if(iTag == 2){
                    ivIcon2.image = UIImage(named: "optionBIconRed")

                } else if(iTag == 3){
                    ivIcon3.image = UIImage(named: "optionCIconRed")

                } else if(iTag == 4){
                    ivIcon4.image = UIImage(named: "optionDIconRed")

                }
            
            } else {
            
            
                if(iTag == 1){
                    ivIcon1.image = UIImage(named: "optionAIcon")
                } else if(iTag == 2){
                    ivIcon2.image = UIImage(named: "optionBIcon")
                }else if(iTag == 3){
                    ivIcon3.image = UIImage(named: "optionCIcon")
                }else if(iTag == 4){
                    ivIcon4.image = UIImage(named: "optionDIcon")
                }

            
            }
        }
        
        
        
        return true
    }
    
    
    func setupKeyboardObservers(){
    
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        
        textField.resignFirstResponder()
        return true
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    
    func handleKeyboardWillShow(_ notification: Notification){
    
        print("Keyboard shown")
        
        if(tfOption3.isEditing || tfOption4.isEditing){
            
            if(tfOption3.isEditing){
            
                tfOption4.isUserInteractionEnabled = false
            
            }
        
        let keyboardFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
        
        UIView.animate(withDuration: 1, animations: { 
            
            self.vOptionsContainer.frame.origin.y -= ((keyboardFrame?.height)! / 2)
            self.vTopBar.frame.origin.y -= (keyboardFrame?.height)! / 2
            self.vQuestionContainer.frame.origin.y -= ((keyboardFrame?.height)! / 2)
            
        }, completion: nil)
            
        }
    
    }
    
    func handleKeyboardWillHide(_ notification: Notification){
    
        print("Keybord hid")
        
        if(tfOption3.isEditing || tfOption4.isEditing){
            
            tfOption4.isUserInteractionEnabled = true
            
            
            let keyboardFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
            
            UIView.animate(withDuration: 1, animations: {
                
                self.vOptionsContainer.frame.origin.y += ((keyboardFrame?.height)! / 2)
                self.vTopBar.frame.origin.y += (keyboardFrame?.height)! / 2
                self.vQuestionContainer.frame.origin.y += ((keyboardFrame?.height)! / 2)
                
            }, completion: nil)
            
        }

    
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
