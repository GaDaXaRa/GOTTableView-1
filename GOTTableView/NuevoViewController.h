//
//  NuevoViewController.h
//  GOTTableView
//
//  Created by Ricardo Sánchez Sotres on 10/06/14.
//  Copyright (c) 2014 Ricardo Sanchez. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Personaje;
@protocol NuevoViewControllerDelegate <NSObject>
- (void) personaje:(Personaje *) personaje creadoEnCasa:(NSString *) casa;
@end

@interface NuevoViewController : UITableViewController
@property (nonatomic, weak) id<NuevoViewControllerDelegate> delegate;
@end
