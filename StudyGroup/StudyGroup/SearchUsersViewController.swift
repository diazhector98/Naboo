//
//  SearchUsersViewController.swift
//  StudyGroup
//
//  Created by Hector Díaz Aceves on 19/02/18.
//  Copyright © 2018 HectorDiaz. All rights reserved.
//

import UIKit
import AlgoliaSearch

class SearchUsersViewController: UIViewController {
    

    
    let textFieldName: UITextField = {
    
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    
    
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(textFieldName)
        
        let client = Client(appID: "EJ9BOB5Z3Q", apiKey: "53e086bddfe09264fd156ac7e0131101")
        let index = client.index(withName: "firebase_users")

        // Do any additional setup after loading the view.
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
