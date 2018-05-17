//
//  FlashViewController.swift
//  StudyGroup
//
//  Created by Hector Díaz Aceves on 04/03/18.
//  Copyright © 2018 HectorDiaz. All rights reserved.
//

import UIKit

class FlashViewController: UIViewController {
    
    /*
 
     MARK: View Variables
 
 */
    var group: GroupObject? {
    
        didSet{
        
            lGroup.text = group?.sGroupName!
        
        }
    
    
    }
    var currentQuestion = 0
    var questions: [QuestionObject] = [QuestionObject]()
    
    
    /*
 
     MARK: UI Elements
 
 
 */
    
    lazy var btnBack: UIButton = {
        
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        button.setImage(UIImage(named: "backButton"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
        
    }()
    
    let ivFlashIcon: UIImageView = {
    
        let iv = UIImageView()
        
        iv.image = UIImage(named: "flashIcon")
        iv.contentMode = .scaleAspectFit
        
        iv.translatesAutoresizingMaskIntoConstraints = false
        
        return iv;
    
    }()
    
    let lGroup: UILabel = {
        
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "Helvetica-Bold", size: 24)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    lazy var lQuestion: UILabel = {
    
        let label = UILabel()
        let tgr = UITapGestureRecognizer(target: self, action: #selector(handleShowAnswer))
        label.addGestureRecognizer(tgr)
        label.isUserInteractionEnabled = true
        label.text = "Question"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont(name: "Helvetica", size: 50)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    
    
    }()
    
    lazy var ivQuestion: UIImageView = {
        
        let iv = UIImageView()
        let tgr = UITapGestureRecognizer(target: self, action: #selector(handleShowAnswer))
        iv.addGestureRecognizer(tgr)
        iv.isUserInteractionEnabled = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv;
        
    }()
    
    let lSubQuestion: UILabel = {
        
        let label = UILabel()
        label.text = "Question"
        label.textAlignment = .center
        label.font = UIFont(name: "Helvetica", size: 24)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
        
    }()

    lazy var lAnswer: UILabel = {
        
        let label = UILabel()
        let tgr = UITapGestureRecognizer(target: self, action: #selector(handleShowQuestion))
        label.addGestureRecognizer(tgr)
        label.isUserInteractionEnabled = true
        label.text = "Answer"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont(name: "Helvetica-Bold", size: 50)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
        
    }()
    
    let btnNext: UIButton = {
    
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        button.setTitle("Next", for: .normal)
        button.tintColor = .black
        button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 20)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    
    }()
    
    let btnPrevious: UIButton = {
    
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(handlePrevious), for: .touchUpInside)
        button.setTitle("Previous", for: .normal)
        button.tintColor = .black
        button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 20)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button

    }()
    
    
    
    /*
 
     MARK: UI Containers
 
     */
    
    let vTopBar: UIView = {
    
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    let vQuestionAnswer: UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    let vButtonNext: UIView = {
    
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view

    }()
    
    
    /*
 
     MARK: Button functions
 
 */
    
    func handleBack(){
    
        self.dismiss(animated: true, completion: nil)
    
    }
    
    func handleNext(){
        
        if(currentQuestion < questions.count-1){
        
            currentQuestion += 1

            setupFlashcard()
        } else {
        
            //To be modified
            
            self.dismiss(animated: true, completion: nil)
        
        }
        
        
    }
    
    func handlePrevious(){
    
        
        if(currentQuestion != 0){
        
            currentQuestion -= 1
            setupFlashcard()
        
        }
        
    
    }
    
    func handleShowAnswer(){
    
        lAnswer.isHidden = false
        lQuestion.isHidden = true
        lSubQuestion.isHidden = true
        ivQuestion.isHidden = true
    
    }
    
    func handleShowQuestion(){
       
        lAnswer.isHidden = true
        
        if(questions[currentQuestion].sImageId != nil){
        
            ivQuestion.isHidden = false
            lSubQuestion.isHidden = false
        
        } else {
            
            lQuestion.isHidden = false
        
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        lAnswer.isHidden = true
        
        //Add UI elements to containers
        
        vTopBar.addSubview(btnBack)
        vTopBar.addSubview(ivFlashIcon)
        vTopBar.addSubview(lGroup)
        
        vQuestionAnswer.addSubview(lQuestion)
        vQuestionAnswer.addSubview(ivQuestion)
        vQuestionAnswer.addSubview(lSubQuestion)
        vQuestionAnswer.addSubview(lAnswer)
        
        vButtonNext.addSubview(btnPrevious)
        vButtonNext.addSubview(btnNext)
        
        //Add containers to view
        
        view.addSubview(vTopBar)
        view.addSubview(vQuestionAnswer)
        view.addSubview(vButtonNext)
        
        //Define positions and sizes
        
        setupComponents()
        
        //Put question info in flashcard
        
        setupFlashcard()

        // Do any additional setup after loading the view.
    }
    
    func setupComponents(){
        
        //Containers
    
        vTopBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        vTopBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        vTopBar.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        vTopBar.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        vButtonNext.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        vButtonNext.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        vButtonNext.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        vButtonNext.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/10).isActive = true
        
        vQuestionAnswer.topAnchor.constraint(equalTo: vTopBar.bottomAnchor, constant: 10).isActive = true
        vQuestionAnswer.bottomAnchor.constraint(equalTo: vButtonNext.topAnchor, constant: -10).isActive = true
        vQuestionAnswer.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        vQuestionAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        //Elements of container
        
                /*Top Bar*/
        btnBack.leftAnchor.constraint(equalTo: vTopBar.leftAnchor, constant: 20).isActive = true
        btnBack.centerYAnchor.constraint(equalTo: vTopBar.centerYAnchor).isActive = true
        btnBack.widthAnchor.constraint(equalToConstant: 30).isActive = true
        btnBack.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        ivFlashIcon.leftAnchor.constraint(equalTo: btnBack.rightAnchor, constant: 40).isActive = true
        ivFlashIcon.widthAnchor.constraint(equalToConstant: 50).isActive = true
        ivFlashIcon.heightAnchor.constraint(equalTo: btnBack.heightAnchor).isActive = true
        ivFlashIcon.centerYAnchor.constraint(equalTo: vTopBar.centerYAnchor).isActive = true
        
        lGroup.leftAnchor.constraint(equalTo: ivFlashIcon.rightAnchor, constant: 30).isActive = true
        lGroup.centerYAnchor.constraint(equalTo: vTopBar.centerYAnchor).isActive = true
        lGroup.heightAnchor.constraint(equalTo: vTopBar.heightAnchor, multiplier: 9/10).isActive = true
        lGroup.rightAnchor.constraint(equalTo: vTopBar.rightAnchor, constant: -20).isActive = true
        /*Question and Answer*/

        lQuestion.widthAnchor.constraint(equalTo: vQuestionAnswer.widthAnchor, constant: -50).isActive = true
        lQuestion.heightAnchor.constraint(equalTo: vQuestionAnswer.heightAnchor, multiplier: 1/2).isActive = true
        lQuestion.centerYAnchor.constraint(equalTo: vQuestionAnswer.centerYAnchor).isActive = true
        lQuestion.centerXAnchor.constraint(equalTo: vQuestionAnswer.centerXAnchor).isActive = true
        
        lAnswer.widthAnchor.constraint(equalTo: vQuestionAnswer.widthAnchor, constant: -50).isActive = true
        lAnswer.heightAnchor.constraint(equalTo: vQuestionAnswer.heightAnchor, multiplier: 1/2).isActive = true
        lAnswer.centerYAnchor.constraint(equalTo: vQuestionAnswer.centerYAnchor).isActive = true
        lAnswer.centerXAnchor.constraint(equalTo: vQuestionAnswer.centerXAnchor).isActive = true
        
        ivQuestion.widthAnchor.constraint(equalTo: vQuestionAnswer.widthAnchor, constant: -50).isActive = true
        ivQuestion.heightAnchor.constraint(equalTo: vQuestionAnswer.heightAnchor, multiplier: 1/2).isActive = true
        ivQuestion.centerYAnchor.constraint(equalTo: vQuestionAnswer.centerYAnchor).isActive = true
        ivQuestion.centerXAnchor.constraint(equalTo: vQuestionAnswer.centerXAnchor).isActive = true
        
        lSubQuestion.topAnchor.constraint(equalTo: ivQuestion.bottomAnchor, constant: 30).isActive = true
        lSubQuestion.centerXAnchor.constraint(equalTo: vQuestionAnswer.centerXAnchor).isActive = true
        lSubQuestion.heightAnchor.constraint(equalToConstant: 50).isActive = true
        lSubQuestion.widthAnchor.constraint(equalTo: vQuestionAnswer.widthAnchor, multiplier: 4/5).isActive = true
        
                /*Next*/
        
        btnNext.centerXAnchor.constraint(equalTo: vButtonNext.centerXAnchor, constant: 100).isActive = true
        btnNext.centerYAnchor.constraint(equalTo: vButtonNext.centerYAnchor).isActive = true
        btnNext.heightAnchor.constraint(equalTo: vButtonNext.heightAnchor, multiplier: 9/10).isActive = true
        btnNext.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        /*Previous*/
        
        btnPrevious.centerXAnchor.constraint(equalTo: vButtonNext.centerXAnchor, constant: -100).isActive = true
        btnPrevious.centerYAnchor.constraint(equalTo: vButtonNext.centerYAnchor).isActive = true
        btnPrevious.heightAnchor.constraint(equalTo: vButtonNext.heightAnchor, multiplier: 9/10).isActive = true
        btnPrevious.widthAnchor.constraint(equalToConstant: 100).isActive = true

    }
    
    func setupFlashcard(){
    
        let question = questions[currentQuestion]
        
        //if it doesn't have an image
        
        if(question.sImageId == nil){
        
            lQuestion.text = question.sQuestionText!
            lQuestion.isHidden = false
            ivQuestion.isHidden = true
            lSubQuestion.isHidden = true
            
            
        } else {
        
            let imageView = UIImageView()
            imageView.loadImageUsingCacheWithUrlString(urlString: question.sImageId!)
            ivQuestion.image = imageView.image
            lSubQuestion.text = question.sQuestionText!
            
            lQuestion.isHidden = true
            ivQuestion.isHidden = false
            lSubQuestion.isHidden = false
            
        }
        
        lAnswer.isHidden = true
        
        lAnswer.text = question.sAnswer
        
    
    
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
