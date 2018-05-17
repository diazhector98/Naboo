//
//  LoginJoinViewController.swift
//  StudyGroup
//
//  Created by Hector Díaz Aceves on 25/11/17.
//  Copyright © 2017 HectorDiaz. All rights reserved.
//

import UIKit
import GoogleSignIn

class LoginViewController: UIViewController, GIDSignInUIDelegate {
    
    var bLoginIn: Bool = true;
    
    var groupsController: GroupsViewController?
    
    
    /*

 UI Elements Initialization & Declaration (inside views for canvas animations)
     
     -----------Login----------
     - Welcome back label
     - Email text field
     - Password text field
     - Login Button
     - Google button
     - Not have account button
     -----------Join----------
     
     - Join "Logo"
     - Quote Label
     - Name text field
     - Email text field
     - Password text field
     - Join button
     - Google button
     - Have account button
     
     
     

 
 */
    
    /*
 
     MARK:Login Elements
 
 */
    let lWelcomeBack: UILabel = {
        
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "Helvetica-Bold", size: 64)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Welcome \nback."
        label.adjustsFontSizeToFitWidth = true
        return label
        
    }()
    
    
    let tfEmail: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.font = UIFont(name: "Helvetica-Bold", size: 24)
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let vEmailLine: UIView = {
        
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    

    let tfPassword: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.font = UIFont(name: "Helvetica-Bold", size: 24)
        tf.isSecureTextEntry = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let vPasswordLine: UIView = {
        
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()

    lazy var btnLogin: UIButton = {
    
        let button = UIButton(type: .system)
        button.setTitle("Login.", for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 24)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    
    }()
    
    lazy var btnGoogleLogIn: GIDSignInButton = {
        
        let button = GIDSignInButton()
        //button.setTitle("Google Join.", for: .normal)
        //button.setImage(UIImage(named: "signInWithGoogle"), for: .normal)
        //button.addTarget(self, action: #selector(handleGoogle), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    lazy var btnForgotPassword: UIButton = {
        
        let button = UIButton(type: .system)
        button.setTitle("Forgot password.", for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 20)
        button.addTarget(self, action: #selector(handleForgotPassword), for: .touchUpInside)
        button.tintColor = .lightGray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    lazy var btnJoinToggle: UIButton = {
    
        let button = UIButton(type: .system)
        button.setTitle("Don't have an account? Join.", for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 20)
        button.tintColor = .black
        button.addTarget(self, action: #selector(handleLoginToggle), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    
    
    }()
    
    
    //MARK: Join Elements

    
    let ivBackKids: UIImageView = {
    
        let iv = UIImageView()
        iv.isHidden = true
        iv.image = UIImage(named: "backKids")
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    
    }()
    
    let ivMiddleKids: UIImageView = {
        
        let iv = UIImageView()
        iv.isHidden = true
        iv.image = UIImage(named: "middleKids")
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
        
    }()
    
    let ivFrontKid: UIImageView = {
        
        let iv = UIImageView()
        iv.isHidden = true
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
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 20)
        button.tintColor = .black
        button.addTarget(self, action: #selector(handleJoinToggle), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
        
    }()
    
    
    /*
 
     MARK: Containers
 
 */
    
    //Login
    
    let vWelcomeQuoteContainer: UIView = {
    
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    
    }()
    
    let vLoginFieldsContainer: UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    let vLoginExtraContainer: UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()

    
    //Join
    
    
    let vQuoteAndJoinFieldsContainer: JoinFieldsView = {
        
        let view = JoinFieldsView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    let vJoinButtonsContainer: UIView = {
        
        let view = UIView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()


    
    /*
 
     MARK: Button functions

 */
    
    func handleJoinToggle(){
        
        vWelcomeQuoteContainer.isHidden = false
        vLoginFieldsContainer.isHidden = false
        vLoginExtraContainer.isHidden = false
        vJoinButtonsContainer.isHidden = true
        vQuoteAndJoinFieldsContainer.isHidden = true
        ivFrontKid.isHidden = true
        ivBackKids.isHidden = true
        ivMiddleKids.isHidden = true
        
    
    }
    
    
    
    func handleLoginToggle(){
        
        vWelcomeQuoteContainer.isHidden = true
        vLoginFieldsContainer.isHidden = true
        vLoginExtraContainer.isHidden = true
        vJoinButtonsContainer.isHidden = false
        vQuoteAndJoinFieldsContainer.isHidden = false
        ivFrontKid.isHidden = false
        ivBackKids.isHidden = false
        ivMiddleKids.isHidden = false
        
//        let controller = JoinViewController()
//        controller.groupsController = self.groupsController
//        controller.loginController = self
//        handleDismiss()
//        
//        self.present(controller, animated: true) { 
//            self.handleDismiss()
//        }
    
    }
    
    func handleDismiss(){
    
        self.dismiss(animated: true, completion: nil)
    
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Google sign in without soliciting confirmation from user
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        
        view.backgroundColor = .white
        
        //Setup containers
        
        //Login
        
        vWelcomeQuoteContainer.addSubview(lWelcomeBack)
        
        vLoginFieldsContainer.addSubview(tfEmail)
        vLoginFieldsContainer.addSubview(vEmailLine)
        vLoginFieldsContainer.addSubview(tfPassword)
        vLoginFieldsContainer.addSubview(vPasswordLine)
        vLoginFieldsContainer.addSubview(btnLogin)
        
        vLoginExtraContainer.addSubview(btnGoogleLogIn)
        vLoginExtraContainer.addSubview(btnForgotPassword)
        vLoginExtraContainer.addSubview(btnJoinToggle)
        
        //Join
        
        vJoinButtonsContainer.addSubview(btnJoin)
        vJoinButtonsContainer.addSubview(btnGoogleJoin)
        vJoinButtonsContainer.addSubview(btnLoginToggle)
        
        
        //Add containers to view
        
        view.addSubview(vWelcomeQuoteContainer)
        view.addSubview(vLoginFieldsContainer)
        view.addSubview(vLoginExtraContainer)
        
        
        view.addSubview(ivBackKids)
        view.addSubview(ivMiddleKids)
        view.addSubview(ivFrontKid)
        view.addSubview(vQuoteAndJoinFieldsContainer)
        view.addSubview(vJoinButtonsContainer)
        
        
        //Setup Components
        
        setupComponents()
        
        //Setup keyboard
        
        setupKeyboardObservers()
        

    
    }
    
    
    //Define sizes and locations for ui components
    
    func setupComponents(){
        
        //Container dimensions
        
        vWelcomeQuoteContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        vWelcomeQuoteContainer.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        vWelcomeQuoteContainer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 9/10).isActive = true
        vWelcomeQuoteContainer.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/3).isActive = true
        
        vLoginFieldsContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        vLoginFieldsContainer.topAnchor.constraint(equalTo: vWelcomeQuoteContainer.bottomAnchor, constant: 10).isActive = true
        vLoginFieldsContainer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 9/10).isActive = true
        vLoginFieldsContainer.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 3/10).isActive = true
        
        vLoginExtraContainer.topAnchor.constraint(equalTo: vLoginFieldsContainer.bottomAnchor, constant: 10).isActive = true
        vLoginExtraContainer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 9/10).isActive = true
        vLoginExtraContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        vLoginExtraContainer.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 3/10).isActive = true
        
        ivBackKids.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        ivBackKids.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant:0).isActive = true
        ivBackKids.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/7).isActive = true
        ivBackKids.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 3/4).isActive = true
        
        ivMiddleKids.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        ivMiddleKids.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        ivMiddleKids.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/6).isActive = true
        ivMiddleKids.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2).isActive = true
        
        ivFrontKid.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        ivFrontKid.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        ivFrontKid.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/5).isActive = true
        ivFrontKid.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/4).isActive = true
        
        
        
        vQuoteAndJoinFieldsContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant:0).isActive = true
        vQuoteAndJoinFieldsContainer.topAnchor.constraint(equalTo: ivFrontKid.bottomAnchor, constant: 10).isActive = true
        vQuoteAndJoinFieldsContainer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 9/10).isActive = true
        vQuoteAndJoinFieldsContainer.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 3/7).isActive = true
        

        vJoinButtonsContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        vJoinButtonsContainer.topAnchor.constraint(equalTo: vQuoteAndJoinFieldsContainer.bottomAnchor, constant: 10).isActive = true
        vJoinButtonsContainer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 9/10).isActive = true
        vJoinButtonsContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        //Elements in containers
        
        /*
 
         Login
 
         */
        lWelcomeBack.centerXAnchor.constraint(equalTo: vWelcomeQuoteContainer.centerXAnchor).isActive = true
        lWelcomeBack.centerYAnchor.constraint(equalTo: vWelcomeQuoteContainer.centerYAnchor).isActive = true
        lWelcomeBack.heightAnchor.constraint(equalTo: vWelcomeQuoteContainer.heightAnchor, multiplier: 9/10).isActive = true
        lWelcomeBack.widthAnchor.constraint(equalTo: vWelcomeQuoteContainer.widthAnchor, multiplier: 9/10).isActive = true
        
        tfPassword.centerXAnchor.constraint(equalTo: vLoginFieldsContainer.centerXAnchor).isActive = true
        tfPassword.centerYAnchor.constraint(equalTo: vLoginFieldsContainer.centerYAnchor).isActive = true
        tfPassword.widthAnchor.constraint(equalTo: vLoginFieldsContainer.widthAnchor, multiplier: 9/10).isActive = true
        tfPassword.heightAnchor.constraint(equalTo: vLoginFieldsContainer.heightAnchor, multiplier: 1/4).isActive = true
        
        vEmailLine.bottomAnchor.constraint(equalTo: tfPassword.topAnchor, constant: -10).isActive = true
        vEmailLine.centerXAnchor.constraint(equalTo: vLoginFieldsContainer.centerXAnchor).isActive = true
        vEmailLine.widthAnchor.constraint(equalTo: vLoginFieldsContainer.widthAnchor, multiplier: 9/10).isActive = true
        vEmailLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        tfEmail.bottomAnchor.constraint(equalTo: vEmailLine.topAnchor, constant: -1).isActive = true
        tfEmail.centerXAnchor.constraint(equalTo: vLoginFieldsContainer.centerXAnchor).isActive = true
        tfEmail.widthAnchor.constraint(equalTo: vLoginFieldsContainer.widthAnchor, multiplier: 9/10).isActive = true
        tfEmail.heightAnchor.constraint(equalTo: vLoginFieldsContainer.heightAnchor, multiplier: 1/4).isActive = true
        
        vPasswordLine.topAnchor.constraint(equalTo: tfPassword.bottomAnchor, constant: 1).isActive = true
        vPasswordLine.centerXAnchor.constraint(equalTo: vLoginFieldsContainer.centerXAnchor).isActive = true
        vPasswordLine.widthAnchor.constraint(equalTo: vLoginFieldsContainer.widthAnchor, multiplier: 9/10).isActive = true
        vPasswordLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        btnLogin.topAnchor.constraint(equalTo: vPasswordLine.bottomAnchor, constant: 1).isActive = true
        btnLogin.bottomAnchor.constraint(equalTo: vLoginFieldsContainer.bottomAnchor, constant: -1).isActive = true
        btnLogin.centerXAnchor.constraint(equalTo: vLoginFieldsContainer.centerXAnchor).isActive = true
        btnLogin.widthAnchor.constraint(equalTo: vLoginFieldsContainer.widthAnchor, multiplier: 9/10).isActive = true
        
        btnForgotPassword.centerYAnchor.constraint(equalTo: vLoginExtraContainer.centerYAnchor).isActive = true
        btnForgotPassword.widthAnchor.constraint(equalTo: vLoginExtraContainer.widthAnchor, multiplier: 9/10).isActive = true
        btnForgotPassword.heightAnchor.constraint(equalTo: vLoginExtraContainer.heightAnchor, multiplier: 1/4).isActive = true
        btnForgotPassword.centerXAnchor.constraint(equalTo: vLoginExtraContainer.centerXAnchor).isActive = true
        
        btnGoogleLogIn.centerXAnchor.constraint(equalTo: vLoginExtraContainer.centerXAnchor).isActive = true
        btnGoogleLogIn.bottomAnchor.constraint(equalTo: btnForgotPassword.topAnchor, constant: -10).isActive = true
        btnGoogleLogIn.heightAnchor.constraint(equalTo: vLoginExtraContainer.heightAnchor, multiplier: 1/4).isActive = true
        btnGoogleLogIn.widthAnchor.constraint(equalTo: vLoginExtraContainer.widthAnchor, multiplier: 9/10).isActive = true
        
        btnJoinToggle.centerXAnchor.constraint(equalTo: vLoginExtraContainer.centerXAnchor).isActive = true
        btnJoinToggle.topAnchor.constraint(equalTo: btnForgotPassword.bottomAnchor, constant: 10).isActive = true
        btnJoinToggle.widthAnchor.constraint(equalTo: vLoginExtraContainer.widthAnchor, multiplier: 9/10).isActive = true
        btnJoinToggle.heightAnchor.constraint(equalTo: vLoginExtraContainer.heightAnchor, multiplier: 1/4).isActive = true
        
        /*
         
         Join
         
         */
        

        
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
    
    /*
 
     MARK: Keyboard
 
 */
    
    func setupKeyboardObservers(){
    
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    func handleKeyboardWillShow(_ notification: Notification){
    
           
    }
    
    func handleKeyboardWillHide(_ notification: Notification){
    
        
    }
    

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
