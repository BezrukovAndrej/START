//
//  UIView + Extensions.swift
//  Start Cinema
//
//  Created by Andrey Bezrukov on 23.10.2023.
//

import UIKit

extension UIView {
    func addViewWithNoTAMIC(_ views: UIView) {
        self.addSubview(views)
        views.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func applyGradientWithAnimation() {
        let gradient = CAGradientLayer()
        gradient.locations = [0, 0.1, 0.3]
        gradient.colors = [
            UIColor(red: 1.0, green: 0.678, blue: 0.569, alpha: 1).cgColor,
            UIColor(red: 0.682, green: 0.686, blue: 0.706, alpha: 1).cgColor,
            UIColor(red: 0.702, green: 0.201, blue: 0.133, alpha: 1).cgColor
        ]
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        
        gradient.frame = self.bounds
        gradient.cornerRadius = self.layer.cornerRadius
        gradient.masksToBounds = true
        
        let animation = gradientChangeAnimation()
        gradient.add(animation, forKey: "locationsChange")
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    private func gradientChangeAnimation() -> CABasicAnimation {
        let gradientChangeAnimation = CABasicAnimation(keyPath: "locations")
        gradientChangeAnimation.duration = 1.0
        gradientChangeAnimation.repeatCount = .infinity
        gradientChangeAnimation.fromValue = [0, 0.1, 0.3]
        gradientChangeAnimation.toValue = [0, 0.8, 1]
        return gradientChangeAnimation
    }
    
    func removeGradientWithAnimation() {
        guard let gradientLayer = self.layer.sublayers?.compactMap({
            $0 as? CAGradientLayer
        }).first else { return }
        gradientLayer.removeFromSuperlayer()
    }
}
