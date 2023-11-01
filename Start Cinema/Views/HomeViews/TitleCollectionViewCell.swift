//
//  TitleCollectionViewCell.swift
//  Start Cinema
//
//  Created by Andrey Bezrukov on 25.10.2023.
//

import UIKit
import SDWebImage

final class TitleCollectionViewCell: UICollectionViewCell {
    
    static let identifier = Constants.identifierViewCell
    private var gradientViews = Set<UIView>()
    private var numberOfImagesBeingLoaded = 0
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViewWithNoTAMIC(posterImageView)
        setConstraints()
        createGradient()
    }
    
    override func prepareForReuse() {
        createGradient()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    public func configure(with model: String) {
        numberOfImagesBeingLoaded += 1
        guard let url = URL(string: "\(Constants.configureCellImage)\(model)") else {
            handleImageLoadCompletion()
            return
        }
        posterImageView.sd_setImage(with: url) { [weak self] (_, _, _, _) in
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
        let imageView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 140, height: 200)))
        imageView.applyGradientWithAnimation()
        gradientViews.insert(imageView)
        
        posterImageView.addViewWithNoTAMIC(imageView)
    }
    
    private func removeGradient() {
        gradientViews.forEach { $0.removeGradientWithAnimation()}
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
