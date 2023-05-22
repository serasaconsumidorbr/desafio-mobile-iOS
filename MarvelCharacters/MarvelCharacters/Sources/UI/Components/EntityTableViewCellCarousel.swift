//
//  EntityTableViewCellCarousel.swift
//  MarvelCharacters
//
//  Created by iris on 21/05/23.
//

import UIKit
import SDWebImage

class EntityTableViewCellCarousel: UITableViewCell {
    
    // MARK: - PUBLIC PROPERTIES
    
    public static var reuseIdentifier = "EntityTableViewCellCarousel"
    
    // MARK: - UI
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .top
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    // Character One
    
    private lazy var pictureAndtitleStackView1: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    private lazy var picture1: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "placeholder")
        return imageView
    }()
    
    private lazy var title1: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byTruncatingMiddle
        label.numberOfLines = 2
        label.textColor = .none
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    // Character Two
    
    private lazy var pictureAndtitleStackView2: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    private lazy var picture2: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "placeholder")
        return imageView
    }()
    
    private lazy var title2: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byTruncatingMiddle
        label.numberOfLines = 2
        label.textColor = .none
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    // Character Three
    
    private lazy var pictureAndtitleStackView3: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    private lazy var picture3: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "placeholder")
        return imageView
    }()
    
    private lazy var title3: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byTruncatingMiddle
        label.numberOfLines = 2
        label.textColor = .none
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    // Character Four
    
    private lazy var pictureAndtitleStackView4: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    private lazy var picture4: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "placeholder")
        return imageView
    }()
    
    private lazy var title4: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byTruncatingMiddle
        label.numberOfLines = 2
        label.textColor = .none
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    // Character Five
    
    private lazy var pictureAndtitleStackView5: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    private lazy var picture5: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "placeholder")
        return imageView
    }()
    
    private lazy var title5: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byTruncatingMiddle
        label.numberOfLines = 2
        label.textColor = .none
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    // MARK: - INITIALIZERS
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupComponents()
        addViewHierarchy()
        constraintUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PUBLIC METHODS
    
    func setupCell(with model: EntityCellsModel) {
        self.title1.text = model.cell[0].title
        self.title2.text = model.cell[1].title
        self.title3.text = model.cell[2].title
        self.title4.text = model.cell[3].title
        self.title5.text = model.cell[4].title
        setImage(for: model.getImagesUrl())
    }
    
    // MARK: - SETUP
    
    private func setupComponents() {
        containerStackView.backgroundColor = .systemBackground
    }
    
    private func addViewHierarchy() {
        addSubview(containerStackView)
        containerStackView.addArrangedSubview(pictureAndtitleStackView1)
        pictureAndtitleStackView1.addArrangedSubview(picture1)
        pictureAndtitleStackView1.addArrangedSubview(title1)
        containerStackView.addArrangedSubview(pictureAndtitleStackView2)
        pictureAndtitleStackView2.addArrangedSubview(picture2)
        pictureAndtitleStackView2.addArrangedSubview(title2)
        containerStackView.addArrangedSubview(pictureAndtitleStackView3)
        pictureAndtitleStackView3.addArrangedSubview(picture3)
        pictureAndtitleStackView3.addArrangedSubview(title3)
        containerStackView.addArrangedSubview(pictureAndtitleStackView4)
        pictureAndtitleStackView4.addArrangedSubview(picture4)
        pictureAndtitleStackView4.addArrangedSubview(title4)
        containerStackView.addArrangedSubview(pictureAndtitleStackView5)
        pictureAndtitleStackView5.addArrangedSubview(picture5)
        pictureAndtitleStackView5.addArrangedSubview(title5)
    }
    
    private func constraintUI() {
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
        ])
    }
    
    private func setImage(for url: [String]) {
        if let url = URL(string: url[0]) {
            self.picture1.sd_setImage(with: url)
        }
        if let url = URL(string: url[1]) {
            self.picture2.sd_setImage(with: url)
        }
        if let url = URL(string: url[2]) {
            self.picture3.sd_setImage(with: url)
        }
        if let url = URL(string: url[3]) {
            self.picture4.sd_setImage(with: url)
        }
        if let url = URL(string: url[4]) {
            self.picture5.sd_setImage(with: url)
        }
    }
}
