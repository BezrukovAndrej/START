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
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViewWithNoTAMIC(posterImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        posterImageView.frame = contentView.bounds
        cornerRadiusView()
    }
    
    private func cornerRadiusView() {
        let maskPath = UIBezierPath(roundedRect: posterImageView.bounds,
                                    byRoundingCorners: [.topLeft, .topRight, .bottomLeft, .bottomRight],
                                    cornerRadii: CGSize(width: 10.0, height: 10.0))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = posterImageView.bounds
        maskLayer.path = maskPath.cgPath
        posterImageView.layer.mask = maskLayer
    }
    
    public func configure(with model: String) {
        guard let url = URL(string: "\(Constants.configureCellImage)\(model)") else { return }
        posterImageView.sd_setImage(with: url)
    }
}
