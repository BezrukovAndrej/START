//
//  CollectionViewTableViewCell.swift
//  Start Cinema
//
//  Created by Andrey Bezrukov on 23.10.2023.
//

import UIKit

protocol CollectionViewTableViewCellDelegate: AnyObject {
    func collectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell,
                                               viewModel: TitlePreviewViewModel)
}

final class CollectionViewTableViewCell: UITableViewCell {
    
    static let identifier = Constants.identifierTableCell
    weak var delegate: CollectionViewTableViewCellDelegate?
    private var titles: [Title] = []
    var allImageLoadedCallback: (() -> Void)?
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 140, height: 200)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addViewWithNoTAMIC(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        collectionView.frame = contentView.bounds
    }
    
    public func configure(with titles: [Title]) {
        self.titles = titles
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
            self?.allImageLoadedCallback?()
        }
    }
    
    private func downloadTitleAt(indexPath: IndexPath) {
        DataPersistenceManager.shared.downloadTitleWith(model: titles[indexPath.row]) { result in
            switch result {
            case .success():
                NotificationCenter.default.post(
                    name: NSNotification.Name(Constants.notificationName),
                    object: nil)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - UICollectionViewDelegate / UICollectionViewDelegate

extension CollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return titles.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else { return UICollectionViewCell() }
        guard let model = titles[indexPath.row].poster_path else { return UICollectionViewCell() }
        cell.configure(with: model)
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let title = titles[indexPath.row]
        guard let titleName = title.original_title ?? title.original_name else { return }
        
        ApiCaller.shared.getMoview(with: titleName + Constants.trailer) { [weak self] result in
            switch result {
            case .success(let videoElement):
                let title = self?.titles[indexPath.row]
                guard let titleOverview = title?.overview else { return }
                guard let strongSelf = self else { return }
                
                let viewModel = TitlePreviewViewModel(
                    title: titleName,
                    youtubeView: videoElement,
                    titleOverview: titleOverview)
                
                self?.delegate?.collectionViewTableViewCellDidTapCell(strongSelf,
                                                                      viewModel: viewModel)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, 
                        contextMenuConfigurationForItemAt indexPath: IndexPath,
                        point: CGPoint
    ) -> UIContextMenuConfiguration? {
        let config = UIContextMenuConfiguration(
            identifier: nil,
            previewProvider: nil) { [weak self] _ in
            let downloadAction = UIAction(title: "DOWNLOAD_CONTEXT_MENU".localized,
                                          image: UIImage.IconMainMar.downloadsIamge,
                                          state: .off) { _ in
                self?.downloadTitleAt(indexPath: indexPath)
            }
            return UIMenu(options: .displayInline, children: [downloadAction])
        }
        return config
    }
}
