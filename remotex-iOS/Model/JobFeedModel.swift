//
//  JobFeedModel.swift
//  remotex-iOS
//
//  Created by archimboldi on 10/05/2017.
//  Copyright © 2017 me.archimboldi. All rights reserved.
//

import Foundation

final class JobFeedModel {
    public private(set) var jobs: [JobModel] = []
    private var url: URL
    private var ids: [Int] = []
    private var currentPage: Int = 0
    private var pageSize: Int = 0
    public private(set) var totalItems: Int = 0
    private var fetchPageInProgress: Bool = false
    private var refreshFeedInProgress: Bool = false
    
    init() {
        self.url = URL.URLForFeed()
    }
    
    var numberOfItemsInFeed: Int {
        return jobs.count
    }
    
    func refreshNewBatchOfLatestJobs(additionsAndConnectionStatusCompletion: @escaping (Int, InternetStatus) -> ()) {
        guard !fetchPageInProgress else { return }
        
        fetchPageInProgress = true
        self.currentPage = 0
        fetchNextPageOfLatestJobs(replaceData: true) { [unowned self] additions, errors in
            self.fetchPageInProgress = false
            
            if let error = errors {
                switch error {
                case .noInternetConnection:
                    additionsAndConnectionStatusCompletion(0, .noConnection)
                default:
                    additionsAndConnectionStatusCompletion(0, .connected)
                }
            } else {
                additionsAndConnectionStatusCompletion(additions, .connected)
            }
        }
    }
    
    func updateNewBatchOfLatestJobs(additionsAndConnectionStatusCompletion: @escaping (Int, InternetStatus) -> ()) {
        guard !fetchPageInProgress else { return }
        
        fetchPageInProgress = true
        
        fetchNextPageOfLatestJobs(replaceData: false) { [unowned self] additions, errors in
            self.fetchPageInProgress = false
            
            if let error = errors {
                switch error {
                case .noInternetConnection:
                    additionsAndConnectionStatusCompletion(0, .noConnection)
                default:
                    additionsAndConnectionStatusCompletion(0, .connected)
                }
            } else {
                additionsAndConnectionStatusCompletion(additions, .connected)
            }
        }
    }
    
    
    private func fetchNextPageOfLatestJobs(replaceData: Bool, numberOfAdditionsCompletion: @escaping (Int, NetworkingErrors?) -> ()) {
        
        if currentPage * pageSize >= totalItems, currentPage != 0 {
            return numberOfAdditionsCompletion(0, .customError("No pages left to parse"))
        }
        
        var newJobs: [JobModel] = []
        var newIDs: [Int] = []
        
        let pageToFetch = currentPage + 1
        
        let url = self.url.addSortParameterWithPage(sortParameter: .releaseAt, sortDirection: .desc, page: pageToFetch)
        WebService().load(resource: parseLatestPage(withURL: url)) { [unowned self] result in
            switch result {
            case .success(let latestPage):
                self.totalItems = latestPage.totalNumberOfItems
                self.pageSize = latestPage.pageSize
                self.currentPage = latestPage.page
                for job in latestPage.jobs {
                    if replaceData {
                        newJobs.append(job)
                        newIDs.append(job.jobID)
                    } else if !self.ids.contains(job.jobID) {
                        newJobs.append(job)
                        newIDs.append(job.jobID)
                    }
                }
                
                DispatchQueue.main.async {
                    if replaceData {
                        self.jobs = newJobs
                        self.ids = newIDs
                    } else {
                        self.jobs += newJobs
                        self.ids += newIDs
                    }
                    numberOfAdditionsCompletion(newJobs.count, nil)
                }
            case .failure(let fail):
                print(fail)
                numberOfAdditionsCompletion(0, fail)
            }
        }
    }
}

enum InternetStatus {
    case connected
    case noConnection
}
