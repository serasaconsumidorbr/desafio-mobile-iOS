//
//  ListOptionsViewController.swift
//  MarvelCharacters
//
//  Created by Gabriel Beltrame Silva on 06/04/23.
//

import Foundation
import UIKit

class ListOptionsViewController: BaseViewCodeController {
    
    private lazy var itemsPerPageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.text = "Items por página"
        return label
    }()
    
    private lazy var itemsPerPageValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private lazy var itemsPerPageSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumValue = 1
        slider.maximumValue = 100
        slider.addTarget(self, action: #selector(valueChanged(_:)), for: .valueChanged)
        return slider
    }()
    
    private lazy var orderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.text = "Ordenação"
        return label
    }()
    
    private lazy var orderSelector: UISegmentedControl = {
        let control = UISegmentedControl(items: ListOrder.allCases.map({ $0.userFriendlyLabel }))
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    private lazy var saveOptionsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitle("Salvar", for: .normal)
        button.addTarget(self, action: #selector(saveOptions(_:)), for: .touchUpInside)
        return button
    }()
    
    let interactor: ListOptionsInteractorProtocol
    
    init(
        interactor: ListOptionsInteractorProtocol
    ) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.loadOptions()
    }
    
    override func addSubviews() {
        view.addSubview(itemsPerPageLabel)
        view.addSubview(itemsPerPageValueLabel)
        view.addSubview(itemsPerPageSlider)
        view.addSubview(orderLabel)
        view.addSubview(orderSelector)
        view.addSubview(saveOptionsButton)
    }
    
    override func setupConstraints() {
        view.addConstraints([
            itemsPerPageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            itemsPerPageLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            itemsPerPageLabel.heightAnchor.constraint(equalToConstant: 20),
            itemsPerPageValueLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            itemsPerPageValueLabel.topAnchor.constraint(equalTo: itemsPerPageLabel.bottomAnchor, constant: 14),
            itemsPerPageValueLabel.heightAnchor.constraint(equalToConstant: 20),
            itemsPerPageSlider.topAnchor.constraint(equalTo: itemsPerPageValueLabel.bottomAnchor, constant: 14),
            itemsPerPageSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
            itemsPerPageSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14),
            orderLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            orderLabel.topAnchor.constraint(equalTo: itemsPerPageSlider.bottomAnchor, constant: 14),
            orderLabel.heightAnchor.constraint(equalToConstant: 20),
            orderSelector.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
            orderSelector.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14),
            orderSelector.topAnchor.constraint(equalTo: orderLabel.bottomAnchor, constant: 14),
            saveOptionsButton.topAnchor.constraint(greaterThanOrEqualTo: orderSelector.bottomAnchor, constant: 14),
            saveOptionsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveOptionsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
            saveOptionsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14),
            saveOptionsButton.heightAnchor.constraint(equalToConstant: 40),
            saveOptionsButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -14),
        ])
    }
    
    override func setupSubviews() {
        view.insetsLayoutMarginsFromSafeArea = true
        view.backgroundColor = UIColor.white
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @objc public func valueChanged(_ sender: Any) {
        let value = itemsPerPageSlider.value.rounded(.down)
        itemsPerPageSlider.value = value
        itemsPerPageValueLabel.text = String(format: "%.0f", value)
    }
    
    @objc public func saveOptions(_ sender: Any) {
        let listOptions = ListOptions(
            listOrder: ListOrder(orderSelector.selectedSegmentIndex),
            itemsPerPage: Int(itemsPerPageSlider.value)
        )
        interactor.saveOptions(listOptions)
        self.dismiss(animated: true)
    }
}

extension ListOptionsViewController: ListOptionsViewControllerProtocol {
    func updateOptions(_ listOptions: ListOptions) {
        itemsPerPageSlider.value = Float(listOptions.itemsPerPage)
        itemsPerPageValueLabel.text = String(listOptions.itemsPerPage)
        orderSelector.selectedSegmentIndex = listOptions.listOrder.itemIndex
    }
}
