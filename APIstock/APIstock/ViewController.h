//
//  ViewController.h
//
//  Getting stock prices using
//  Yahoo API and using NSURLSession
//
//  Created by Emiko Clark on 3/10/16.
//  Copyright © 2016 Emiko Clark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSMutableArray *stockSymbols;
@property (nonatomic, strong) NSArray *stockPrices;
@property (nonatomic, strong) NSURL *dataURL;


@property (weak, nonatomic) IBOutlet UITextField *company1;
@property (weak, nonatomic) IBOutlet UITextField *company2;
@property (weak, nonatomic) IBOutlet UITextField *company3;
@property (weak, nonatomic) IBOutlet UITextField *company4;

@property (weak, nonatomic) IBOutlet UITextField *stock1;
@property (weak, nonatomic) IBOutlet UITextField *stock2;
@property (weak, nonatomic) IBOutlet UITextField *stock3;
@property (weak, nonatomic) IBOutlet UITextField *stock4;

@property (nonatomic, retain) NSMutableString *query;

@property (weak, nonatomic) IBOutlet UIButton *getStockPricesButton;


-(void) updateUIWithStockPrices;

@end



