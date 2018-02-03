//
//  PMWebKitController.m
//  WebViewTest
//
//  Created by Pavel on 03.02.2018.
//  Copyright © 2018 Pavel Maiboroda. All rights reserved.
//

#import "PMWebKitController.h"
#import <WebKit/WebKit.h>

@interface PMWebKitController () <WKNavigationDelegate>

@end

@implementation PMWebKitController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.backButton.enabled = NO;
    self.forwardButton.enabled = NO;
    
    self.webView.navigationDelegate = self;
    
}

#pragma mark - Methods

- (void) loadRequest: (NSURLRequest *) request {
    
    self.webView = [[WKWebView alloc] init];
    self.webView.frame = self.view.frame;
    
    [self.webView loadRequest: request];
    
    [self.view insertSubview: self.webView belowSubview: self.indicatorView];
}

- (void) refreshButtons {
    self.backButton.enabled = self.webView.canGoBack;
    self.forwardButton.enabled = self.webView.canGoForward;
}

#pragma mark - Actions

- (IBAction)actionBack:(UIBarButtonItem *)sender {
    [self.webView goBack];
}

- (IBAction)actionForward:(UIBarButtonItem *)sender {
    [self.webView goForward];
}

- (IBAction)actionRefresh:(UIBarButtonItem *)sender {
    NSURLRequest *request = [NSURLRequest requestWithURL: [self.webView URL]];
    [self.webView loadRequest: request];
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    
    [self.indicatorView startAnimating];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    
    [self.indicatorView stopAnimating];
    [self refreshButtons];
}

@end
