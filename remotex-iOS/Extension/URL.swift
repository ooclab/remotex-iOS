//
//  URL.swift
//  remotex-iOS
//
//  Created by archimboldi on 10/05/2017.
//  Copyright © 2017 me.archimboldi. All rights reserved.
//

import Foundation

enum JobSortParameter {
    case jobID
    case price
    case createdAt
    case updatedAt
    case releaseAt
    case expireAt
    case viewCount
    case voteUp
    case voteDown
}

enum SortDirection {
    case desc
    case asc
}

extension URL {
    static func URLForFeed() -> URL {
        return URL(string: "https://remotex.ooclab.org/api/jobx/job?")!
    }
    
    static func URLForJob(withID id: Int) -> URL {
        return URL(string: "https://remotex.ooclab.org/api/jobx/job/\(id)")!
    }
    
    static func URLForJobRedirect(withID id: Int) -> URL {
        return URL(string: "https://remotex.ooclab.org/api/jobx/job/\(id)/url")!
    }
    
    // https://remotex.ooclab.org/api/jobx/job?sb=release_date&sd=desc&lm=10&p=4
    mutating func addSortParameterWithPage(sortParameter: JobSortParameter, sortDirection: SortDirection, page: Int) -> URL {
        var parameter = ""
        var direction = ""
        switch sortParameter {
        case .jobID:
            parameter = "id"
        case .price:
            parameter = "price"
        case .createdAt:
            parameter = "created"
        case .updatedAt:
            parameter = "updated"
        case .releaseAt:
            parameter = "release_date"
        case .expireAt:
            parameter = "expire_date"
        case .viewCount:
            parameter = "view_count"
        case .voteUp:
            parameter = "vote_up"
        case .voteDown:
            parameter = "vote_down"
        }
        
        switch sortDirection {
        case .desc:
            direction = "desc"
        case .asc:
            direction = "asc"
        }
        var urlString = self.absoluteString
        urlString.append("sb=\(parameter)&sd=\(direction)&lm=10&p=\(page)")
        return URL(string: urlString)!
    }
    
    mutating func addPageParameter(page: Int) -> URL {
        var urlString = self.absoluteString
        urlString.append("lm=10&p=\(page)")
        return URL(string: urlString)!
    }
    
    static func URLForRemoteXiOSGitHub() -> URL {
        return URL(string: "https://github.com/ooclab/remotex-ios")!
    }
    
    static func URLForRemoteXiOSContributors() -> URL {
        return URL(string: "https://github.com/ooclab/remotex-iOS/graphs/contributors")!
    }
    
    static func URLForRemoteXWebSite() -> URL {
        return URL(string: "https://remotex.ooclab.org")!
    }
    
    static func URLForCreatorGitHub() -> URL {
        return URL(string: "https://github.com/ArchimboldiMao/")!
    }
    
    static func URLForRemoteXSlack() -> URL {
        return URL(string: "https://remotex.slack.com")!
    }
    
    static func URLForRemoteXEMail() -> URL {
        return URL(string: "mailto:admin@ooclab.org")!
    }
}
