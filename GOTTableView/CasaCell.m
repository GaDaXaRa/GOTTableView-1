//
//  CasaCell.m
//  GOTTableView
//
//  Created by Ricardo Sánchez Sotres on 10/06/14.
//  Copyright (c) 2014 Ricardo Sanchez. All rights reserved.
//

#import "CasaCell.h"


@implementation CasaCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    self.nombre.shadowColor = [UIColor blackColor];
    self.nombre.shadowOffset = CGSizeMake(1, 1);
    
    self.lema.shadowColor = [UIColor blackColor];
    self.lema.shadowOffset = CGSizeMake(1, 1);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
