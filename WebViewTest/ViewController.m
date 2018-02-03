//
//  ViewController.m
//  WebViewTest
//
//  Created by Pavel on 02.02.2018.
//  Copyright © 2018 Pavel Maiboroda. All rights reserved.
//

#import "ViewController.h"
#import "PMWebKitController.h"
#import <WebKit/WebKit.h>

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *pdfsArray;
@property (strong, nonatomic) NSArray *urlsArray;
@property (strong, nonatomic) NSString *folderPath;
@property (strong, nonatomic) NSArray *sectionsArray;

@end

typedef enum {
    PMRowsTypeURL,
    PMRowsTypePDF
} PMRowsType;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.urlsArray = [NSArray arrayWithObjects: @"https://stackoverflow.com", @"https://github.com", @"https://ain.ua", @"https://dou.ua", nil];
    
    self.folderPath = @"/Users/pavel/Documents/IOSDevCourse/DZ/WebViewTest/WebViewTest/PDF/";
    
    self.pdfsArray = [[NSFileManager defaultManager] contentsOfDirectoryAtPath: self.folderPath error: nil];
    
    self.sectionsArray = [NSArray arrayWithObjects: @"URLs", @"PDFs", nil];
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PMWebKitController *vc = [self.storyboard instantiateViewControllerWithIdentifier: @"PMWebKitController"];
    vc.modalPresentationStyle = UIModalPresentationFullScreen;

    NSURLRequest *request = nil;
    
    if (indexPath.section == PMRowsTypeURL) {
       
        NSURL *url = [NSURL URLWithString: [self.urlsArray objectAtIndex: indexPath.row]];
        request = [NSURLRequest requestWithURL: url];

    } else {
       
        NSString *resource = [self.pdfsArray objectAtIndex: indexPath.row];
        NSString *filePath = [[NSBundle mainBundle] pathForResource: resource ofType: nil inDirectory: @"PDF"];
        NSURL *fileUrl = [NSURL fileURLWithPath: filePath];
        
        request = [NSURLRequest requestWithURL: fileUrl];
    }
    
    [vc loadRequest: request];
    
    [self.navigationController pushViewController: vc animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [self.sectionsArray count];
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return [self.sectionsArray objectAtIndex: section];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == PMRowsTypeURL) {
        return [self.urlsArray count];
    } else {
        return [self.pdfsArray count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *urlIdentifier = @"urlCell";
    static NSString *pdfIdentifier = @"pdfCell";
    
    UITableViewCell *cell;
    
    if (indexPath.section == PMRowsTypeURL) {
        cell = [self returnCellForTableView: tableView withIdentifier: urlIdentifier];
        cell.textLabel.text = [self.urlsArray objectAtIndex: indexPath.row];
    } else {
        cell = [self returnCellForTableView: tableView withIdentifier: pdfIdentifier];
        cell.textLabel.text = [[self.pdfsArray objectAtIndex: indexPath.row] lastPathComponent];
    }

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark - Help Methods

- (UITableViewCell *) returnCellForTableView: (UITableView *) tableView withIdentifier: (NSString *) identifier {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: identifier];
    }
    
    return cell;
}

@end
