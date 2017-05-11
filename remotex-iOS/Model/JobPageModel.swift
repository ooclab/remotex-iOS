//
//  JobPageModel.swift
//  remotex-iOS
//
//  Created by archimboldi on 10/05/2017.
//  Copyright © 2017 me.archimboldi. All rights reserved.
//

import Foundation

class JobPageModel: NSObject {

    let page: Int
    let pageSize: Int
    let totalNumberOfItems: Int
    let jobs: [JobModel]
    
    init?(dictionary: JSONDictionary, jobsArray: [JobModel]) {
        guard let totalItems = dictionary["total"] as? Int, let filter = dictionary["filter"] as? JSONDictionary, let page = filter["current_page"] as? Int, let pageSize = filter["page_size"] as? Int else {
            print("error parsing JSON with JobPageModel init")
            return nil
        }
        self.page = page
        self.pageSize = pageSize
        self.totalNumberOfItems = totalItems
        self.jobs = jobsArray
    }
}
