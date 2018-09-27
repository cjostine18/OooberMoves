//
//  ViewController.swift
//  OooberMove
//
//  Created by Casey Jostine on 9/20/18.
//  Copyright © 2018 Casey Jostine. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import GoogleSignIn

class ViewController: UIViewController,FBSDKLoginButtonDelegate,GIDSignInUIDelegate {
    
    let fbLoginBtn: FBSDKLoginButton = {
        
        let button = FBSDKLoginButton()
        button.readPermissions = ["public_profile", "email"]
        return button
    }()
    

    //Mark: Properties
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBOutlet weak var userLabel: UILabel!
    
   // @IBOutlet weak var signInButton: GIDSignInButton!
    
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signInSilently()

        
        view.addSubview(fbLoginBtn)
        fbLoginBtn.center = view.center
        fbLoginBtn.delegate = self
        
       if let token = FBSDKAccessToken.current(){
            fetchProfile()
            
        }
        
    }
    
    
    func fetchProfile(){
            print("You're already logged in bro")
        let parameters = ["fields":"email,first_name, last_name, picture"]
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).start{(connection, result, error)-> Void in
        
            if error != nil{
                print(error)
                return
            }
            
            if let userInfo = result as? [String: Any] {
                let email = userInfo["email"] as? String
                let first_name = userInfo["first_name"] as? String
                
                
                print(email)
                print(first_name)
                
                self.welcomeLabel.isHidden = false
                self.userLabel.isHidden = false
                
                
                self.userNameLabel.text = first_name
                
                self.userLabel.text = first_name
                
                self.welcomeLabel.text = "Welcome Back"
            
            }
        
        }
        
       
        
    }
    
    
    
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        print("login to the shit")
        
        let parameters = ["fields":"email,first_name, last_name, picture"]
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).start{(connection, result, error)-> Void in
            
            if error != nil{
                print(error)
                return
            }
            
            if let userInfo = result as? [String: Any] {
                let email = userInfo["email"] as? String
                let first_name = userInfo["first_name"] as? String
                
                let welcomeUser = "welcome" as? String
                
                print(email)
                print(first_name)
                
                
                self.welcomeLabel.isHidden = false
                self.userLabel.isHidden = false
                
                
                self.welcomeLabel.text = "Welcome"
                
                self.userLabel.text = first_name
                
            }
            
        }
        
    }
    
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("logged out of the shxt")
        
        self.welcomeLabel.isHidden = true
        self.userLabel.isHidden = true
    }
    
    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
    
    
    
    func signIn(signIn: GIDSignIn!,
                presentViewController viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    
    
    
    //let btnFBlogin = FBSDKLoginButton()
        //btnFBlogin.readPermissions = ["public_profile", "email"]
        
        
       // view.addSubview(btnFBlogin)
       // btnFBlogin.center=view.center
        
        
        
       // btnFBlogin.center = self.view.center
      //  self.view.addSubview(btnFBlogin)
        
    
            
       // }else {
       //     self.label.text = "not logged in"
       // }
    
        
    

    

    //Mark: Actions

  /**  @IBAction func didTapSignOut(_ sender: AnyObject) {
        GIDSignIn.sharedInstance().signOut()
    }
**/
    

    //func loginButton(_ loginbutton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!){
    
    //if error != nil{
    //    self.label.text = error.localizedDescription
   // }else if result.isCancelled{
     //   self.label.text = "User has cancelled"
   // }else {
     //   self.label.text = "Successful Login"
        //}
        //}
    



    
    
}
