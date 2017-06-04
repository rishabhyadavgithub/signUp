//
//  UserNameVC.swift
//  ComplexSignUp
//
//  Created by rishabh.yadav on 5/28/17.
//  Copyright © 2017 rishabh.yadav. All rights reserved.
//

import UIKit
import Firebase

class UserNameVC: UIViewController {
    
    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var takeMission: UIButton!
    
    var dataBaseReference = Database.database().reference()
    
    var user = Auth.auth().currentUser
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func cancelTapped(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    

    @IBAction func takeMissionTapped(_ sender: Any) {
        
        takeMission.isEnabled = false
        
         self.dataBaseReference.child("username").child(self.userName.text!).observe(.value){(snapShot: DataSnapshot) in
        
            if (!snapShot.exists()){
                
                
                
                //add username to users node
                
                self.dataBaseReference.child("users").child(self.user!.uid).child("username").setValue(self.userName.text?.lowercased())
                
                
                
                //add fullname to database
                
                self.dataBaseReference.child("users").child(self.user!.uid).child("FullName").setValue(self.fullName.text!.capitalized)
                
               
                
                
                //add a new "usernames" and add entry in it too
                
               self.dataBaseReference.child("userNames").child((self.userName!.text?.lowercased())!).setValue(self.user!.uid)
                
                
                
                
                //send user to success view
                
                self.performSegue(withIdentifier: "HomeViewSegue", sender: nil)
            }else
                {
                self.errorMessage.text = "Username alreasy taken"
            }
            
        
            
        
        }
        
        
    }
   
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
