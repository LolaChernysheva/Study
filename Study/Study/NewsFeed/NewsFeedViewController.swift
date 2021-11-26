//
//  NewsFeedViewController.swift
//  Study
//
//  Created by Лолита Чернышева on 15.10.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import SnapKit

protocol NewsFeedDisplayLogic: class {
    func displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData)
}

class NewsFeedViewController: UIViewController, NewsFeedDisplayLogic, NewsFeedCellDelegate {

    var tableView = UITableView()
    
    var interactor: NewsFeedBusinessLogic?
    var router: (NSObjectProtocol & NewsFeedRoutingLogic)?
    private var feedViewModel = FeedViewModel.init(cells: [])
    private var titleView = TitleView()
    private var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController        = self
        let interactor            = NewsFeedInteractor()
        let presenter             = NewsFeedPresenter()
        let router                = NewsFeedRouter()
        viewController.interactor = interactor
        viewController.router     = router
        interactor.presenter      = presenter
        presenter.viewController  = viewController
        router.viewController     = viewController
    }
    
    // MARK: Routing
    
    
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.setUpConstraints()
        setUpTopBars()
        setUpTable()
        
        
        interactor?.makeRequest(request: NewsFeed.Model.Request.RequestType.getNewsFeed)
        interactor?.makeRequest(request: NewsFeed.Model.Request.RequestType.getUser)
    }
    
    func displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .displayNewsFeed(let feedViewModel):
            self.feedViewModel = feedViewModel
            tableView.reloadData()
            refreshControl.endRefreshing()
        case .displayUser(userViewModel: let userViewModel):
            titleView.set(userViewModel: userViewModel)
        }
        
    }
    
    @objc private func refresh() {
        interactor?.makeRequest(request: NewsFeed.Model.Request.RequestType.getNewsFeed)
    }
    
    private func setUpTable() {
        let topInset: CGFloat = 8
        tableView.contentInset.top = topInset
        
        tableView.register(NewsFeedTableViewCell.self, forCellReuseIdentifier: NewsFeedTableViewCell.reusedId)
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.addSubview(refreshControl)
    }
    
    private func setUpTopBars() {
        //бар будет появяться, когда лента будет листаться вверх и скрываться при опускании
        self.navigationController?.hidesBarsOnSwipe = true
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.titleView = titleView
    }
    
    private func setUpConstraints() {
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { maker in
            maker.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    //MARK: NewsFeedCellDelegate
    func revealPost(for cell: NewsFeedTableViewCell) {
        //получаем номер ячейки, текст которой хотим раскрыть
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        //получение доступа ко всей информации ячейки, текст которой хотим раскрыть
        let cellViewModel = feedViewModel.cells[indexPath.row]
        interactor?.makeRequest(request: NewsFeed.Model.Request.RequestType.revealPostIds(postId: cellViewModel.postId))
    }
    
}

extension NewsFeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedTableViewCell.reusedId, for: indexPath) as! NewsFeedTableViewCell
        let cellViewModel = feedViewModel.cells[indexPath.row]
        cell.set(viewModel: cellViewModel)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedViewModel.cells.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellViewModel = feedViewModel.cells[indexPath.row]
        return cellViewModel.sizes.totalHeight
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellViewModel = feedViewModel.cells[indexPath.row]
        return cellViewModel.sizes.totalHeight
    }
}
