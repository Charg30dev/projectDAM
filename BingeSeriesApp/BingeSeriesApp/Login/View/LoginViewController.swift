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
    @IBOutlet weak var remembermeLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var createCountButton: UIButton!
    
    
    // Variables
    
    private var router = ListRouter()
    private var viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupUI()
        viewModel.bind(view: self, router: router)
    }
    
    // MARK: Actions Functions
    
    @IBAction func login(_ sender: Any) {
        
        if userTextField.text?.isEmpty == true || passwordTextField.text?.isEmpty == true {
            let alert = UIAlertController(title: "Error en el inicio de sesión",
                                          message: "Su usuario o contraseña son incorrectos",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            
        } else {
            viewModel.makeLogin()
        }
    }
    
    @IBAction func createCount(_ sender: Any) {
        
        if createCountButton.tag == 0 {
            loginButton.setTitle("Crear usuario", for: .normal)
            loginButton.backgroundColor = UIColor.green
            
        }
    }
    
    // MARK: - Functions
    
    func setupUI() {
        
        self.remembermeLabel.text = "Recordar usuario"
        self.loginButton.layer.cornerRadius = 10
        self.loginButton.clipsToBounds = true
        self.loginButton.setTitle("Acceder", for: .normal)
        self.createCountButton.setTitle("¿No tienes cuenta?", for: .normal)
    }
}
