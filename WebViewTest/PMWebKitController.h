//
//  PMWebKitController.h
//  WebViewTest
//
//  Created by Pavel on 03.02.2018.
//  Copyright © 2018 Pavel Maiboroda. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WKWebView;

@interface PMWebKitController : UIViewController

@property (strong, nonatomic) IBOutlet WKWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;

- (IBAction)actionBack:(UIBarButtonItem *)sender;
- (IBAction)actionForward:(UIBarButtonItem *)sender;
- (IBAction)actionRefresh:(UIBarButtonItem *)sender;

- (void) loadRequest: (NSURLRequest *) request;

@end
