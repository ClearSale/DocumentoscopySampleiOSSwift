//
//  View.swift
//  DocumentoscopySampleiOSSwift
//
//  Created by Lucas de Castro Carvalho on 16/01/24.
//

import Foundation
import UIKit

// MARK: - Delegate

protocol ViewDelegate: AnyObject {
    func buttonTap()
}

// MARK: - View

final class View: UIView {
    // MARK: - Delegates
    
    weak var delegate: ViewDelegate?
    
    // MARK: - Life Cyle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        constraintUI()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI

    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Abrir SDK", for: .normal)
        button.setTitleColor(UIColor.blue ,for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Actions

    @objc private func buttonTap() {
        delegate?.buttonTap()
    }
    
    // MARK: - Setup

    private func constraintUI() {
        self.backgroundColor = .white
        addSubview(button)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.centerYAnchor.constraint(equalTo: centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 200),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
