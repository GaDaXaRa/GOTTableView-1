//
//  TablaViewController.m
//  GOTTableView
//
//  Created by Ricardo Sánchez Sotres on 10/06/14.
//  Copyright (c) 2014 Ricardo Sanchez. All rights reserved.
//

#import "TablaViewController.h"
#import "GotModel.h"
#import "Casa.h"
#import "Personaje.h"
#import "PersonajeCell.h"
#import "OtraCelda.h"

@interface TablaViewController ()
@property (nonatomic, strong) GotModel* modelo;
@end

@implementation TablaViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Game of Thrones";
    
    [self.tableView registerClass:[OtraCelda class] forCellReuseIdentifier:@"otraCelda"];
    
    self.modelo = [[GotModel alloc] init];
    [self.modelo cargaModelo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.modelo.casas.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    Casa* casa = [self.modelo.casas objectAtIndex:section];
    return casa.personajes.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0) {
        OtraCelda* celda = [tableView dequeueReusableCellWithIdentifier:@"otraCelda" forIndexPath:indexPath];
        return celda;
    }
    
    PersonajeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"celdaPersonaje" forIndexPath:indexPath];
    
    Casa* casa = [self.modelo.casas objectAtIndex:indexPath.section];
    Personaje* personaje = [casa.personajes objectAtIndex:indexPath.row-1];
    
    cell.nombre.text = personaje.nombre;
    cell.descripcion.text = personaje.descripcion;
    cell.retrato.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", personaje.imagen]];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    Casa* casa = [self.modelo.casas objectAtIndex:section];
    return casa.nombre;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0)
        return 5;
    
    return 67;
}

@end
