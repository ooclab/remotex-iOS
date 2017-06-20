//
//  JobFeedTableNodeController.swift
//  remotex-iOS
//
//  Created by archimboldi on 10/05/2017.
//  Copyright © 2017 me.archimboldi. All rights reserved.
//

import AsyncDisplayKit
import StoreKit

class JobFeedTableNodeController: ASViewController<ASTableNode> {
    
    var statusBarNode: ASDisplayNode!
    var activityIndicator: UIActivityIndicatorView!
    var refreshControl: UIRefreshControl!
    var jobFeed: JobFeedModel
    var batchContext: ASBatchContext?
    
    init() {
        jobFeed = JobFeedModel()
        super.init(node: ASTableNode())
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRefreshControl()
        node.backgroundColor = Constants.TableLayout.BackgroundColor
        node.view.separatorStyle = .none
        node.allowsSelection = true
        node.delegate = self
        node.dataSource = self
        
        setupNavigation()
        
        self.registerForPreviewing(with: self as UIViewControllerPreviewingDelegate, sourceView: self.view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupActivityIndicator()
        setupStatusBar()
    }
    
    func setupNavigation() {
        self.navigationItem.title = "RemoteX"
        let infoButton = UIButton.init(type: .infoLight)
        infoButton.addTarget(self, action: #selector(presentAboutViewController), for: .touchUpInside)
        let rightBarItem = UIBarButtonItem.init(customView: infoButton)
        self.navigationItem.setRightBarButton(rightBarItem, animated: true)
        navigationController?.hidesBarsOnSwipe = true
    }
    
    func setupStatusBar() {
        let statusBarNode = ASDisplayNode()
        self.statusBarNode = statusBarNode
        statusBarNode.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 20)
        statusBarNode.backgroundColor = Constants.NavigationBarLayout.StatusBarBackgroundColor
        statusBarNode.layer.zPosition = 1.0
        statusBarNode.isHidden = !UIDevice.current.orientation.isPortrait
        self.view.superview?.addSubnode(self.statusBarNode)
        
    }
    
    func setupActivityIndicator() {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        self.activityIndicator = activityIndicator
        let bounds = self.node.frame
        var refreshRect = activityIndicator.frame
        refreshRect.origin = CGPoint(x: (bounds.size.width - activityIndicator.frame.size.width) / 2, y: (bounds.size.height - activityIndicator.frame.size.height) / 2)
        activityIndicator.frame = refreshRect
        self.node.view.addSubview(activityIndicator)
    }
    
    func presentAboutViewController() {
        let viewController = AboutViewController()
        let navigationController = UINavigationController.init(rootViewController: viewController)
        self.present(navigationController, animated: true, completion: nil)
    }
    
    func setupRefreshControl() {
        let refreshControl = UIRefreshControl.init()
        self.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshTableNode), for: UIControlEvents.valueChanged)
        self.node.view.addSubview(refreshControl)
    }
    
    func refreshTableNode() {
        // When table's dataSource is empty, and shouldBatchFetch is true, touch tableNode will trigger fetchNewBacthWithContext(context), thus ignore refresh.
        if self.jobFeed.numberOfItemsInFeed == 0 {
            self.refreshControl.endRefreshing()
            return
        }
        self.refreshControl.beginRefreshing()
        jobFeed.refreshNewBatchOfLatestJobs() { additions, connectionStatus in
            switch connectionStatus {
            case .connected:
                DispatchQueue.main.async {
                    self.refreshControl.endRefreshing()
                }
                self.node.reloadData()
                self.batchContext?.completeBatchFetching(true)
            case .noConnection:
                DispatchQueue.main.async {
                    self.refreshControl.endRefreshing()
                }
                PromptMessageWrap.show(withMessage: Constants.MessageDescription.NoInternetConnection)
                if self.batchContext != nil {
                    self.batchContext?.completeBatchFetching(true)
                }
                
                break
            }
        }
    }
    
    func fetchNewBacthWithContext(_ context: ASBatchContext?) {
        self.activityIndicator.startAnimating()
        jobFeed.updateNewBatchOfLatestJobs() { additions, connectionStatus in
            switch connectionStatus {
            case .connected:
                self.activityIndicator.stopAnimating()
                self.addRowsIntoTableNode(newJobCount: additions)
                context?.completeBatchFetching(true)
                if self.jobFeed.numberOfItemsInFeed > 30 && self.jobFeed.numberOfItemsInFeed <= 40 {
                    self.requestReview()
                }
            case .noConnection:
                self.activityIndicator.stopAnimating()
                PromptMessageWrap.show(withMessage: Constants.MessageDescription.NoInternetConnection)
                if context != nil {
                    context?.completeBatchFetching(true)
                }
                
                break
            }
        }
    }
    
    func addRowsIntoTableNode(newJobCount newJobs: Int) {
        if newJobs > 0 {
            let indexRange = (jobFeed.jobs.count - newJobs..<jobFeed.jobs.count)
            let indexPaths = indexRange.map { IndexPath(row: $0, section: 0)}
            node.insertRows(at: indexPaths, with: .none)
        }
    }
}

extension JobFeedTableNodeController: ASTableDelegate, ASTableDataSource {
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return jobFeed.jobs.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let job = jobFeed.jobs[indexPath.row]
        let nodeBlock: ASCellNodeBlock = { _ in
            return JobTableNodeCell(jobModel: job)
        }
        return nodeBlock
    }
    
    func shouldBatchFetch(for tableNode: ASTableNode) -> Bool {
        return true
    }
    
    func tableNode(_ tableNode: ASTableNode, willBeginBatchFetchWith context: ASBatchContext) {
        self.batchContext = context
        fetchNewBacthWithContext(context)
    }
    
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        let job = jobFeed.jobs[indexPath.row]
        let jobTitle = job.jobTitle
        let jobID = job.jobID
        let url = URL.URLForJobRedirect(withID: jobID)
        let jobViewController = JobWebViewController.init(withURL: url, withTitle: jobTitle)
        self.navigationController?.pushViewController(jobViewController, animated: true)
        tableNode.deselectRow(at: indexPath, animated: false)
    }
}

// Support 3D Touch
extension JobFeedTableNodeController: UIViewControllerPreviewingDelegate {
    public func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        if let indexPath = self.node.indexPathForRow(at: location) {
            let job = jobFeed.jobs[indexPath.row]
            let jobTitle = job.jobTitle
            let jobID = job.jobID
            let url = URL.URLForJobRedirect(withID: jobID)
            let jobViewController = JobWebViewController.init(withURL: url, withTitle: jobTitle)
            return jobViewController
        } else {
            return nil
        }
        
    }
    
    public func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        self.navigationController?.pushViewController(viewControllerToCommit, animated: true)
    }
    
}

// Portrait and Landscape
extension JobFeedTableNodeController {
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isPortrait {
            if self.statusBarNode == nil {
                setupStatusBar()
            }
            self.statusBarNode.isHidden = false
            self.activityIndicator.center = CGPoint.init(x: min(self.node.frame.size.width, self.node.frame.size.height) / 2, y: max(self.node.frame.size.width, self.node.frame.size.height) / 2)
        } else {
            self.statusBarNode.isHidden = true
            self.activityIndicator.center = CGPoint.init(x: max(self.node.frame.size.width, self.node.frame.size.height) / 2, y: min(self.node.frame.size.width, self.node.frame.size.height) / 2)
        }
    }
}

// request Review and rate
extension JobFeedTableNodeController {
    public func requestReview() {
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
        } else {
            // Fallback on earlier versions
        }
    }
}
