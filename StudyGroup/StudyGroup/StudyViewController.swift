//
//  QuestionsViewController.swift
//  StudyGroup
//
//  Created by Hector Díaz Aceves on 25/11/17.
//  Copyright © 2017 HectorDiaz. All rights reserved.
//

import UIKit
import Canvas
import AVFoundation

class StudyViewController: UIViewController {

    var audioPlayer: AVAudioPlayer!
    
    var Group: GroupObject? {
    
        didSet {
        
            lGroup.text = Group?.sGroupName
        
        }
    
    
    }
    
    var numberOfQuestionsAnswered: Int = Int()
    
    var numberOfCorrectAnswers: Int = Int()
    
    var questionOrder: [Int] = [Int]()
    
    var trueFalseQuestion:[Bool] = [Bool]()
    
    var answerOrder: [Int] = [Int]()
    
    var bCorrectAnswer: Bool = false
    
    
    /*
     MARK: UIElements
 */
    
    var qArrQuestions = [QuestionObject]()
    var iCurrentQuestion = 1
    
    lazy var btnBack: UIButton = {
    
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        button.setImage(UIImage(named: "backButton"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    
    
    }()
    
    let lGroup: UILabel = {
    
        let label = UILabel()
        label.text = "Mathematics II"
        label.textAlignment = .center
        label.font = UIFont(name: "Helvetica-Bold", size: 24)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    
    }()
    
    
    /*
 
     Question
 
 */
    
    //Question
    
    let lSingleQuestion: UILabel = {
        
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-Bold", size: 70)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
        
    }()
    
    lazy var ivQuestion: UIImageView = {
        
        let iv = UIImageView()
        iv.image = UIImage(named: "questionImage")
        let gr = UITapGestureRecognizer(target: self, action: #selector(handleEnlargeImage))
        iv.addGestureRecognizer(gr)
        iv.isUserInteractionEnabled = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
        
    }()
    
    let lSubQuestion: UILabel = {
        
        let label = UILabel()
        label.text = "Sub question"
        label.font = UIFont(name: "Helvetica-Bold", size: 18)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    //Options
    //A
    lazy var vOptionAContainer: UIView = {
        
        let view = UIView()
        let gr = UITapGestureRecognizer(target: self, action: #selector(StudyViewController.handleOptionA))
        view.addGestureRecognizer(gr)
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.layer.borderWidth = 4
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.layer.borderColor = UIColor.black.cgColor
        return view
        
    }()
    
    lazy var ivIconA: UIImageView = {
        
        let iv = UIImageView()
        let gr = UITapGestureRecognizer(target: self, action: #selector(StudyViewController.handleOptionA))
        iv.addGestureRecognizer(gr)
        iv.isUserInteractionEnabled = true
        iv.image = UIImage(named: "optionAIcon")
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
        
    }()
    
    lazy var lOptionA: UILabel = {
        
        let label = UILabel()
        let gr = UITapGestureRecognizer(target: self, action: #selector(StudyViewController.handleOptionA))
        label.addGestureRecognizer(gr)
        label.isUserInteractionEnabled = true
        label.text = "34.8"
        label.numberOfLines = 0
        label.font = UIFont(name: "Helvetica", size: 18)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
        
    }()
    
    //B
    lazy var vOptionBContainer: UIView = {
        
        let view = UIView()
        let gr = UITapGestureRecognizer(target: self, action: #selector(StudyViewController.handleOptionB))
        view.addGestureRecognizer(gr)
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.layer.borderWidth = 4
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.layer.borderColor = UIColor.black.cgColor
        return view
        
    }()
    
    lazy var ivIconB: UIImageView = {
        
        let iv = UIImageView()
        let gr = UITapGestureRecognizer(target: self, action: #selector(StudyViewController.handleOptionB))
        iv.addGestureRecognizer(gr)
        iv.isUserInteractionEnabled = true
        iv.image = UIImage(named: "optionBIcon")
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
        
    }()
    
    lazy var lOptionB: UILabel = {
        
        let label = UILabel()
        let gr = UITapGestureRecognizer(target: self, action: #selector(StudyViewController.handleOptionB))
        label.addGestureRecognizer(gr)
        label.isUserInteractionEnabled = true
        label.text = "34.8"
        label.numberOfLines = 0
        label.font = UIFont(name: "Helvetica", size: 18)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
        
    }()
    
    //C
    
    lazy var vOptionCContainer: UIView = {
        
        let view = UIView()
        let gr = UITapGestureRecognizer(target: self, action: #selector(StudyViewController.handleOptionC))
        view.addGestureRecognizer(gr)
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.layer.borderWidth = 4
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.layer.borderColor = UIColor.black.cgColor
        return view
        
    }()
    
    lazy var ivIconC: UIImageView = {
        
        let iv = UIImageView()
        let gr = UITapGestureRecognizer(target: self, action: #selector(StudyViewController.handleOptionC))
        iv.addGestureRecognizer(gr)
        iv.isUserInteractionEnabled = true
        iv.image = UIImage(named: "optionCIcon")
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
        
    }()
    
    lazy var lOptionC: UILabel = {
        
        let label = UILabel()
        let gr = UITapGestureRecognizer(target: self, action: #selector(StudyViewController.handleOptionC))
        label.addGestureRecognizer(gr)
        label.isUserInteractionEnabled = true
        label.text = "34.8"
        label.numberOfLines = 0
        label.font = UIFont(name: "Helvetica", size: 18)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
        
    }()
    
    //D
    
    lazy var vOptionDContainer: UIView = {
        
        let view = UIView()
        let gr = UITapGestureRecognizer(target: self, action: #selector(StudyViewController.handleOptionD))
        view.addGestureRecognizer(gr)
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.layer.borderWidth = 4
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.layer.borderColor = UIColor.black.cgColor
        return view
        
    }()
    
    lazy var ivIconD: UIImageView = {
        
        let iv = UIImageView()
        let gr = UITapGestureRecognizer(target: self, action: #selector(StudyViewController.handleOptionD))
        iv.addGestureRecognizer(gr)
        iv.isUserInteractionEnabled = true
        iv.image = UIImage(named: "optionDIcon")
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
        
    }()
    
    lazy var lOptionD: UILabel = {
        
        let label = UILabel()
        let gr = UITapGestureRecognizer(target: self, action: #selector(StudyViewController.handleOptionD))
        label.addGestureRecognizer(gr)
        label.isUserInteractionEnabled = true
        label.text = "34.8"
        label.numberOfLines = 0
        label.font = UIFont(name: "Helvetica", size: 18)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
        
    }()
    
    //True False Buttons
    
    lazy var btnTrue: UIButton = {
    
        let button = UIButton(type: .system)
        button.setTitle("True", for: .normal)
        button.layer.borderWidth = 4
        button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 24)
        button.tintColor = .black
        button.backgroundColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        button.addTarget(self, action: #selector(handleTrue), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    
    }()
    
    lazy var btnFalse: UIButton = {
        
        let button = UIButton(type: .system)
        button.setTitle("False", for: .normal)
        button.layer.borderWidth = 4
        button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 24)
        button.tintColor = .black
        button.backgroundColor = UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 1)
        button.addTarget(self, action: #selector(handleFalse), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    
    lazy var btnPass: UIButton = {
    
        let button = UIButton(type: .system)
        button.setTitle("Pass", for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 24)
        button.tintColor = .black
        button.addTarget(self, action: #selector(handlePass), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    
    }()
    
    /*
 
     MARK: UI containers
 
 */
    
    let animationView: CSAnimationView = {
    
        let av = CSAnimationView()
        av.translatesAutoresizingMaskIntoConstraints = false
        return av
    
    }()
    
    let vQuestionContainer: UIView = {
    
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    
    }()
    
    let vTopContainer: UIView = {
    
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    /*
 
     MARK: Button functions
 
 */
    
    var startingFrame: CGRect?
    var blackView: UIView?
    var startingImageView: UIImageView?
    
    func handleEnlargeImage() {
    
        self.startingImageView = ivQuestion
        
        self.startingImageView?.alpha = 0
        
        self.startingFrame = ivQuestion.superview?.convert(ivQuestion.frame, to: nil)
        
        let zoomingImageView = UIImageView(frame: startingFrame!)
        
        zoomingImageView.image = ivQuestion.image
        zoomingImageView.isUserInteractionEnabled = true
        
        zoomingImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleZoomBack)))
        
        
        if let keyWindow = UIApplication.shared.keyWindow {
        
            blackView = UIView(frame: keyWindow.frame)
            blackView?.backgroundColor = UIColor.black
            blackView?.alpha = 0
            
            keyWindow.addSubview(blackView!)
            
            keyWindow.addSubview(zoomingImageView)
         
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { 
                
                self.blackView?.alpha = 1;
                
                let height = self.startingFrame!.height / self.startingFrame!.width * keyWindow.frame.width
                
                zoomingImageView.frame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
                
                zoomingImageView.center = keyWindow.center
                
            }, completion: { (completed) in
                
                
                
            })
        
        }
        
    
    }
    
    func handleZoomBack(_ tapGesture: UITapGestureRecognizer){
    
        if let zoomOutImageview = tapGesture.view{
        
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { 
                
                zoomOutImageview.frame = self.startingFrame!
                
                self.blackView?.alpha = 0
                
                
                
            }, completion: { (completed) in
                
                zoomOutImageview.removeFromSuperview()
                self.startingImageView?.isHidden = false
                self.startingImageView?.alpha = 1
                
            })
            
            
        
        }
        
    
    
    }
    
    func handlePlayCorrectSound(){
        
        audioPlayer.play()
        
    }
    
    func handleOptionA(sender: UITapGestureRecognizer){
        
        numberOfQuestionsAnswered += 1
        
        vOptionAContainer.isUserInteractionEnabled = false
        ivIconA.isUserInteractionEnabled = false
        lOptionA.isUserInteractionEnabled = false

        
        if(answerOrder[iCurrentQuestion-1] == 0){
            
            vOptionAContainer.layer.borderColor = UIColor.green.cgColor
            
            numberOfCorrectAnswers += 1
            
            handlePlayCorrectSound()
            
            bCorrectAnswer = true;

            
        } else {
            
            vOptionAContainer.layer.borderColor = UIColor.red.cgColor
            
            bCorrectAnswer = false;
            
        }
        
        let delay = DispatchTime.now() + 0.5
        
        DispatchQueue.main.asyncAfter(deadline: delay, execute: {
            
            self.handleDisplayStatus()
            
        })
    
    }
    
    func handleOptionB(sender: UITapGestureRecognizer){
        
        numberOfQuestionsAnswered += 1
        
        vOptionBContainer.isUserInteractionEnabled = false
        ivIconB.isUserInteractionEnabled = false
        lOptionB.isUserInteractionEnabled = false
        
        if(answerOrder[iCurrentQuestion-1] == 1){
            
            vOptionBContainer.layer.borderColor = UIColor.green.cgColor
            
            numberOfCorrectAnswers += 1
            
            handlePlayCorrectSound()
            
            bCorrectAnswer = true
            
        } else {
            vOptionBContainer.layer.borderColor = UIColor.red.cgColor
            bCorrectAnswer = false
        }
        
        let delay = DispatchTime.now() + 0.5
        
        DispatchQueue.main.asyncAfter(deadline: delay, execute: {
            
            self.handleDisplayStatus()
            
        })
        
    }
    
    func handleOptionC(sender: UITapGestureRecognizer){
        
        numberOfQuestionsAnswered += 1
        
        vOptionCContainer.isUserInteractionEnabled = false
        ivIconC.isUserInteractionEnabled = false
        lOptionC.isUserInteractionEnabled = false
        
        if(answerOrder[iCurrentQuestion-1] == 2){
            
            vOptionCContainer.layer.borderColor = UIColor.green.cgColor
            
            numberOfCorrectAnswers += 1
            
            handlePlayCorrectSound()
            
            bCorrectAnswer = true

            
        } else {
            
            vOptionCContainer.layer.borderColor = UIColor.red.cgColor
            
            bCorrectAnswer = false
        }
        
        let delay = DispatchTime.now() + 0.5
        
        DispatchQueue.main.asyncAfter(deadline: delay, execute: {
            
            self.handleDisplayStatus()
            
        })

    }
    
    func handleOptionD(sender: UITapGestureRecognizer){
        
        numberOfQuestionsAnswered += 1
        
        vOptionDContainer.isUserInteractionEnabled = false
        ivIconD.isUserInteractionEnabled = false
        lOptionD.isUserInteractionEnabled = false
        
        if(answerOrder[iCurrentQuestion-1] == 3){
            
            vOptionDContainer.layer.borderColor = UIColor.green.cgColor
            
            numberOfCorrectAnswers += 1
            
            handlePlayCorrectSound()
            
            bCorrectAnswer = true
            
        } else {
            
            vOptionDContainer.layer.borderColor = UIColor.red.cgColor
            
            bCorrectAnswer = false
        }
        
        let delay = DispatchTime.now() + 0.5
        
        DispatchQueue.main.asyncAfter(deadline: delay, execute: {
            
            self.handleDisplayStatus()
            
        })
    
    }
    
    
    func handleTrue(){
    
        numberOfQuestionsAnswered += 1
        btnTrue.isEnabled = false
        
        if(answerOrder[questionOrder[iCurrentQuestion-1]] == 1){
            
            
            btnTrue.layer.borderColor = UIColor.green.cgColor
            
            numberOfCorrectAnswers += 1
            
            handlePlayCorrectSound()
            
            bCorrectAnswer = true
            
        } else {
            
            btnTrue.layer.borderColor = UIColor.red.cgColor
            
            bCorrectAnswer = false
        }
        
        let delay = DispatchTime.now() + 0.5
        
        DispatchQueue.main.asyncAfter(deadline: delay, execute: {
            
            self.handleDisplayStatus()
            
        })
        
    
    
    }
    
    
    func handleFalse(){
    
        numberOfQuestionsAnswered += 1
        btnFalse.isEnabled = false
        
        if(answerOrder[questionOrder[iCurrentQuestion-1]] == 0){
            
            
            btnFalse.layer.borderColor = UIColor.green.cgColor

            numberOfCorrectAnswers += 1
            
            handlePlayCorrectSound()
            
            bCorrectAnswer = true
            
        } else {
            
            btnFalse.layer.borderColor = UIColor.red.cgColor
            
            bCorrectAnswer = false
        }
        
        let delay = DispatchTime.now() + 0.5
        
        DispatchQueue.main.asyncAfter(deadline: delay, execute: {
            
            self.handleDisplayStatus()
            
        })
        
    
    
    }
    
    var vStatus: StatusView?
    
    func handleDisplayStatus(){
        
        if let keyWindow = UIApplication.shared.keyWindow {
        
            blackView = UIView(frame: keyWindow.frame)
            blackView?.backgroundColor = UIColor.black
            blackView?.alpha = 0;
            
            vStatus = StatusView(frame: CGRect(x: keyWindow.frame.midX + keyWindow.frame.width, y: keyWindow.frame.midY, width: keyWindow.frame.width * (4/5), height: keyWindow.frame.height / 3))
            
            vStatus?.iTotalQuestions = numberOfQuestionsAnswered
            vStatus?.iCorrectAnswers = numberOfCorrectAnswers
            vStatus?.bChoseCorrectAnswer = bCorrectAnswer
            
            vStatus?.btnKeepGoing.addTarget(self, action: #selector(handleHideStatus), for: .touchUpInside)
            
            keyWindow.addSubview(blackView!)
            
            keyWindow.addSubview(vStatus!)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                
                self.blackView?.alpha = 0.5
                
                self.vStatus?.frame = CGRect(x: keyWindow.frame.midX, y: keyWindow.frame.midY, width: keyWindow.frame.width * (4/5), height: keyWindow.frame.height / 3)
                
                self.vStatus?.center = keyWindow.center
                
                //self.vStatus.frame.origin.x -= self.view.frame.width
                
                //self.tryChangingStatusText();
                
            }) { (completed) in
                
                
            }
            
        
        }
    
    
    }
    
    
    func handleHideStatus(){
    
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            
            self.blackView?.alpha = 0
            
            self.vStatus?.frame = CGRect(x: self.view.frame.midX + self.view.frame.width, y: self.view.frame.midY, width: self.view.frame.width * (4/5), height: self.view.frame.height / 3)
            
            
        }) { (completed) in
            
            
        }
        
        handlePass()
    
    
    }
    
    func disableUserInteraction(){
    
        vOptionAContainer.isUserInteractionEnabled = false
        ivIconA.isUserInteractionEnabled = false
        lOptionA.isUserInteractionEnabled = false
        
        vOptionBContainer.isUserInteractionEnabled = false
        ivIconB.isUserInteractionEnabled = false
        lOptionB.isUserInteractionEnabled = false
        
        vOptionCContainer.isUserInteractionEnabled = false
        ivIconC.isUserInteractionEnabled = false
        lOptionC.isUserInteractionEnabled = false
        
        vOptionDContainer.isUserInteractionEnabled = false
        ivIconD.isUserInteractionEnabled = false
        lOptionD.isUserInteractionEnabled = false
        
        btnTrue.isEnabled = false
        btnFalse.isEnabled = false
    
    
    }
    
    func enableUserInteractions(){
    
        vOptionAContainer.isUserInteractionEnabled = true
        ivIconA.isUserInteractionEnabled = true
        lOptionA.isUserInteractionEnabled = true
        
        vOptionBContainer.isUserInteractionEnabled = true
        ivIconB.isUserInteractionEnabled = true
        lOptionB.isUserInteractionEnabled = true
        
        vOptionCContainer.isUserInteractionEnabled = true
        ivIconC.isUserInteractionEnabled = true
        lOptionC.isUserInteractionEnabled = true
        
        vOptionDContainer.isUserInteractionEnabled = true
        ivIconD.isUserInteractionEnabled = true
        lOptionD.isUserInteractionEnabled = true
        
        btnTrue.isEnabled = true
        btnFalse.isEnabled = true
    
    }
    
    func handlePass(){
        
        enableUserInteractions()
        
        vOptionAContainer.layer.borderColor = UIColor.black.cgColor
        vOptionBContainer.layer.borderColor = UIColor.black.cgColor
        vOptionCContainer.layer.borderColor = UIColor.black.cgColor
        vOptionDContainer.layer.borderColor = UIColor.black.cgColor
        
        
        btnTrue.layer.borderColor = UIColor.black.cgColor
        btnFalse.layer.borderColor = UIColor.black.cgColor

        
        print("Current Question: \(iCurrentQuestion), Question Count: \(qArrQuestions.count)")
        
        if(iCurrentQuestion < qArrQuestions.count){
        
            print("Animate alpha")
            UIView.animate(withDuration: 0.5, animations: {
                
                self.vQuestionContainer.alpha = 0
                
                
            })
            
            
            iCurrentQuestion += 1;
            
            setupQuestionInfo();
            
            UIView.animate(withDuration: 0.5, animations: {
                
                self.vQuestionContainer.alpha = 1
                
            })
            
            
        
        } else {
        
            self.dismiss(animated: true, completion: nil)
        
        }
        
    
    }
    
    func handleBack(){
    
        self.dismiss(animated: true, completion: nil)
    
    }
    
/*
 
     MARK: View setup
 
 
 */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do{
            
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "correctAnswer", ofType: "mp3")!))
            
            audioPlayer.prepareToPlay()
            
        } catch{
            
            print(error)
            
        }

        
        
        view.backgroundColor = .white
        //Add UI elements to containers
        
        vTopContainer.addSubview(btnBack)
        
        vOptionAContainer.addSubview(ivIconA)
        vOptionAContainer.addSubview(lOptionA)
        
        vOptionBContainer.addSubview(ivIconB)
        vOptionBContainer.addSubview(lOptionB)
        
        vOptionCContainer.addSubview(ivIconC)
        vOptionCContainer.addSubview(lOptionC)
        
        vOptionDContainer.addSubview(ivIconD)
        vOptionDContainer.addSubview(lOptionD)
        
        setupQuestionInfo()
        setupQuestionContainer()
        
        
        vTopContainer.addSubview(lGroup)
        
        //Add UI elements to view

        view.addSubview(vTopContainer)
        view.addSubview(vQuestionContainer)
        view.addSubview(btnPass)
        
        //Setup positions and dimensions
        
        //Add Status View


        
        setupComponents()

        
        // Do any additional setup after loading the view.
    }
    
    
    /*
 
     MARK: Setup Functions
 
 
 */
    
    func setupQuestionInfo(){
        
        print("Setup question Info")
        
        let questionNumber = questionOrder[iCurrentQuestion-1]
        
        
        let question = qArrQuestions[questionNumber]
        
        
        if(question.sImageId != nil){
            
            //Get image
            
            let imageView = UIImageView()
            
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            imageView.contentMode = .scaleAspectFill
            
            if let imageUrl = question.sImageId{
                
                print("Getting image to imageview")
                imageView.loadImageUsingCacheWithUrlString(urlString: imageUrl)
                
                self.ivQuestion.image = imageView.image

            
            }
            
            lSingleQuestion.isHidden = true
            ivQuestion.isHidden = false
            lSubQuestion.isHidden = false
            
            lSubQuestion.text = question.sQuestionText

            
            //Set sub question
        
            
        } else {
            
            print("Setting text to question")

            lSingleQuestion.text = question.sQuestionText
        
            lSingleQuestion.isHidden = false
            ivQuestion.isHidden = true
            lSubQuestion.isHidden = true
            
        }
        //Randomize options
        
        print("True false questiona array")
        
        print(trueFalseQuestion)
        
        if(!trueFalseQuestion[questionNumber]){
            
            btnTrue.isHidden = true
            btnFalse.isHidden = true
            
            vOptionAContainer.isHidden = false
            vOptionBContainer.isHidden = false
            vOptionCContainer.isHidden = false
            vOptionDContainer.isHidden = false
        
            randomizeQuestionOrder(answerIndex: answerOrder[iCurrentQuestion-1])
        
        } else {
        
            btnTrue.isHidden = false
            btnFalse.isHidden = false
            
            vOptionAContainer.isHidden = true
            vOptionBContainer.isHidden = true
            vOptionCContainer.isHidden = true
            vOptionDContainer.isHidden = true
        
        }
    
    
    }
    
    func randomizeQuestionOrder(answerIndex : Int){
    
        //0 = Answer, 1 = Option 1, 2 = Option 2, 3 = Option 3
        let questionNumber = questionOrder[iCurrentQuestion-1]
        let question = qArrQuestions[questionNumber]
        
        var iArray : [Int] = [Int]()
        
        for i in 0 ... 3{
        
            iArray.append(-1)
        
        }
        
        print(iArray)
        
        for i in 0...3{
        
            if(i != answerIndex){
            
                var iValue = Int(arc4random_uniform(3)+1)
                
                var iCountLoop = 0;
                
                while(iArray.contains(iValue) && iCountLoop < 40){
                
                    print("While loop of randomizer ")
                    print(iValue)
                    iValue = Int(arc4random_uniform(3)+1)
                    iCountLoop += 1

                }
                
                iArray[i] = iValue
            } else {
                iArray[i] = 0
            
            }
            
        }
        
        
        var options: [String] = [String]()
        
        for i in 0...3{
        
            var sText : String = String()
            
            switch iArray[i] {
            case 0:
                sText = question.sAnswer!
                break
            case 1:
                sText = question.sOption1!
                break
            case 2:
                sText = question.sOption2!
                break
            case 3:
                sText = question.sOption3!
                break
            default:
                sText = "undefined"
            }
            
            options.append(sText)
            
        
        }
        
        lOptionA.text = options[0]
        
        lOptionB.text = options[1]
        
        lOptionC.text = options[2]
        
        lOptionD.text = options[3]
    }
    
    func setupQuestionContainer(){
        
            let questionNumber = questionOrder[iCurrentQuestion-1]
        
            let question = qArrQuestions[questionNumber]
        
            vQuestionContainer.addSubview(ivQuestion)
            vQuestionContainer.addSubview(lSubQuestion)
            
            //Add constraints
            
            ivQuestion.topAnchor.constraint(equalTo: vQuestionContainer.topAnchor, constant: 10).isActive = true
            ivQuestion.centerXAnchor.constraint(equalTo: vQuestionContainer.centerXAnchor).isActive = true
            ivQuestion.widthAnchor.constraint(equalTo: vQuestionContainer.widthAnchor, constant: 9/10).isActive = true
            ivQuestion.heightAnchor.constraint(equalTo: vQuestionContainer.heightAnchor, multiplier: 3/7).isActive = true
            
            lSubQuestion.topAnchor.constraint(equalTo: ivQuestion.bottomAnchor, constant: 10).isActive = true
            lSubQuestion.centerXAnchor.constraint(equalTo: vQuestionContainer.centerXAnchor).isActive = true
            lSubQuestion.heightAnchor.constraint(equalToConstant: 50).isActive = true
            lSubQuestion.widthAnchor.constraint(equalTo: vQuestionContainer.widthAnchor, multiplier: 1/2).isActive = true

            vQuestionContainer.addSubview(lSingleQuestion)
            
            //Add constraints
            
            lSingleQuestion.topAnchor.constraint(equalTo: vQuestionContainer.topAnchor, constant: 10).isActive = true
            lSingleQuestion.centerXAnchor.constraint(equalTo: vQuestionContainer.centerXAnchor).isActive = true
            lSingleQuestion.widthAnchor.constraint(equalToConstant: 300).isActive = true
            lSingleQuestion.heightAnchor.constraint(equalTo: vQuestionContainer.heightAnchor, multiplier: 1/3).isActive = true
            

        
        //Add options
        
        vQuestionContainer.addSubview(vOptionAContainer)
        vQuestionContainer.addSubview(vOptionBContainer)
        vQuestionContainer.addSubview(vOptionCContainer)
        vQuestionContainer.addSubview(vOptionDContainer)
        
        //Add constraints
        
        //Option Containers
        vOptionCContainer.bottomAnchor.constraint(equalTo: vQuestionContainer.bottomAnchor, constant: -10).isActive = true
        vOptionCContainer.leftAnchor.constraint(equalTo: vQuestionContainer.leftAnchor, constant: 10).isActive = true
        vOptionCContainer.widthAnchor.constraint(equalTo: vQuestionContainer.widthAnchor, multiplier: 2/5).isActive = true
        vOptionCContainer.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        vOptionDContainer.bottomAnchor.constraint(equalTo: vQuestionContainer.bottomAnchor, constant: -10).isActive = true
        vOptionDContainer.rightAnchor.constraint(equalTo: vQuestionContainer.rightAnchor, constant: -10).isActive = true
        vOptionDContainer.widthAnchor.constraint(equalTo: vQuestionContainer.widthAnchor, multiplier: 2/5).isActive = true
        vOptionDContainer.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        vOptionAContainer.bottomAnchor.constraint(equalTo: vOptionCContainer.topAnchor, constant: -30).isActive = true
        vOptionAContainer.widthAnchor.constraint(equalTo: vOptionCContainer.widthAnchor).isActive = true
        vOptionAContainer.heightAnchor.constraint(equalTo: vOptionCContainer.heightAnchor).isActive = true
        vOptionAContainer.leftAnchor.constraint(equalTo: vOptionCContainer.leftAnchor).isActive = true
        
        vOptionBContainer.bottomAnchor.constraint(equalTo: vOptionDContainer.topAnchor, constant: -30).isActive = true
        vOptionBContainer.widthAnchor.constraint(equalTo: vOptionDContainer.widthAnchor).isActive = true
        vOptionBContainer.heightAnchor.constraint(equalTo: vOptionDContainer.heightAnchor).isActive = true
        vOptionBContainer.rightAnchor.constraint(equalTo: vOptionDContainer.rightAnchor).isActive = true
        
        //Option icons and labels
        
        //a
        ivIconA.centerYAnchor.constraint(equalTo: vOptionAContainer.centerYAnchor).isActive = true
        ivIconA.leftAnchor.constraint(equalTo: vOptionAContainer.leftAnchor, constant: 10).isActive = true
        ivIconA.heightAnchor.constraint(equalToConstant: 45).isActive = true
        ivIconA.widthAnchor.constraint(equalToConstant: 45).isActive = true
        
        lOptionA.leftAnchor.constraint(equalTo: ivIconA.rightAnchor, constant: 10).isActive = true
        lOptionA.rightAnchor.constraint(equalTo: vOptionAContainer.rightAnchor, constant: -10).isActive = true
        lOptionA.centerYAnchor.constraint(equalTo: vOptionAContainer.centerYAnchor).isActive = true
        lOptionA.heightAnchor.constraint(equalTo: vOptionAContainer.heightAnchor, multiplier: 9/10).isActive = true
        //b
        ivIconB.centerYAnchor.constraint(equalTo: vOptionBContainer.centerYAnchor).isActive = true
        ivIconB.leftAnchor.constraint(equalTo: vOptionBContainer.leftAnchor, constant: 10).isActive = true
        ivIconB.heightAnchor.constraint(equalToConstant: 45).isActive = true
        ivIconB.widthAnchor.constraint(equalToConstant: 45).isActive = true
        
        lOptionB.leftAnchor.constraint(equalTo: ivIconB.rightAnchor, constant: 10).isActive = true
        lOptionB.rightAnchor.constraint(equalTo: vOptionBContainer.rightAnchor, constant: -10).isActive = true
        lOptionB.centerYAnchor.constraint(equalTo: vOptionBContainer.centerYAnchor).isActive = true
        lOptionB.heightAnchor.constraint(equalTo: vOptionBContainer.heightAnchor, multiplier: 9/10).isActive = true
        //c
        ivIconC.centerYAnchor.constraint(equalTo: vOptionCContainer.centerYAnchor).isActive = true
        ivIconC.leftAnchor.constraint(equalTo: vOptionCContainer.leftAnchor, constant: 10).isActive = true
        ivIconC.heightAnchor.constraint(equalToConstant: 45).isActive = true
        ivIconC.widthAnchor.constraint(equalToConstant: 45).isActive = true
        
        lOptionC.leftAnchor.constraint(equalTo: ivIconC.rightAnchor, constant: 10).isActive = true
        lOptionC.rightAnchor.constraint(equalTo: vOptionCContainer.rightAnchor, constant: -10).isActive = true
        lOptionC.centerYAnchor.constraint(equalTo: vOptionCContainer.centerYAnchor).isActive = true
        lOptionC.heightAnchor.constraint(equalTo: vOptionCContainer.heightAnchor, multiplier: 9/10).isActive = true
        //d
        ivIconD.centerYAnchor.constraint(equalTo: vOptionDContainer.centerYAnchor).isActive = true
        ivIconD.leftAnchor.constraint(equalTo: vOptionDContainer.leftAnchor, constant: 10).isActive = true
        ivIconD.heightAnchor.constraint(equalToConstant: 45).isActive = true
        ivIconD.widthAnchor.constraint(equalToConstant: 45).isActive = true
        
        lOptionD.leftAnchor.constraint(equalTo: ivIconD.rightAnchor, constant: 10).isActive = true
        lOptionD.rightAnchor.constraint(equalTo: vOptionDContainer.rightAnchor, constant: -10).isActive = true
        lOptionD.centerYAnchor.constraint(equalTo: vOptionDContainer.centerYAnchor).isActive = true
        lOptionD.heightAnchor.constraint(equalTo: vOptionDContainer.heightAnchor, multiplier: 9/10).isActive = true
        
        //True false button
        
        vQuestionContainer.addSubview(btnTrue)
        vQuestionContainer.addSubview(btnFalse)
        
        btnTrue.topAnchor.constraint(equalTo: lSubQuestion.bottomAnchor, constant: 50).isActive = true
        btnTrue.leftAnchor.constraint(equalTo: vQuestionContainer.leftAnchor, constant: 20).isActive = true
        btnTrue.widthAnchor.constraint(equalTo: vQuestionContainer.widthAnchor, multiplier: 1/3).isActive = true
        btnTrue.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        btnFalse.topAnchor.constraint(equalTo: lSubQuestion.bottomAnchor, constant: 50).isActive = true
        btnFalse.rightAnchor.constraint(equalTo: vQuestionContainer.rightAnchor, constant: -20).isActive = true
        btnFalse.widthAnchor.constraint(equalTo: vQuestionContainer.widthAnchor, multiplier: 1/3).isActive = true
        btnFalse.heightAnchor.constraint(equalToConstant: 100).isActive = true
    
        if(question.sImageId != nil){
            
            lSingleQuestion.isHidden = true
            ivQuestion.isHidden = false
            lSubQuestion.isHidden = false
            
        } else {
            
            lSingleQuestion.isHidden = false
            ivQuestion.isHidden = true
            lSubQuestion.isHidden = true
            
        }
        
    }
    
    func setupComponents(){
        
        vTopContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        vTopContainer.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        vTopContainer.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        vTopContainer.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        btnPass.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        btnPass.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        btnPass.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        btnPass.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/10).isActive = true
        
        vQuestionContainer.topAnchor.constraint(equalTo: vTopContainer.bottomAnchor, constant: 10).isActive = true
        vQuestionContainer.bottomAnchor.constraint(equalTo: btnPass.topAnchor, constant: -10).isActive = true
        vQuestionContainer.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        vQuestionContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        //Elements of container
        
        
        btnBack.leftAnchor.constraint(equalTo: vTopContainer.leftAnchor, constant: 20).isActive = true
        btnBack.centerYAnchor.constraint(equalTo: vTopContainer.centerYAnchor).isActive = true
        btnBack.widthAnchor.constraint(equalToConstant: 30).isActive = true
        btnBack.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        lGroup.centerXAnchor.constraint(equalTo: vTopContainer.centerXAnchor).isActive = true
        lGroup.centerYAnchor.constraint(equalTo: vTopContainer.centerYAnchor).isActive = true
        lGroup.heightAnchor.constraint(equalTo: vTopContainer.heightAnchor, multiplier: 9/10).isActive = true
        lGroup.widthAnchor.constraint(equalTo: vTopContainer.widthAnchor, multiplier: 2/5).isActive = true
        
    
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
