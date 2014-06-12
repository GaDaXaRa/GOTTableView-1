//
//  CasasViewController.m
//  GOTTableView
//
//  Created by Ricardo Sánchez Sotres on 10/06/14.
//  Copyright (c) 2014 Ricardo Sanchez. All rights reserved.
//

#import "CasasViewController.h"
#import "GotModel.h"
#import "CasaCell.h"
#import "Casa.h"

@interface CasasViewController ()
@property (nonatomic, strong) GotModel* modelo;
@end

@implementation CasasViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.modelo = [[GotModel alloc] init];
    [self.modelo cargaModelo];
    
    self.tableView.showsVerticalScrollIndicator = NO;
    
 //   self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelo.casas.count*2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CasaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"casaCell" forIndexPath:indexPath];
    
    Casa* casa = [self.modelo.casas objectAtIndex:indexPath.row%self.modelo.casas.count];
    
    cell.nombre.text = casa.nombre;
    cell.lema.text = casa.lema;
    cell.rutaImagen = [NSString stringWithFormat:@"%@_g.jpg", casa.imagen];//[UIImage imageNamed:];
    
    float distancia = cell.frame.origin.y-tableView.contentOffset.y;
    [cell setOffset:distancia/self.view.bounds.size.height];

    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Casa* casa = [self.modelo.casas objectAtIndex:indexPath.row%self.modelo.casas.count];

    [self.delegate casaSeleccionada:casa.nombre];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView.contentSize.height<=0.0)
        return;
    
    if((scrollView.contentOffset.y+scrollView.frame.size.height)>=scrollView.contentSize.height) {
        scrollView.contentOffset = CGPointMake(0, scrollView.contentSize.height/2-scrollView.frame.size.height);
    }
    
    if(scrollView.contentOffset.y<=-64) {
        scrollView.contentOffset = CGPointMake(0, scrollView.contentSize.height/2-64);
    }
    
    for (CasaCell* cell in self.tableView.visibleCells) {
        float distancia = cell.frame.origin.y-scrollView.contentOffset.y;
        [cell setOffset:distancia/self.view.bounds.size.height];
    }
}
@end
