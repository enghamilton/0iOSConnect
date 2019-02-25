//
//  ViewController.h
//  iOSConnectPHPJson
//
//  Created by macOS on 16/02/19.
//  Copyright © 2019 macOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, NSURLConnectionDataDelegate>

{
    IBOutlet UITableView *TableView;
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *updateDatabase;
@property (nonatomic, retain) NSMutableData *responseData;
- (IBAction)updateDatabasePHP:(id)sender;

@end

