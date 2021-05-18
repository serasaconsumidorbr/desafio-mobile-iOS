//
//  CharacterDetailsViewController.swift
//  Marvel
//
//  Created by João Pedro on 22/01/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class CharacterDetailsViewController: DefaultViewController {

    // MARK: - View's
    lazy var imageView: ImageLoader = ImageLoader() <-< {
        $0.contentMode = .scaleAspectFit
    }
    
    lazy var lblName: UILabel = UILabel() <-< {
        $0.textAlignment = .center
        $0.font = UIFont.boldSystemFont(ofSize: 22)
        $0.numberOfLines = 0
    }
    
    lazy var lblDescription: UILabel = UILabel() <-< {
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.numberOfLines = 0
        $0.textAlignment = .left
    }

    // MARK: - Var's
    var interactor: CharacterDetailsBusinessLogic?
    var router: (NSObjectProtocol & CharacterDetailsRoutingLogic & CharacterDetailsDataPassing)?
    
    // MARK: - Constructor
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: - Setup UI
    override func setupUI() {
        super.setupUI()
        title = "Character detail's"
        view.backgroundColor = .white
        view.addSubview(imageView)
        imageView.anchor(top: AnchorParameter(anchor: view.safeAreaLayoutGuide.topAnchor, padding: 8),
                         left: AnchorParameter(anchor: view.leftAnchor, padding: 0),
                         right: AnchorParameter(anchor: view.rightAnchor, padding: 0),
                         height: 250)

        view.addSubview(lblName)
        lblName.anchor(top: AnchorParameter(anchor: imageView.bottomAnchor, padding: 8),
                       left: AnchorParameter(anchor: view.leftAnchor, padding: 16),
                       right: AnchorParameter(anchor: view.rightAnchor, padding: 16))

        view.addSubview(lblDescription)
        lblDescription.anchor(top: AnchorParameter(anchor: lblName.bottomAnchor, padding: 32),
                              left: AnchorParameter(anchor: view.leftAnchor, padding: 16),
                              right: AnchorParameter(anchor: view.rightAnchor, padding: 16))
    }

    // MARK: - Appear
    override func viewDidApperFirstTime() {
        super.viewDidApperFirstTime()
        fetchCharacter()
    }

    // MARK: - Auxiliary Func's
    func fetchCharacter() {
        let request = CharacterDetails.FetchCharacter.Request()
        interactor?.fetchCharacterDetail(request: request)
    }
}
