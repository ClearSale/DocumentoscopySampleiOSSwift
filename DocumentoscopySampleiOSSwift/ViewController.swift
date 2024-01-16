//
//  ViewController.swift
//  DocumentoscopySampleiOSSwift
//
//  Created by Lucas de Castro Carvalho on 16/01/24.
//

import UIKit
import CSDocumentoscopySDK

class ViewController: UIViewController {

    // MARK: - Private Attributes
    
    private let navigation: UINavigationController
    
    // MARK: - Constants

    private struct Constants {
        static let clientId = "SEU clientId AQUI"
        static let clientSecret = "SEU clientSecret AQUI"
        static let identifierId = "SEU identifierId AQUI"
        static let cpf = "SEU cpf AQUI"
    }
    
    // MARK: - Life Cycle

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(
        navigationController: UINavigationController
    ) {
        self.navigation = navigationController
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        let view = View()
        view.delegate = self
        self.view = view
    }
    
    // MARK: - Private Functions

    private func callSDK() {
        let sdk = CSDocumentoscopy()
        sdk.delegate = self
        sdk.initialize(
            clientId: Constants.clientId,
            clientSecret: Constants.clientSecret,
            identifierId: Constants.identifierId,
            cpf: Constants.cpf,
            navigationController: navigation)
    }
}

// MARK: - Extensions

extension ViewController: ViewDelegate {
    func buttonTap() {
        callSDK()
    }
}

extension ViewController: CSDocumentoscopyDelegate {
    func didOpen() {
        print("CSDocumentoscopy - SDK Aberto")
    }
    
    func didTapClose() {
        print("CSDocumentoscopy - SDK Fechado")
    }
    
    func didReceiveError(error: CSDocumentoscopyError) {
        print("CSDocumentoscopy - SDK Error: " + error.text)
    }
    
    func didFinishCapture(result: CSDocumentoscopyResult) {
        print("CSDocumentoscopy - SDK Fluxo Finalizado")
    }
}
