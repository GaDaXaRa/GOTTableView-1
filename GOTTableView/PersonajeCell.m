//
//  PersonajeCell.m
//  GOTTableView
//
//  Created by Ricardo Sánchez Sotres on 10/06/14.
//  Copyright (c) 2014 Ricardo Sanchez. All rights reserved.
//

#import "PersonajeCell.h"

@interface PersonajeCell()
@property (weak, nonatomic) IBOutlet UIView *imageHolder;

@end

@implementation PersonajeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {


    }
    return self;
}

- (void)awakeFromNib
{
    self.imageHolder.backgroundColor = [UIColor clearColor];
    self.imageHolder.clipsToBounds = YES;
    self.imageHolder.layer.cornerRadius = self.imageHolder.frame.size.width/2.0;
    self.imageHolder.layer.borderWidth = 2.0;
    self.imageHolder.layer.borderColor = [UIColor whiteColor].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
