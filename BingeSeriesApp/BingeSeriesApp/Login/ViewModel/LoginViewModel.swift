//
//  LoginViewModel.swift
//  BingeSeriesApp
//
//  Created by carlos.gonzalezc.local on 7/5/22.
//

import Foundation

class LoginViewModel {
    
    private(set) weak var view: LoginViewController?
    private var router: LoginRouter?
    
    func bind(view: LoginViewController, router: LoginRouter) {
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func makeLogin() {
        router?.loginUser()
    }
}
