//
//  DetailViewController.h
//  GOTTableView
//
//  Created by Ricardo Sánchez Sotres on 10/06/14.
//  Copyright (c) 2014 Ricardo Sanchez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Personaje.h"

@protocol DetailViewControllerDelegate <NSObject>
- (void) mataPersonaje:(Personaje *) personaje;
@end

@interface DetailViewController : UIViewController
@property (nonatomic, weak) id<DetailViewControllerDelegate> delegate;
@property (nonatomic, strong) Personaje* personaje;
@end
