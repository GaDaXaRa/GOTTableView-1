//
//  CasasViewController.h
//  GOTTableView
//
//  Created by Ricardo Sánchez Sotres on 10/06/14.
//  Copyright (c) 2014 Ricardo Sanchez. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CasasViewControllerDelegate <NSObject>
- (void) casaSeleccionada:(NSString *) nombreCasa;
@end

@interface CasasViewController : UITableViewController
@property (nonatomic, weak) id<CasasViewControllerDelegate> delegate;
@end
