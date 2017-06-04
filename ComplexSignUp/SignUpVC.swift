//
//  SignUpVC.swift
//  ComplexSignUp
//
//  Created by rishabh.yadav on 5/28/17.
//  Copyright © 2017 rishabh.yadav. All rights reserved.
//

import UIKit
import Firebase

class SignUpVC: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var chooseUsername: UIButton!
    
    var databaseReference = Database.database().reference()
    
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
    
    @IBAction func chooseUsernameTapped(_ sender: Any) {
        
        chooseUsername.isEnabled = false
        
        
        Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (user, error) in
            
            if error != nil{
                 self.errorMessage.text = error?.localizedDescription
                
            }else
            {
                
                self.errorMessage.text = "User registration Success"
                
                Auth.auth().signIn(withEmail: self.email.text!, password: self.password.text!, completion: { (user, error) in
                    
                    if error == nil{
                        self.databaseReference.child("users").child(user!.uid).child("email").setValue(self.email.text!)
                        self.performSegue(withIdentifier: "userNameSegue", sender: nil)
                    }
                    
                })
            }
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    

    

}































