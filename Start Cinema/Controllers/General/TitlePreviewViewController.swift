//
//  TitlePreviewViewController.swift
//  Start Cinema
//
//  Created by Andrey Bezrukov on 29.10.2023.
//

import UIKit
import WebKit

final class TitlePreviewViewController: UIViewController {
    
    private let webView: WKWebView = WKWebView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    private let downloadButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .stRed
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.setTitle("DOWNLOAD_BUTTON".localized, for: .normal)
        button.setTitleColor(.stWhite, for: .normal)
        return button
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = .stBlack
        return scroll
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        setConstraints()
    }
    
    func configure(with model: TitlePreviewViewModel) {
        titleLabel.text = model.title
        overviewLabel.text = model.titleOverview
        
        guard let url = URL(string: "\(Constants.youTubeSearchId)\(model.youtubeView.id.videoId)") else { return }
        webView.load(URLRequest(url: url))
    }
}

// MARK: - Add subviews / Set constraints

extension TitlePreviewViewController {
    
    private func addSubviews() {
        view.backgroundColor = .stBlack
        view.addViewWithNoTAMIC(scrollView)
        [webView, titleLabel,
         overviewLabel, downloadButton].forEach{ scrollView.addViewWithNoTAMIC($0) }
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            webView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            webView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            webView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -10),
            webView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20),
            webView.heightAnchor.constraint(equalToConstant: 250),
            
            titleLabel.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            overviewLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            overviewLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            
            downloadButton.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 20),
            downloadButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
            downloadButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            downloadButton.widthAnchor.constraint(equalToConstant: 140),
            downloadButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}
