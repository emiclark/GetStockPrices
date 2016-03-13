//
//  ViewController.m
//
//  Getting stock prices using
//  Yahoo API and using NSURLSession
//
//  Created by Emiko Clark on 3/10/16.
//  Copyright © 2016 Emiko Clark. All rights reserved.//

#import "ViewController.h"

@interface ViewController () <NSURLSessionDelegate, NSURLSessionDownloadDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //initialize array of company symbols
    self.stockSymbols = [[NSMutableArray alloc]initWithObjects:@"AAPL", @"FB",@"GOOGL",@"MSFT",nil];
    // display symbols
    self.company1.text = [self.stockSymbols objectAtIndex:0];
    self.company2.text = [self.stockSymbols objectAtIndex:1];
    self.company3.text = [self.stockSymbols objectAtIndex:2];
    self.company4.text = [self.stockSymbols objectAtIndex:3];
    
    //create a config session
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    // declare this method as the delegate
    [NSURLSession sessionWithConfiguration:sessionConfig
                                  delegate: self
                             delegateQueue:nil];
}

-(void) updateUIWithStockPrices {
    //display stock prices
    self.stock1.text = [self.stockPrices objectAtIndex:0];
    self.stock2.text = [self.stockPrices objectAtIndex:1];
    self.stock3.text = [self.stockPrices objectAtIndex:2];
    self.stock4.text = [self.stockPrices objectAtIndex:3];
}

- (IBAction)getStockPricesButtonTapped:(UIButton *)sender {
    // request for stock prices using Yahoo API
    
    //create query string
    self.query = [[NSMutableString alloc]initWithString:@"http://finance.yahoo.com/d/quotes.csv?s="];
    for (int i=0; i<self.stockSymbols.count-1; i++) {
        //concatenate symbol names to end of url
        [self.query appendString:self.stockSymbols[i]];
        [self.query appendString:@"+"];
    }
    [self.query appendString:self.stockSymbols[self.stockSymbols.count-1]];
    [self.query appendString:@"&f=l1"];
    NSLog(@"query: %@",self.query);
    
    //create url from query string
    self.dataURL = [NSURL URLWithString:self.query];
    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession]
      dataTaskWithURL:self.dataURL
      completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
          
          // *price has stock prices in csv format
          NSString *price =[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
          //stockPrices is an array of stock Prices
          self.stockPrices = [price componentsSeparatedByString: @"\n"];
          
          NSLog(@"%@",self.stockPrices);
          //run update the UI on the main thread
          dispatch_async(dispatch_get_main_queue(), ^(void){
              [self updateUIWithStockPrices];
          });
      }];
    [downloadTask resume];
    
    //update the UI on main queue
    dispatch_async(dispatch_get_main_queue(), ^{
        // perform on main
        [self updateUIWithStockPrices];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) URLSession:(NSURLSession *)session downloadTask:(nonnull NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(nonnull NSURL *)location {
    
}

-(void) NSURLSessionDownloadDelegate {
    
}

@end

