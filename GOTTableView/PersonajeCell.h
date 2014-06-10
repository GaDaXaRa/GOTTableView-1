//
//  PersonajeCell.h
//  GOTTableView
//
//  Created by Ricardo Sánchez Sotres on 10/06/14.
//  Copyright (c) 2014 Ricardo Sanchez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonajeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *retrato;
@property (weak, nonatomic) IBOutlet UILabel *nombre;
@property (weak, nonatomic) IBOutlet UILabel *descripcion;

@end
