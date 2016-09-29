//
//  SecondViewController.m
//  IOSTest
//
//  Created by Shashank Gogi on 28/09/16.
//  Copyright © 2016 Test. All rights reserved.
//

#import "CartListView.h"
#import "CartListCell.h"
#import "AppDelegate.h"
#import "CartListTable.h"
#import "UIImageView+AFNetworking.h"

@interface CartListView (){
    
    IBOutlet UITableView *tbl_cartList;
    NSMutableArray *cartListArray;
    IBOutlet UILabel *totalPriceLbl;
    IBOutlet UIView *NoDataView;
    IBOutlet UILabel *NoDataLbl;
    IBOutlet UIView *priceView;
}

@end

@implementation CartListView

#pragma mark-ViewController LyfeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    cartListArray = [[NSMutableArray alloc] init];
    NoDataView.hidden = YES;
}

-(void)viewWillAppear:(BOOL)animated{
    [self refreshList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark-UserDefined Methods

-(void) refreshList {
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"CartListTable"];
    cartListArray = [[APPDELEGATE.managedObjectContext executeFetchRequest:request error:nil] mutableCopy];
    
    if (cartListArray.count != 0) {
        [self calculateTotalPrice];
        [self.view bringSubviewToFront:tbl_cartList];
        [self.view bringSubviewToFront:priceView];
        [tbl_cartList reloadData];
    }else{
        NoDataView.hidden = NO;
        [self.view bringSubviewToFront:NoDataView];
    }
    
}

-(void)calculateTotalPrice{
    double totalPrice = 0.0;
    for (CartListTable *product in cartListArray) {
        totalPrice = totalPrice + [product.productPrice doubleValue];
    }
    
    totalPriceLbl.text = [NSString stringWithFormat:@"%0.2f",totalPrice];
}



#pragma mark-UITableView Delegates and Datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return cartListArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CartListCell *cell = [tbl_cartList dequeueReusableCellWithIdentifier:@"CartCell"];
    tbl_cartList.separatorStyle = UITableViewCellSeparatorStyleNone;
    CartListTable *product = [cartListArray objectAtIndex:indexPath.row];
    cell.productNameLbl.text = product.productName;
    cell.vendorNameLbl.text = product.vendorName;
    cell.venderAddrLbl.text = product.vendorAddress;
    cell.productPriceLbl.text = product.productPrice;
    
    [cell.callVendorBtn addTarget:self action:@selector(callVendorBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cell.removeBtn addTarget:self action:@selector(removeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    cell.callVendorBtn.tag = indexPath.row;
    cell.removeBtn.tag = indexPath.row;
    cell.callVendorBtn.layer.cornerRadius = 4;
    cell.removeBtn.layer.cornerRadius = 4;
    cell.cartView.layer.cornerRadius = 3;
    cell.cartView.layer.borderWidth = 1;
    cell.cartView.layer.borderColor = [UIColor darkGrayColor].CGColor;
    
    [cell.productImg setImageWithURL:[NSURL URLWithString:product.productImage] placeholderImage:[UIImage imageNamed:@"team_user.png"]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tbl_cartList deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark-Button Click

-(void) callVendorBtnClicked:(UIButton*)sender{
    NSString *phNo = [(CartListTable*)[cartListArray objectAtIndex:sender.tag] vendorPhoneNum];
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phNo]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    } else
    {
        UIAlertView *calert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Call facility is not available!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [calert show];
    }
}

-(void) removeBtnClicked:(UIButton*)sender{
    [APPDELEGATE.managedObjectContext deleteObject:[cartListArray objectAtIndex:sender.tag]];
    [APPDELEGATE saveContext];
    [self refreshList];
}
@end
