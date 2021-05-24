//
//  CharacterDetatilViewController.swift
//  App
//
//  Created by Lucas Paim on 24/05/21.
//  Copyright (c) 2021 com.example.marvel. All rights reserved.
//

import UIKit
import AppCoreUI


final class CharacterDetatilViewController: BaseViewController {

    // Var's
    var interactor: CharacterDetatilBusinessLogic?
    var router: (NSObjectProtocol & CharacterDetatilRoutingLogic & CharacterDetatilDataPassing)?

    lazy var backgroundImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "marvel", size: 36)
        label.backgroundColor = .secondaryBackgroundColor
        label.textColor = .textColor
        label.textAlignment = .center
        label.numberOfLines = .zero
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22)
        label.textAlignment = .center
        label.numberOfLines = .zero
        label.textColor = .textColor
        return label
    }()
    
    // Constructor
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // Load
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.getCharacterDetail(request: CharacterDetatil.GetElement.Request())
    }

    override func setupUI() {
        super.setupUI()
        
        view.addSubview(backgroundImage)
        view.addSubview(nameLabel)
        view.addSubview(descriptionLabel)
        
        backgroundImage.snp.makeConstraints { make in
            make.top.trailing.leading.equalToSuperview()
            make.height.equalTo(150)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(backgroundImage.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(32)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(backgroundImage.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(32)
            make.bottom.equalToSuperview().inset(32)
        }
    }

    // Appear

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

}
