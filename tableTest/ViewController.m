//
//  ViewController.m
//  tableTest
//
//  Created by Алексей Саечников on 17.02.16.
//  Copyright © 2016 saechnikov. All rights reserved.
//

#define imagePlaceholder @"imagePlaceholder"
#define imagePlaceholderHeight 105
#define imagePlaceholderCellIdentifier @"imagePlaceholder"

#define imageAfterPlaceholder @"imageAfterPlaceholder"
#define imageAfterIdentifier @"imageAfterIdentifier"
#define imageAfterHeight 30

#define nameHeaderHeight 40

#define firstCellPlaceholder @"firstCell"
#define firstCellEdintifier @"firstCell"
#define firstCellHeight 217

#define secondCellHeight 90

#define lastCellPlaceholder @"lastCell"

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic) NSArray<NSArray*> *tableViewData;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imagePlaceholderHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameLabelTopConstraint;
@property (weak, nonatomic) IBOutlet UIView *navBackgroundView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableViewData = @[@[imagePlaceholder, imageAfterPlaceholder, firstCellPlaceholder, lastCellPlaceholder]];
}

#pragma mark - Table view 

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.tableViewData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableViewData[section].count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    id object = self.tableViewData[indexPath.section][indexPath.row];
    if ([object isKindOfClass:[NSString class]] && [(NSString*)object isEqualToString:imagePlaceholder]) {
        return imagePlaceholderHeight;
    }
    else if ([object isKindOfClass:[NSString class]] && [(NSString*)object isEqualToString:imageAfterPlaceholder]) {
        return imageAfterHeight;
    }
    else if ([object isKindOfClass:[NSString class]] && [(NSString*)object isEqualToString:firstCellPlaceholder]) {
        return firstCellHeight;
    }
    else if ([object isKindOfClass:[NSString class]] && [(NSString*)object isEqualToString:lastCellPlaceholder]) {
        return 1000;
    }
    else {
        return firstCellHeight;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id object = self.tableViewData[indexPath.section][indexPath.row];
    if ([object isKindOfClass:[NSString class]] && [(NSString*)object isEqualToString:imagePlaceholder]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:imagePlaceholderCellIdentifier];
        return cell;
    }
    else if ([object isKindOfClass:[NSString class]] && [(NSString*)object isEqualToString:imageAfterPlaceholder]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:imageAfterIdentifier];
        return cell;
    }
    else if ([object isKindOfClass:[NSString class]] && [(NSString*)object isEqualToString:firstCellPlaceholder]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:firstCellEdintifier];
        return cell;
    }
    else {
        UITableViewCell *cell = [UITableViewCell new];
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        return cell;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat y = scrollView.contentOffset.y;
    if (y > -200) {
        CGFloat moreFloat = y < 0 ? y/3 : 0;
        self.imagePlaceholderHeightConstraint.constant = 105-y - moreFloat;
        self.nameLabelTopConstraint.constant = 137-y;
        CGFloat percentage = (self.nameLabelTopConstraint.constant - 15)/2;
        percentage = percentage/10;
        if (percentage > 1) percentage = 1;
        self.navBackgroundView.alpha = 1 - percentage;
    }
}

@end
