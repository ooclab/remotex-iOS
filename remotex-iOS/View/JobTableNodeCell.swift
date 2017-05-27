//
//  JobTableNodeCell.swift
//  remotex-iOS
//
//  Created by archimboldi on 10/05/2017.
//  Copyright © 2017 me.archimboldi. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class JobTableNodeCell: ASCellNode {
    
    let jobTitleLabel = ASTextNode()
    let priceLabel = ASTextNode()
    let cityLabel = ASTextNode()
    var tagLabels: [ASTextNode] = []
    let abstractTextLabel = ASTextNode()
    let releaseAtLabel = ASTextNode()
    let expireAtLabel = ASTextNode()
    let viewCountLabel = ASTextNode()
    
    init(jobModel: JobModel) {
        super.init()
        
        self.jobTitleLabel.attributedText = jobModel.attrStringForTitle(withSize: Constants.CellLayout.TitleFontSize)
        self.priceLabel.attributedText = jobModel.attrStringForPrice(withSize: Constants.CellLayout.PriceFontSize)
        self.abstractTextLabel.attributedText = jobModel.attrStringForAbstractText(withSize: Constants.CellLayout.AbstractFontSize)
        
        if jobModel.cityName != nil && jobModel.cityName != "" {
            self.cityLabel.attributedText = jobModel.attrStringForCityName(withSize: Constants.CellLayout.TagFontSize)
            tagLabels.append(self.cityLabel)
        }
        if jobModel.categories != nil && (jobModel.categories?.count)! >= 1 {
            for category: CategoryModel in jobModel.categories! {
                let label = ASTextNode()
                label.attributedText = category.attrStringForCategoryName(withSize: Constants.CellLayout.TagFontSize)
                tagLabels.append(label)
            }
        }
        if jobModel.roles != nil && (jobModel.roles?.count)! >= 1 {
            for role: RoleModel in jobModel.roles! {
                let label = ASTextNode()
                label.attributedText = role.attrStringForRoleName(withSize: Constants.CellLayout.TagFontSize)
                tagLabels.append(label)
            }
        }
        if jobModel.skills != nil && (jobModel.skills?.count)! >= 1 {
            for skill: SkillModel in jobModel.skills! {
                let label = ASTextNode()
                label.attributedText = skill.attrStringForSkillName(withSize: Constants.CellLayout.TagFontSize)
                tagLabels.append(label)
            }
        }
        
        self.viewCountLabel.attributedText = jobModel.attrStringForViewCount(withSize: Constants.CellLayout.DateFontSize)
        self.releaseAtLabel.attributedText = jobModel.attrStringForReleaseAt(withSize: Constants.CellLayout.DateFontSize)
        self.expireAtLabel.attributedText = jobModel.attrStringForExpireAt(withSize: Constants.CellLayout.DateFontSize)
        self.automaticallyManagesSubnodes = true
        
        // Solutions to eliminate flashes caused by reloadData
        // https://github.com/facebookarchive/AsyncDisplayKit/issues/2536
        // http://texturegroup.org/docs/synchronous-concurrency.html
        self.neverShowPlaceholders = true
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        self.backgroundColor = UIColor.white
        
        let titleStack = ASStackLayoutSpec.horizontal()
        titleStack.justifyContent = ASStackLayoutJustifyContent.spaceBetween
        
        self.jobTitleLabel.style.alignSelf = .start
        self.jobTitleLabel.style.maxWidth = ASDimensionMakeWithFraction(0.85)
        self.jobTitleLabel.maximumNumberOfLines = 2
        
        self.priceLabel.style.alignSelf = .end
        self.priceLabel.style.minWidth = ASDimensionMakeWithFraction(0.15)
        
        titleStack.children = [self.jobTitleLabel, self.priceLabel]
        
        let tagStack = ASStackLayoutSpec.horizontal()
        tagStack.alignItems = .start
        tagStack.spacing = 8.0
        tagStack.flexWrap = .wrap  // allow multi lines
        tagStack.alignContent = .spaceAround
        for tagLabel in self.tagLabels {
            tagLabel.backgroundColor = Constants.CellLayout.TagBackgroundColor
            tagLabel.style.alignSelf = .center
            tagLabel.textContainerInset = UIEdgeInsets.init(top: 4, left: 8, bottom: 4, right: 8)
            tagLabel.cornerRadius = 8.0
            tagLabel.clipsToBounds = true
            // use UIEdgeInsets set line space
            // Thanks @jeffdav (Texture team member in Slack)
            let insetStack = ASInsetLayoutSpec.init(insets: UIEdgeInsets.init(top: 6, left: 0, bottom: 0, right: 0), child: tagLabel)
            tagStack.children?.append(insetStack)
        }
        
        self.abstractTextLabel.style.spacingBefore = 6.0
        self.abstractTextLabel.style.spacingAfter = 6.0
        self.abstractTextLabel.style.alignSelf = .start
        self.abstractTextLabel.maximumNumberOfLines = 12
        
        let footerStack = ASStackLayoutSpec.horizontal()
        footerStack.alignItems = .center
        footerStack.justifyContent = ASStackLayoutJustifyContent.spaceBetween
        footerStack.children = [self.releaseAtLabel, self.viewCountLabel]
        
        let verticalStack = ASStackLayoutSpec.vertical()
        verticalStack.children = [titleStack, tagStack, self.abstractTextLabel, footerStack]
        return ASInsetLayoutSpec(insets:UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16), child: verticalStack)
    }
    
}
