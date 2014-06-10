//
//  CasaCell.m
//  GOTTableView
//
//  Created by Ricardo Sánchez Sotres on 10/06/14.
//  Copyright (c) 2014 Ricardo Sanchez. All rights reserved.
//

#import "CasaCell.h"

@interface CasaCell()
@property (nonatomic, strong) UIImageView* imagen;
@end

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
    self.clipsToBounds = YES;
    
    self.nombre.shadowColor = [UIColor blackColor];
    self.nombre.shadowOffset = CGSizeMake(1, 1);
    
    self.lema.shadowColor = [UIColor blackColor];
    self.lema.shadowOffset = CGSizeMake(1, 1);
}

- (void)setRutaImagen:(NSString *)rutaImagen
{
    _rutaImagen = rutaImagen;
    
    if(self.imagen) {
        [self.imagen removeFromSuperview];
        self.imagen = nil;
    }
    
    UIImage* img = [UIImage imageNamed:rutaImagen];
    self.imagen = [[UIImageView alloc] initWithImage:img];
    self.imagen.frame = CGRectMake(0, 0, self.imagen.image.size.width/2.0, self.imagen.image.size.height/2.0);
    [self insertSubview:self.imagen atIndex:0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setOffset:(float)p
{
    CGRect imageFrame = self.imagen.frame;
    imageFrame.origin = CGPointMake(0, -p*(self.imagen.frame.size.height-self.bounds.size.height));
    self.imagen.frame = imageFrame;
}

@end
