//
//  AboutNode.swift
//  remotex-iOS
//
//  Created by archimboldi on 13/05/2017.
//  Copyright © 2017 me.archimboldi. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class AboutNode: ASDisplayNode, ASTextNodeDelegate {
    let titleNode = ASTextNode()
    let sloganNode = ASTextNode()
    let scrollNode = ASScrollNode()
    let descriptionNode = ASTextNode()
    let authorNode = ASTextNode()
    let reviewNode = ASTextNode()
    let linkInfoNode = ASTextNode()
    let versionNode = ASTextNode()
    
    private var aboutModel: AboutModel
    
    init(aboutModel: AboutModel) {
        self.aboutModel = aboutModel
        super.init()
        setupNodes()
        buildNodeHierarchy()
    }
    
    func setupNodes() {
        titleNode.attributedText = self.attrStringForAboutTitle(withSize: Constants.AboutLayout.TitleFontSize)
        sloganNode.attributedText = self.attrStringForAboutSlogan(withSize: Constants.AboutLayout.SloganFontSize)
        descriptionNode.attributedText = self.attrStringForAboutDescription(withSize: Constants.AboutLayout.DescriptionFontSize)
        authorNode.attributedText = self.attrStringForAboutAuthor(withSize: Constants.AboutLayout.DescriptionFontSize)
        authorNode.isUserInteractionEnabled = true
        authorNode.delegate = self
        reviewNode.attributedText = self.attrStringForAboutReview(withSize: Constants.AboutLayout.DescriptionFontSize)
        reviewNode.isUserInteractionEnabled = true
        reviewNode.delegate = self
        linkInfoNode.attributedText = self.attrStringForAboutLinkInfo(withSize: Constants.AboutLayout.DescriptionFontSize)
        linkInfoNode.isUserInteractionEnabled = true
        linkInfoNode.delegate = self
        versionNode.attributedText = self.attrStringForAboutVersion(withSize: Constants.AboutLayout.VersionFontSize)
    }
    
    func buildNodeHierarchy() {
        scrollNode.addSubnode(titleNode)
        scrollNode.addSubnode(sloganNode)
        scrollNode.addSubnode(descriptionNode)
        scrollNode.addSubnode(authorNode)
        scrollNode.addSubnode(reviewNode)
        scrollNode.addSubnode(linkInfoNode)
        scrollNode.addSubnode(versionNode)
        
        self.addSubnode(scrollNode)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        self.backgroundColor = Constants.TableLayout.BackgroundColor
        
        scrollNode.automaticallyManagesSubnodes = true
        scrollNode.automaticallyManagesContentSize = true
        scrollNode.scrollableDirections = .down
        scrollNode.view.showsVerticalScrollIndicator = false
        scrollNode.layoutSpecBlock = { node, constrainedSize in
            self.titleNode.style.alignSelf = .center
            self.sloganNode.style.alignSelf = .center
            self.sloganNode.style.spacingBefore = 8.0
            self.sloganNode.style.spacingAfter = 24.0
        
            self.descriptionNode.style.alignSelf = .start
            self.authorNode.style.alignSelf = .start
            self.authorNode.style.spacingBefore = 32.0
            self.reviewNode.style.alignSelf = .start
            self.reviewNode.style.spacingBefore = 32.0
            self.reviewNode.style.spacingAfter = 32.0
            self.linkInfoNode.style.alignSelf = .start
            self.linkInfoNode.style.spacingAfter = 32.0
            self.versionNode.style.alignSelf = .center
            self.versionNode.style.spacingAfter = 8.0
            let stack = ASStackLayoutSpec.vertical()
            stack.children = [self.titleNode, self.sloganNode, self.descriptionNode, self.authorNode, self.reviewNode, self.linkInfoNode, self.versionNode]
            return stack
        }
        
        let verticalStack = ASStackLayoutSpec.vertical()
        verticalStack.children = [scrollNode]
        return ASInsetLayoutSpec.init(insets: UIEdgeInsetsMake(0, 16, 0, 16), child: verticalStack)
    }
    
    private func attrStringForAboutTitle(withSize size: CGFloat) -> NSAttributedString {
        let attr = [
            NSForegroundColorAttributeName: UIColor.black,
            NSFontAttributeName: UIFont.boldSystemFont(ofSize: size)
        ]
        return NSAttributedString.init(string: self.aboutModel.aboutTitle, attributes: attr)
    }
    
    private func attrStringForAboutSlogan(withSize size: CGFloat) -> NSAttributedString {
        let attr = [
            NSForegroundColorAttributeName: UIColor.black,
            NSFontAttributeName: UIFont.boldSystemFont(ofSize: size)
        ]
        return NSAttributedString.init(string: self.aboutModel.slogan, attributes: attr)
    }
    
    private func attrStringForAboutDescription(withSize size: CGFloat) -> NSAttributedString {
        let attr = [
            NSForegroundColorAttributeName: UIColor.black,
            NSFontAttributeName: UIFont.systemFont(ofSize: size)
        ]
        return NSAttributedString.init(string: self.aboutModel.description, attributes: attr)
    }
    
    private func attrStringForAboutReview(withSize size: CGFloat) -> NSAttributedString {
        let attr = [
            NSForegroundColorAttributeName: UIColor.black,
            NSFontAttributeName: UIFont.systemFont(ofSize: size)
        ]
        let attributedString = NSMutableAttributedString.init(string: self.aboutModel.review)
        attributedString.addAttributes(attr, range: NSRange.init(location: 0, length: (self.aboutModel.review as NSString).length))
        attributedString.addAttributes([NSLinkAttributeName: Constants.AppStore.ReviewURL,
                                        NSForegroundColorAttributeName: UIColor.blue,
                                        NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue, NSUnderlineColorAttributeName: UIColor.clear],
                                       range: (self.aboutModel.review as NSString).range(of: Constants.AppStore.TitleText))
        return attributedString
    }
    
    private func attrStringForAboutAuthor(withSize size: CGFloat) -> NSAttributedString {
        let attr = [
            NSForegroundColorAttributeName: UIColor.black,
            NSFontAttributeName: UIFont.systemFont(ofSize: size)
        ]
        let attributedString = NSMutableAttributedString.init(string: self.aboutModel.author)
        attributedString.addAttributes(attr, range: NSRange.init(location: 0, length: (self.aboutModel.author as NSString).length))
        attributedString.addAttributes([NSLinkAttributeName: URL.URLForCreatorGitHub(),
                                        NSForegroundColorAttributeName: UIColor.blue,
                                        NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue, NSUnderlineColorAttributeName: UIColor.clear],
                                       range: (self.aboutModel.author as NSString).range(of: self.aboutModel.authorTwitterUsername))
        
        attributedString.addAttributes([NSLinkAttributeName: URL.URLForRemoteXiOSContributors(),
                                        NSForegroundColorAttributeName: UIColor.blue,
                                        NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue, NSUnderlineColorAttributeName: UIColor.clear],
                                       range: (self.aboutModel.author as NSString).range(of: self.aboutModel.remoteXiOSContributors))
        attributedString.addAttributes([NSLinkAttributeName: URL.URLForRemoteXiOSGitHub(),
                                        NSForegroundColorAttributeName: UIColor.blue,
                                        NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue, NSUnderlineColorAttributeName: UIColor.clear],
                                       range: (self.aboutModel.author as NSString).range(of: self.aboutModel.remoteXiOSGitHub))
        return attributedString
    }
    
    private func attrStringForAboutLinkInfo(withSize size: CGFloat) -> NSAttributedString {
        let attr = [
            NSForegroundColorAttributeName: UIColor.black,
            NSFontAttributeName: UIFont.systemFont(ofSize: size)
        ]
        let attributedString = NSMutableAttributedString.init(string: self.aboutModel.linkInfo)
        attributedString.addAttributes(attr, range: NSRange.init(location: 0, length: (self.aboutModel.linkInfo as NSString).length))
        attributedString.addAttributes([NSLinkAttributeName: URL.URLForRemoteXWebSite(),
                                        NSForegroundColorAttributeName: UIColor.blue,
                                        NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue, NSUnderlineColorAttributeName: UIColor.clear],
                                       range: (self.aboutModel.linkInfo as NSString).range(of: self.aboutModel.remoteXWebSite))
        attributedString.addAttributes([NSLinkAttributeName: URL.URLForRemoteXSlack(),
                                        NSForegroundColorAttributeName: UIColor.blue,
                                        NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue, NSUnderlineColorAttributeName: UIColor.clear],
                                       range: (self.aboutModel.linkInfo as NSString).range(of: self.aboutModel.remoteXSlack))
        attributedString.addAttributes([NSLinkAttributeName: URL.URLForRemoteXEMail(),
                                        NSForegroundColorAttributeName: UIColor.blue,
                                        NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue, NSUnderlineColorAttributeName: UIColor.clear],
                                       range: (self.aboutModel.linkInfo as NSString).range(of: self.aboutModel.remoteXEmail))
        return attributedString
    }
    
    private func attrStringForAboutVersion(withSize size: CGFloat) -> NSAttributedString {
        let attr = [
            NSForegroundColorAttributeName: UIColor.lightGray,
            NSFontAttributeName: UIFont.systemFont(ofSize: size)
        ]
        let versionText = Bundle.main.infoDictionary?["CFBundleShortVersionString"]  as! String
        let buildText = Bundle.main.infoDictionary?["CFBundleVersion"]  as! String
        return NSAttributedString.init(string: "Version \(versionText) (Build \(buildText))", attributes: attr)
    }
    
    func textNode(_ textNode: ASTextNode, shouldHighlightLinkAttribute attribute: String, value: Any, at point: CGPoint) -> Bool {
        return true
    }
    
    func textNode(_ textNode: ASTextNode, shouldLongPressLinkAttribute attribute: String, value: Any, at point: CGPoint) -> Bool {
        return true
    }
    
    func textNode(_ textNode: ASTextNode, tappedLinkAttribute attribute: String, value: Any, at point: CGPoint, textRange: NSRange) {
        guard let url = value as? URL else { return }
        if UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                 UIApplication.shared.openURL(url)
            }
        }
    }
}
