//
//  UIBlockingProgressHUD.swift
//  Start Cinema
//
//  Created by Andrey Bezrukov on 01.11.2023.
//

import UIKit
import ProgressHUD

final class UIBlockingProgressHUD {
    private static var window: UIWindow? {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            return windowScene.windows.first
        }
        return nil
    }
    
    static func show() {
        window?.isUserInteractionEnabled = false
        ProgressHUD.colorHUD = .clear
        ProgressHUD.colorAnimation = .stRed
        ProgressHUD.animate("LOADING".localized)
    }
    
    static func dismiss() {
        window?.isUserInteractionEnabled = true
        ProgressHUD.dismiss()
    }
}

