//
//  UpcomingViewController.swift
//  Start Cinema
//
//  Created by Andrey Bezrukov on 23.10.2023.
//

import UIKit

final class UpcomingViewController: UIViewController {
    
    private var titles: [Title] = []
   
    private let upcomingTable: UITableView = {
        let tebleView = UITableView(frame: .zero, style: .grouped)
        tebleView.register(TitleTableViewCell.self,forCellReuseIdentifier: TitleTableViewCell.identifier)
        return tebleView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addViewWithNoTAMIC(upcomingTable)
        setupUpcomingView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        upcomingTable.frame = view.bounds
    }
    
    private func setupUpcomingView() {
        
        view.backgroundColor = .stBlack
        upcomingTable.backgroundColor = .stBlack
        
        title = "UPCOMING".localized
        navigationController?.navigationBar.tintColor = .label
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        upcomingTable.separatorStyle = .none
        upcomingTable.showsVerticalScrollIndicator = false
        upcomingTable.delegate = self
        upcomingTable.dataSource = self
    
        fetchUpcoming()
    }
    
    private func fetchUpcoming() {
        ApiCaller.shared.getUpcomingMovies { [weak self] result in
            switch result {
            case .success(let titles):
                self?.titles = titles
                DispatchQueue.main.async {
                    self?.upcomingTable.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - UITableViewDelegate / UITableViewDataSource

extension UpcomingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, 
                   numberOfRowsInSection section: Int
    ) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, 
                   cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        guard let title = titles[indexPath.row].original_title else { return UITableViewCell() }
        guard let poster = titles[indexPath.row].poster_path else { return UITableViewCell() }
        cell.configure(with: TitleViewModel(titleName: title, posterURL: poster))
        return cell
    }
    
    func tableView(_ tableView: UITableView, 
                   heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, 
                   didSelectRowAt indexPath: IndexPath
    ) {
        let title = titles[indexPath.row]
        guard let titleName = title.original_title ?? title.original_name else { return }
        
        ApiCaller.shared.getMoview(with: titleName) { [weak self] result in
            switch result {
            case .success(let videoElement):
                DispatchQueue.main.async {
                    let vc = TitlePreviewViewController()
                    vc.configure(with: TitlePreviewViewModel(title: titleName,
                                                             youtubeView: videoElement,
                                                             titleOverview: title.overview ?? ""))
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
