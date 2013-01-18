//
//  AGDetailViewController.h
//  AGQuadrilateral
//
//  Created by Håvard Fossli on 18.01.13.
//  Copyright (c) 2013 Håvard Fossli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AGDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
