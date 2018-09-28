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

class ViewController: UIViewController,FBSDKLoginButtonDelegate,GIDSignInUIDelegate,GIDSignInDelegate {
    
    let fbLoginBtn: FBSDKLoginButton = {
        
        let button = FBSDKLoginButton()
        button.readPermissions = ["public_profile", "email"]
        return button
    }()
    
    
    let googleLoginBtn: GIDSignInButton = {
        
        let button = GIDSignInButton()
        //button.readPermissions = ["public_profile", "email"]
        return button
    }()
    

    //Mark: Properties
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBOutlet weak var userLabel: UILabel!
    
   
    @IBOutlet weak var navLabel: UILabel!
    
    
    
   // @IBOutlet weak var signInButton: GIDSignInButton!
    
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signInSilently()
        GIDSignIn.sharedInstance().delegate = self
        
        
        


        
        view.addSubview(fbLoginBtn)
        fbLoginBtn.center = view.center
        fbLoginBtn.delegate = self
        
        view.addSubview(googleLoginBtn)
        googleLoginBtn.center = view.center
       //googleLoginBtn.delegate = self
        
        
      
        
        
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
                
                self.navLabel.text = first_name
                
                self.userLabel.text = first_name
                
                self.welcomeLabel.text = "Welcome Back"
            
            }
        
        }
        
        
        
        func fetchProfileGoogle(){
            self.navLabel.text = GIDSignIn.sharedInstance().currentUser.profile.name
            
            
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
    
    
    
   /** func signIn(signIn: GIDSignIn!,
                presentViewController viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
        print("test with google")
        
    }
    **/
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if error != nil {
            print(error)
            return
        }
       
        print(user.profile.email)
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
    @IBAction func didSignOut(_ sender: UIBarButtonItem) {
       // print(GIDSignIn.sharedInstance().currentUser.profile.email)
       // print(GIDSignIn.sharedInstance().currentUser.profile.name)
        GIDSignIn.sharedInstance().signOut()
        
        
        if FBSDKAccessToken.current() != nil {
            let logout = FBSDKLoginManager()
            logout.logOut()
            
            self.welcomeLabel.isHidden = true
            self.userLabel.isHidden = true
        
        
        
    }
    
      
    

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
    
    
}
