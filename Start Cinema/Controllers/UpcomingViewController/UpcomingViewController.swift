//
//  UpcomingViewController.swift
//  Start Cinema
//
//  Created by Andrey Bezrukov on 23.10.2023.
//

import UIKit

final class UpcomingViewController: UIViewController {
    
    var titles: [Title] = [Title]()
    let upcomingTable = UITableView(frame: .zero, style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addViewWithNoTAMIC(upcomingTable)
        setupUpcomingView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        upcomingTable.frame = view.bounds
    }
}
