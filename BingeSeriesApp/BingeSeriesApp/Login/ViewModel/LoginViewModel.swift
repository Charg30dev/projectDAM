//
//  LoginViewModel.swift
//  BingeSeriesApp
//
//  Created by carlos.gonzalezc.local on 7/5/22.
//

import Foundation

class LoginViewModel {
    
    private(set) weak var view: LoginViewController?
    private var router: ListRouter?
    
    func bind(view: LoginViewController, router: ListRouter) {
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func makeLogin() {
        router?.loginUser()
    }
}
