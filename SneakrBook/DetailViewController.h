//
//  DetailViewController.h
//  SneakrBook
//
//  Created by Vi on 10/22/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) DetailViewController *detailPerson;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

