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
    let linkInfoNode = ASTextNode()
    
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
        linkInfoNode.attributedText = self.attrStringForAboutLinkInfo(withSize: Constants.AboutLayout.DescriptionFontSize)
        linkInfoNode.isUserInteractionEnabled = true
        linkInfoNode.delegate = self
    }
    
    func buildNodeHierarchy() {
        scrollNode.addSubnode(titleNode)
        scrollNode.addSubnode(sloganNode)
        scrollNode.addSubnode(descriptionNode)
        scrollNode.addSubnode(authorNode)
        scrollNode.addSubnode(linkInfoNode)
        
        self.addSubnode(scrollNode)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        self.backgroundColor = UIColor.white
        
        scrollNode.automaticallyManagesSubnodes = true
        scrollNode.automaticallyManagesContentSize = true
        scrollNode.scrollableDirections = .down
        scrollNode.layoutSpecBlock = { node, constrainedSize in
            self.titleNode.style.alignSelf = .center
            self.sloganNode.style.alignSelf = .center
            self.sloganNode.style.spacingBefore = 8.0
            self.sloganNode.style.spacingAfter = 24.0
        
            self.descriptionNode.style.alignSelf = .start
            self.authorNode.style.alignSelf = .start
            self.authorNode.style.spacingBefore = 32.0
            self.authorNode.style.spacingAfter = 32.0
            self.linkInfoNode.style.alignSelf = .start
            self.linkInfoNode.style.spacingAfter = 32.0
            let stack = ASStackLayoutSpec.vertical()
            stack.children = [self.titleNode, self.sloganNode, self.descriptionNode, self.authorNode, self.linkInfoNode]
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
    
    private func attrStringForAboutAuthor(withSize size: CGFloat) -> NSAttributedString {
        let attr = [
            NSForegroundColorAttributeName: UIColor.black,
            NSFontAttributeName: UIFont.systemFont(ofSize: size)
        ]
        let attributedString = NSMutableAttributedString.init(string: self.aboutModel.author)
        attributedString.addAttributes(attr, range: NSRange.init(location: 0, length: (self.aboutModel.author as NSString).length))
        attributedString.addAttributes([NSLinkAttributeName: URL.URLforAuthorTwitter(),
                                        NSForegroundColorAttributeName: UIColor.blue,
                                        NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue, NSUnderlineColorAttributeName: UIColor.clear],
                                       range: (self.aboutModel.author as NSString).range(of: self.aboutModel.authorTwitterUsername))
        attributedString.addAttributes([NSLinkAttributeName: URL.URLforRemoteXiOSGitHub(),
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
        attributedString.addAttributes([NSLinkAttributeName: URL.URLforRemoteXWebSite(),
                                        NSForegroundColorAttributeName: UIColor.blue,
                                        NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue, NSUnderlineColorAttributeName: UIColor.clear],
                                       range: (self.aboutModel.linkInfo as NSString).range(of: self.aboutModel.remoteXWebSite))
        attributedString.addAttributes([NSLinkAttributeName: URL.URLforRemoteXGitHub(),
                                        NSForegroundColorAttributeName: UIColor.blue,
                                        NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue, NSUnderlineColorAttributeName: UIColor.clear],
                                       range: (self.aboutModel.linkInfo as NSString).range(of: self.aboutModel.remoteXGitHub))
        attributedString.addAttributes([NSLinkAttributeName: URL.URLforRemoteXSlack(),
                                        NSForegroundColorAttributeName: UIColor.blue,
                                        NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue, NSUnderlineColorAttributeName: UIColor.clear],
                                       range: (self.aboutModel.linkInfo as NSString).range(of: self.aboutModel.remoteXSlack))
        attributedString.addAttributes([NSLinkAttributeName: URL.URLforRemoteXEMail(),
                                        NSForegroundColorAttributeName: UIColor.blue,
                                        NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue, NSUnderlineColorAttributeName: UIColor.clear],
                                       range: (self.aboutModel.linkInfo as NSString).range(of: self.aboutModel.remoteXEmail))
        return attributedString
    }
    
    func textNode(_ textNode: ASTextNode, shouldHighlightLinkAttribute attribute: String, value: Any, at point: CGPoint) -> Bool {
        return true
    }
    
    func textNode(_ textNode: ASTextNode, shouldLongPressLinkAttribute attribute: String, value: Any, at point: CGPoint) -> Bool {
        return true
    }
    
    func textNode(_ textNode: ASTextNode, tappedLinkAttribute attribute: String, value: Any, at point: CGPoint, textRange: NSRange) {
        guard let url = value as? URL else { return }
        UIApplication.shared.openURL(url)
    }
}
