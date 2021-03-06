//
//  LoginViewController.swift
//  Login
//
//  Created by Paige Plander on 4/5/17.
//  Copyright © 2017 Paige Plander. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // Constants used in the LoginViewController
    struct Constants {
        static let backgroundColor: UIColor = UIColor(hue: 0.5389, saturation: 1, brightness: 0.92, alpha: 1.0)
        static let invalidEmailTitle = "Invalid username or password"
        static let invalidEmailMessage = "Please try again"
    }

    // TODO: instantiate the views needed for your project
    var headerLabel: UILabel!
    var userText: UITextField!
    var passwordText: UITextField!
    var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundColor
        
        // TODO: Add your views either as subviews of `view` or subviews of each other using `addSubview`
        headerLabel = UILabel()
        headerLabel.text = "JC's Login Screen"
        headerLabel.textColor = UIColor.white
        headerLabel.textAlignment = .center
        headerLabel.font = UIFont(name: "Helvetica", size: 50)
        headerLabel.numberOfLines = 2
        
        userText = UITextField()
        userText.placeholder = "Your berkeley.edu email here"
        
        passwordText = UITextField()
        passwordText.placeholder = "Your password here"
        
        loginButton = UIButton()
        loginButton.setTitle("Login", for: .normal)
        loginButton.titleLabel?.textAlignment = .center
        loginButton.backgroundColor = UIColor.darkGray
        loginButton.layer.cornerRadius = 10
        loginButton.addTarget(self, action: #selector(doLogin), for: .touchUpInside)
        
        let loginView = UIView()
        loginView.backgroundColor = UIColor.white
        loginView.addSubview(userText)
        loginView.addSubview(passwordText)
        loginView.addSubview(loginButton)
        view.addSubview(loginView)
        view.addSubview(headerLabel)
        
        // TODO: layout your views using frames or AutoLayout
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        loginView.translatesAutoresizingMaskIntoConstraints = false
        userText.translatesAutoresizingMaskIntoConstraints = false
        passwordText.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        let batchConstraints = [
            loginView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
            loginView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            
            headerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            headerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            headerLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            
            userText.topAnchor.constraint(equalTo: loginView.topAnchor, constant: 10),
            userText.leftAnchor.constraint(equalTo: loginView.leftAnchor, constant: 10),
            userText.rightAnchor.constraint(equalTo: loginView.rightAnchor, constant: -10),
            userText.centerXAnchor.constraint(equalTo: loginView.centerXAnchor),
            
            loginButton.bottomAnchor.constraint(equalTo: loginView.bottomAnchor, constant: -10),
            loginButton.heightAnchor.constraint(equalTo: userText.heightAnchor),
            loginButton.leftAnchor.constraint(equalTo: loginView.leftAnchor, constant: 10),
            loginButton.rightAnchor.constraint(equalTo: loginView.rightAnchor, constant: -10),
            loginButton.centerXAnchor.constraint(equalTo: loginView.centerXAnchor),
            
            passwordText.heightAnchor.constraint(equalTo: userText.heightAnchor),
            passwordText.leftAnchor.constraint(equalTo: loginView.leftAnchor, constant: 10),
            passwordText.rightAnchor.constraint(equalTo: loginView.rightAnchor, constant: -10),
            passwordText.centerXAnchor.constraint(equalTo: loginView.centerXAnchor),
            passwordText.centerYAnchor.constraint(equalTo: loginView.centerYAnchor)
        ]
        NSLayoutConstraint.activate(batchConstraints)
    }
    
    // TODO: create an IBAction for your login button
    @IBAction func doLogin(sender: UIButton) {
        authenticateUser(username: userText.text, password: passwordText.text)
    }
    
    
    
    
    /// YOU DO NOT NEED TO MODIFY ANY OF THE CODE BELOW (but you will want to use `authenticateUser` at some point)
    
    // Model class to handle checking if username/password combinations are valid.
    // Usernames and passwords can be found in the Lab6Names.csv file
    let loginModel = LoginModel(filename: "Lab6Names")

    /// Imageview for login success image (do not need to modify)
    let loginSuccessView = UIImageView(image: UIImage(named: "oski"))
    
    /// If the provided username/password combination is valid, displays an
    /// image (in the "loginSuccessView" imageview). If invalid, displays an alert
    /// telling the user that the login was unsucessful.
    /// You do not need to edit this function, but you will want to use it for the lab.
    ///
    /// - Parameters:
    ///   - username: the user's berkeley.edu address
    ///   - password: the user's first name (what a great password!)
    func authenticateUser(username: String?, password: String?) {
        
        // if username / password combination is invalid, present an alert
        if !loginModel.authenticate(username: username, password: password) {
            loginSuccessView.isHidden = true
            let alert = UIAlertController(title: Constants.invalidEmailTitle, message: Constants.invalidEmailMessage, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
            
        // If username / password combination is valid, display success image
        else {
            if !loginSuccessView.isDescendant(of: view) {
                view.addSubview(loginSuccessView)
                loginSuccessView.contentMode = .scaleAspectFill
            }
            
            loginSuccessView.isHidden = false
            
            // Constraints for the login success view
            loginSuccessView.translatesAutoresizingMaskIntoConstraints = false
            loginSuccessView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            loginSuccessView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            loginSuccessView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            loginSuccessView.heightAnchor.constraint(equalToConstant: view.frame.height/4).isActive = true
        }
    }
}
