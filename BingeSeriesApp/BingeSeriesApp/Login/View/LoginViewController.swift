//
//  LoginViewController.swift
//  BingeSeriesApp
//
//  Created by carlos.gonzalezc.local on 7/5/22.
//

import UIKit
import FirebaseAuth

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
        
        if self.userTextField.text == "" || self.passwordTextField.text == "" {
            let alertController = UIAlertController(title: "Error",
                                                    message: "Por favor introduce email y contraseña",
                                                    preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            
            Auth.auth().signIn(withEmail: self.userTextField.text!, password: self.passwordTextField.text!) { (user, error) in
                
                if error == nil {
                    
                    self.viewModel.makeLogin()
                    
                } else {
                    
                    let alertController = UIAlertController(title: "Error",
                                                            message: "Usuario o contraseña erróneos",
                                                            preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func createCount(_ sender: Any) {
        
        let alert = UIAlertController(title: "Nuevo Usuario",
                                      message: "Introduce tus datos por favor",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Guardar",
                                       style: .default) { action in
            let email = alert.textFields![0]
            let password = alert.textFields![1]
            Auth.auth().createUser(withEmail: email.text!,
                                   password: password.text!) { user, error in
            }
        }
        let cancelAction = UIAlertAction(title: "Cancelar",
                                         style: .default)
        alert.addTextField { textEmail in
            textEmail.placeholder = "email"
        }
        alert.addTextField { textPassword in
            textPassword.isSecureTextEntry = true
            textPassword.placeholder = "contraseña"
        }
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
        
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
