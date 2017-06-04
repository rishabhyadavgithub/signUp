//
//  LoginVC.swift
//  ComplexSignUp
//
//  Created by rishabh.yadav on 5/31/17.
//  Copyright © 2017 rishabh.yadav. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
    
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var logIn: UIButton!
    
    var dataBaseReference = Database.database().reference()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
  
    
    @IBAction func logInTapped(_ sender: Any) {
        
        
        
        Auth.auth().signIn(withEmail: self.email.text!, password: self.password.text!) { (user, error) in
            
            if error == nil {
                
                self.dataBaseReference.child("users").child(user!.uid).child("username").observeSingleEvent(of: .value, with: { (snapshot : DataSnapshot) in
                    
                     //print("****\(snapshot)")
                    
                    if (!snapshot.exists()){
                        self.performSegue(withIdentifier: "userNameSegue", sender: nil)
                    }else{
                        self.performSegue(withIdentifier: "homeViewSegue", sender: nil)
                    }
                })
                
            }else
            {
                
                self.errorMessage.text = error?.localizedDescription
            }
        }
        
        }

}
