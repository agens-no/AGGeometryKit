//
//  AGMasterViewController.h
//  AGQuadrilateral
//
//  Created by Håvard Fossli on 18.01.13.
//  Copyright (c) 2013 Håvard Fossli. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AGDetailViewController;

@interface AGMasterViewController : UITableViewController

@property (strong, nonatomic) AGDetailViewController *detailViewController;

@end
