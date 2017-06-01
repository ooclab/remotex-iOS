//
//  TextureSnapshotTestCase.swift
//  remotex-iOS
//
//  Created by archimboldi on 01/06/2017.
//  Copyright © 2017 me.archimboldi. All rights reserved.
//

import FBSnapshotTestCase
import AsyncDisplayKit

class TextureSnapshotTestCase: FBSnapshotTestCase {
    
    /**
     * Hack for testing.  ASDisplayNode lacks an explicit -render method, so we manually hit its layout & display codepaths.
     */
    static func hackilySynchronouslyRecursivelyRenderNode(_ node: ASDisplayNode) {
        ASDisplayNodePerformBlockOnEveryNode(nil, node, true) {node in
            node.layer.setNeedsDisplay()
        }
        node.recursivelyEnsureDisplaySynchronously(true)
    }
}

var TextureSnapshotTestCaseDefaultSuffixes: NSOrderedSet {
    let suffixesSet = NSMutableOrderedSet.init()
    if (kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_10_0) {
        suffixesSet.add("_iOS_10")
    }
    suffixesSet.add("_64")
    return suffixesSet.copy() as! NSOrderedSet
}


extension FBSnapshotTestCase {
    
    func TextureSnapshotVerifyNode(node: ASDisplayNode, identifier: String = "", suffixes: NSOrderedSet = TextureSnapshotTestCaseDefaultSuffixes, tolerance: CGFloat = 0) {
        TextureSnapshotTestCase.hackilySynchronouslyRecursivelyRenderNode(node)
        FBSnapshotVerifyLayer(node.layer, identifier: identifier, suffixes: suffixes, tolerance: tolerance);
    }
    
    func TextureSnapshotVerifyLayer(layer: CALayer, identifier: String = "", suffixes: NSOrderedSet = TextureSnapshotTestCaseDefaultSuffixes, tolerance: CGFloat = 0) {
        FBSnapshotVerifyLayer(layer, identifier: identifier, suffixes: suffixes, tolerance: tolerance);
    }
    
    func TextureSnapshotVerifyView(view: UIView, identifier: String = "", suffixes: NSOrderedSet = TextureSnapshotTestCaseDefaultSuffixes, tolerance: CGFloat = 0) {
        FBSnapshotVerifyView(view, identifier: identifier, suffixes: suffixes, tolerance: tolerance);
    }
    
}
