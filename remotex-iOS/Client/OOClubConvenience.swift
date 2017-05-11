//
//  OOClubConvenience.swift
//  remotex-iOS
//
//  Created by archimboldi on 10/05/2017.
//  Copyright © 2017 me.archimboldi. All rights reserved.
//

import Foundation

func parseLatestPage(withURL: URL) -> Resource<JobPageModel> {
    let parse = Resource<JobPageModel>(url: withURL, parseJSON: { jsonData in
        guard let json = jsonData as? JSONDictionary, let jobs = json["data"] as? [JSONDictionary] else { return .failure(.errorParsingJSON) }
        
        guard let model = JobPageModel(dictionary: json, jobsArray: jobs.flatMap(JobModel.init)) else { return .failure(.errorParsingJSON) }
        
        return .success(model)
    })
    return parse
}
