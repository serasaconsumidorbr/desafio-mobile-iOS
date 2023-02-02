//
//  FailureView.swift
//  Marvel Characters
//
//  Created by Leonardo Bandeira on 01/02/23.
//

import Lottie
import UIKit

protocol FailureViewDelegate: AnyObject {
    func performTap()
}

fileprivate extension FailureView.Layout {
    enum Spacing {
        static let inset: CGFloat = 16
    }
}

final class FailureView: UIView {
    // MARK: - Propery(ies).
    enum Layout {}
    weak var delegate: FailureViewDelegate?
    
    // MARK: - Component(s).
    private lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .center
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var animationView: LottieAnimationView = {
        let view = LottieAnimationView(name: "mijonir")
        view.loopMode = .loop
        view.play()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 26, weight: .bold)
        label.numberOfLines = 2
        label.text = "Ops!\nAlgo de errado aconteceu!"
        label.textAlignment = .center
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(performTap), for: .touchUpInside)
        button.backgroundColor = .black
        button.layer.cornerRadius = 8
        button.setTitle("Tentar novamente", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Initialization(s).
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method(s).
    @objc
    private func performTap() {
        delegate?.performTap()
    }
    
    // MARK: - Setup(s).
    private func setupLayout() {
        buildViewHierarchy()
        setupConstraints()
        configureView()
    }
}

// MARK: - View Configuration.
private extension FailureView {
    private func buildViewHierarchy() {
        addSubview(stack)
        addSubview(button)
        stack.addArrangedSubview(animationView)
        stack.addArrangedSubview(label)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stack.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -128),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.Spacing.inset),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Layout.Spacing.inset),
            
            animationView.heightAnchor.constraint(equalToConstant: 280),
            animationView.widthAnchor.constraint(equalToConstant: 480),
            
            button.heightAnchor.constraint(equalToConstant: 50),
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.Spacing.inset),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Layout.Spacing.inset),
            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32)
        ])
    }
    
    private func configureView() {}
}
