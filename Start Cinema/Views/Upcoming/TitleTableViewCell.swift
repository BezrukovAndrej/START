//
//  TitleTableViewCell.swift
//  Start Cinema
//
//  Created by Andrey Bezrukov on 27.10.2023.
//

import UIKit
import SDWebImage

final class TitleTableViewCell: UITableViewCell {
    
    static let identifier = Constants.identifierUpcomingCell
    
    private let titlePousterUIimageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        return label
    }()
    
    private let playTitleButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        button.tintColor = .label
        button.setImage(image, for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: TitleViewModel) {
        guard let url = URL(string: "\(Constants.configureCellImage)\(model.posterURL)") else { return }
        titlePousterUIimageView.sd_setImage(with: url, completed: nil)
        titleLabel.text = model.titleName
    }
    
    private func addSubviews() {
        contentView.backgroundColor = .stBlack
        [titlePousterUIimageView, titleLabel, playTitleButton].forEach{ contentView.addViewWithNoTAMIC($0)}
    }
    
    private func setConstraints() {
        titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        NSLayoutConstraint.activate([
            titlePousterUIimageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titlePousterUIimageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            titlePousterUIimageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            titlePousterUIimageView.widthAnchor.constraint(equalToConstant: 100),
            
            titleLabel.leadingAnchor.constraint(equalTo: titlePousterUIimageView.trailingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: playTitleButton.trailingAnchor, constant: -30),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            playTitleButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            playTitleButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
}
