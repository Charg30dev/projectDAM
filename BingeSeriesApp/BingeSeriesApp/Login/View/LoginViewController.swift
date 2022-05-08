//
//  LoginViewController.swift
//  BingeSeriesApp
//
//  Created by carlos.gonzalezc.local on 7/5/22.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var rememberSwitch: UISwitch!
    @IBOutlet weak var loginButton: UIButton!
    
    // Variables
    
    private var router = LoginRouter()
    private var viewModel = LoginViewModel()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        configurationButton()
        viewModel.bind(view: self, router: router)
    }
    
    // MARK: Actions Functions
    
    @IBAction func login(_ sender: Any) {
        router.loginUser()
    }
    
    // MARK: - Functions
    
    func configurationButton() {
        loginButton.layer.cornerRadius = 10
        loginButton.clipsToBounds = true
    }
    
    
}
