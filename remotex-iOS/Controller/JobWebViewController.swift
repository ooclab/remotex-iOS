//
//  JobWebViewController.swift
//  remotex-iOS
//
//  Created by archimboldi on 17/05/2017.
//  Copyright © 2017 me.archimboldi. All rights reserved.
//

import Foundation
import WebKit

class JobWebViewController: UIViewController, WKNavigationDelegate {
    
    var url: URL!
    var jobTitle: String!
    
    var webView: WKWebView!
    
    var progressView: UIProgressView!
    
    convenience init() {
        self.init(withURL: nil, withTitle: nil)
    }
    
    init(withURL url: URL!, withTitle jobTitle: String!) {
        self.url = url
        self.jobTitle = jobTitle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress))
    }
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration.init()
        webView = WKWebView.init(frame: CGRect.zero, configuration: webConfiguration)
        webView.navigationDelegate = self
        webView.backgroundColor = Constants.TableLayout.BackgroundColor
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupProgressView()
        setupNavigation()
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        webView.allowsLinkPreview = true
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        progressView.removeFromSuperview()
        super.viewWillDisappear(animated)
    }
    
    func setupProgressView() {
        if self.progressView == nil {
            let progressView = UIProgressView.init()
            progressView.progressViewStyle = .bar
            progressView.tintColor = Constants.AppLayout.LogoForegroundColor
            progressView.progress = 0.2
            progressView.layer.zPosition = 1.1
            self.progressView = progressView
        }
        if ((self.navigationController != nil) && !self.navigationController!.navigationBar.isHidden) {
            progressView.frame = CGRect.init(x: self.navigationController?.navigationBar.frame.origin.x ?? 0, y: (self.navigationController?.navigationBar.frame.size.height ?? 0) - progressView.frame.size.height, width: self.navigationController?.navigationBar.frame.size.width ?? UIScreen.main.bounds.size.width, height: 2)
            if self.progressView.superview != self.navigationController?.navigationBar {
                self.progressView.removeFromSuperview()
                self.navigationController?.navigationBar.addSubview(self.progressView)
            }
        } else {
            if (self.webView.superview != nil) {
                if UIDevice.current.orientation.isPortrait {
                    progressView.frame = CGRect.init(x: self.webView.frame.origin.x, y: self.webView.frame.origin.y + 20 - progressView.frame.size.height, width: self.webView.frame.size.width, height: 2)
                } else {
                    progressView.frame = CGRect.init(x: self.webView.frame.origin.x, y: 0, width: self.webView.frame.size.width, height: 2)
                }
                if self.progressView.superview != self.webView.superview {
                    self.progressView.removeFromSuperview()
                    self.webView.superview?.addSubview(self.progressView)
                }
            }
        }
    }
    
    func dismissProgressView() {
        UIView.animate(withDuration: 0.2, delay: 0.1, options: .curveEaseOut, animations: {
            self.progressView.removeFromSuperview()
        }, completion: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            let progress = Float(webView.estimatedProgress)
            if progress < 0.2 {
                progressView.progress = 0.2 + progress / 10
            } else if progress >= 1.0 {
                progressView.progress = 1.0
            } else {
                progressView.progress = progress
            }
        }
    }
    
    func setupNavigation() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.action, target: self, action: #selector(shareAction))
    }
    
    func shareAction() {
        let image = Constants.ShareContext.LogoImage
        let shareTitle: String! = self.jobTitle
        let shareURL: URL! = self.url
        var shareObject = [Any]()
        shareObject = [image, shareURL, shareTitle] as [Any]
        let activityViewController = UIActivityViewController(activityItems: shareObject, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        setupProgressView()
    }
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        setupProgressView()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        dismissProgressView()
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        dismissProgressView()
        PromptMessageWrap.show(withMessage: Constants.MessageDescription.NoInternetConnection)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        dismissProgressView()
        PromptMessageWrap.show(withMessage: Constants.MessageDescription.NoInternetConnection)
    }
    
}
