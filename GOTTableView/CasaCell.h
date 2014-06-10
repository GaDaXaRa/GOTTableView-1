//
//  CasaCell.h
//  GOTTableView
//
//  Created by Ricardo Sánchez Sotres on 10/06/14.
//  Copyright (c) 2014 Ricardo Sanchez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CasaCell : UITableViewCell
@property (weak, nonatomic) NSString *rutaImagen;
@property (weak, nonatomic) IBOutlet UILabel *nombre;
@property (weak, nonatomic) IBOutlet UILabel *lema;
- (void) setOffset:(float) p;
@end
