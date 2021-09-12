//
//  NewsFeedViewController.swift
//  VKNewsFeed
//
//  Created by Zhanibek Lukpanov on 15.10.2020.
//  Copyright (c) 2020 Zhanibek Lukpanov. All rights reserved.
//

import UIKit

protocol NewsFeedDisplayLogic: AnyObject {
  func displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData)
}

class NewsFeedViewController: UIViewController, NewsFeedDisplayLogic, NewsFeedCodeCellDelegate {

    var interactor: NewsFeedBusinessLogic?
    var router: (NSObjectProtocol & NewsFeedRoutingLogic)?
    
    private var feedModelView = FeedViewModel.init(cells: [])
    
    private var titleView = TittleView()
    
    private var refreshControll: UIRefreshControl = {
       let refreshControll = UIRefreshControl()
        refreshControll.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControll
    }()
    
    @IBOutlet weak var table: UITableView!
    
    // MARK:- Setup
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
    
  // MARK:- Routing
  
  
  // MARK:- View lifecycle
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupTopBar()
        configureNewsFeedTableView()
        interactor?.makeRequest(request: .getNewsFeed)
        interactor?.makeRequest(request: .getUser)
    }
    
    private func setupTopBar() {
        self.navigationController?.hidesBarsOnSwipe = true
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.titleView = titleView
    }
    
    @objc private func refresh() {
        interactor?.makeRequest(request: .getNewsFeed)
    }

    private func configureNewsFeedTableView() {
        
        let topInset: CGFloat = 8
        table.contentInset.top = topInset
    
        table.register(NewsFeedCodeCell.self, forCellReuseIdentifier: NewsFeedCodeCell.reuseId)
        table.separatorStyle = .none
        table.backgroundColor = .clear
        view.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        table.tableFooterView = UIView(frame: CGRect.zero)
        table.addSubview(refreshControll)
    }
    
    func displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .showFeed(let feedViewModel):
            self.feedModelView = feedViewModel
            table.reloadData()
            refreshControll.endRefreshing()
        case .displayUser(userViewModel: let userViewModel):
            titleView.set(userModel: userViewModel)
        }
    }
    
    func revealPost(for cell: NewsFeedCodeCell) {
        guard let indexPath = table.indexPath(for: cell) else { return }
        let cellViewModel = feedModelView.cells[indexPath.row]
        print("Delegate test")
        interactor?.makeRequest(request: .revealPostId(postID: cellViewModel.postID))
    }
    
}

// MARK:- UITableViewDelegate, UITableViewDataSource
extension NewsFeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedModelView.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedCodeCell.reuseId, for: indexPath) as! NewsFeedCodeCell

        let cellViewModel = feedModelView.cells[indexPath.row]
        cell.setCell(viewModel: cellViewModel)
        
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellViewModel = feedModelView.cells[indexPath.row]
        return cellViewModel.sizes.totalHeight
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellViewModel = feedModelView.cells[indexPath.row]
        return cellViewModel.sizes.totalHeight
    }
    
}
