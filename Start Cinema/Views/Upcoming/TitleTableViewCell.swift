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
    private var gradientViews = Set<UIView>()
    private var numberOfImagesBeingLoaded = 0
    
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
        var image = UIImage.IconMainMar.playCircle
        image?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 30))
        button.tintColor = .label
        button.setImage(image, for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        setConstraints()
        createGradient()
    }
    
    override func prepareForReuse() {
        createGradient()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: TitleViewModel) {
        numberOfImagesBeingLoaded += 1
        guard let url = URL(string: "\(Constants.configureCellImage)\(model.posterURL)") else {
            handleImageLoadCompletion()
            return
        }
        titlePousterUIimageView.sd_setImage(with: url) { [weak self] (_, _, _, _) in
            self?.titleLabel.text = model.titleName
            self?.handleImageLoadCompletion()
        }
    }
    
    private func handleImageLoadCompletion() {
        numberOfImagesBeingLoaded -= 1
        
        if numberOfImagesBeingLoaded == 0 {
            removeGradient()
        }
    }
    
    private func createGradient() {
        let imageView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 140)))
            imageView.applyGradientWithAnimation()
            gradientViews.insert(imageView)
        
        titlePousterUIimageView.addViewWithNoTAMIC(imageView)
    }
    
    private func removeGradient() {
        gradientViews.forEach { $0.removeGradientWithAnimation() }
    }
    
    private func addSubviews() {
        contentView.backgroundColor = .stBlack
        [titlePousterUIimageView, titleLabel, playTitleButton].forEach{ contentView.addViewWithNoTAMIC($0) }
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
