//
//  HeroHeaderUIView.swift
//  Start Cinema
//
//  Created by Andrey Bezrukov on 23.10.2023.
//

import UIKit

final class HeroHeaderUIView: UIView {
    
    private var gradientViews = Set<UIView>()
    private var numberOfImagesBeingLoaded = 0
    
    private let heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let playButton: UIButton = {
        let button = UIButton()
        button.setTitle("PLAY".localized, for: .normal)
        button.setTitleColor(UIColor.stWhite, for: .normal)
        button.layer.borderColor = UIColor.stWhite.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        return button
    }()
    
    private let downloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("DOWNLOAD".localized, for: .normal)
        button.setTitleColor(UIColor.stWhite, for: .normal)
        button.layer.borderColor = UIColor.stWhite.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        return button
    }()
    
    private let gradientLayer: CAGradientLayer = {
            let gradientLayer = CAGradientLayer()
            return gradientLayer
        }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        setConstraints()
        createGradient()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        heroImageView.frame = bounds
        gradientLayer.frame = bounds
        
        addGradient()
        
        bringSubviewToFront(playButton)
        bringSubviewToFront(downloadButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        playButton.layer.borderColor = UIColor.stWhite.cgColor
        downloadButton.layer.borderColor = UIColor.stWhite.cgColor
        
        addGradient()
    }
    
    public func configure(with model: TitleViewModel) {
        numberOfImagesBeingLoaded += 1
        guard let url = URL(string: "\(Constants.configureCellImage)\(model.posterURL)") else {
            handleImageLoadCompletion()
            return
        }
        heroImageView.sd_setImage(with: url) { [weak self] (_, _, _, _) in
            self?.handleImageLoadCompletion()
         }
    }
    
    private func addGradient() {
        if traitCollection.userInterfaceStyle == .dark {
            gradientLayer.colors = [
                UIColor.clear.cgColor,
                UIColor.systemBackground.cgColor
            ]
        } else {
            gradientLayer.colors = [
                UIColor.clear.cgColor,
                UIColor.white.cgColor
            ]
        }
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
    
    private func handleImageLoadCompletion() {
        numberOfImagesBeingLoaded -= 1
        
        if numberOfImagesBeingLoaded == 0 {
            removeGradient()
        }
    }
    
    private func createGradient() {
        let imageView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 400, height: 550)))
            imageView.applyGradientWithAnimation()
            gradientViews.insert(imageView)
        
        heroImageView.addViewWithNoTAMIC(imageView)
    }
    
    private func removeGradient() {
        gradientViews.forEach { $0.removeGradientWithAnimation()}
    }
}

// MARK: - Add subviews / Set constraints

extension HeroHeaderUIView {
    
    private func addSubviews() {
        [heroImageView, playButton, downloadButton].forEach{ addViewWithNoTAMIC($0) }
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            playButton.widthAnchor.constraint(equalToConstant: 120),
            
            downloadButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            downloadButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            downloadButton.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
}
