//
//  FeedbackViewController.swift
//  StudyGroup
//
//  Created by Hector Díaz Aceves on 30/01/18.
//  Copyright © 2018 HectorDiaz. All rights reserved.
//

import UIKit
import MessageUI

class FeedbackViewController: UIViewController, MFMailComposeViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func configureMailController() -> MFMailComposeViewController {
    
        let mfViewController = MFMailComposeViewController()
        
        mfViewController.mailComposeDelegate = self
        
        
        mfViewController.setToRecipients(["diazhector98@gmail.com"])
        
        mfViewController.setSubject("Feedback")
        
        mfViewController.setMessageBody("This is a cool app", isHTML: false)
        
        return mfViewController
    
    
    }
    
    func handleErrorAlert(error: String){
        
        let alert = UIAlertController(title: "Oops", message: error, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            
            alert.dismiss(animated: true, completion: nil)
            
        }))
        
        present(alert, animated: true, completion: nil)
        
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        controller.dismiss(animated: true, completion: nil)
        
        
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
