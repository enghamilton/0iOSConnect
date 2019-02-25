//
//  ViewController.m
//  iOSConnectPHPJson
//
//  Created by macOS on 16/02/19.
//  Copyright © 2019 macOS. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSMutableData *_responseData;
    NSURLConnection *connection;
    NSMutableArray *array;
}

@end

@implementation ViewController

@synthesize responseData = _responseData;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //[[self TableView] setDelegate:self];
    //[[self TableView] setDataSource:self];
    array = [[NSMutableArray alloc] init];
    array = [NSMutableArray arrayWithObjects:@"user 01",@"user 02", nil];
    
    UIImage *img = [UIImage imageNamed:@"fb.png"];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [imgView setImage:img];
    // setContent mode aspect fit
    [imgView setContentMode:UIViewContentModeScaleAspectFit];
    self.navigationItem.titleView = imgView;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(updateDatabasePHP:)];
    //https ://stackoverflow.com/questions/12916928/call-method-in-uibutton-action-in-another-class
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [self.responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Connection failed: %@", [error description]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    //Getting your response string
    NSString *responseString = [[NSString alloc] initWithData:self.responseData encoding:NSUTF8StringEncoding];
    self.responseData = nil;
    
    // https ://stackoverflow.com/questions/20077328/objective-c-parse-json-from-url-request
    NSError *e = nil;
    NSData *jsonData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:jsonData options: NSJSONReadingMutableContainers error: &e];
    
    if(JSON){
        
        [array addObject:[JSON objectForKey:@"title"]];
        /*
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"iOSConnectPHPJson"                                                        message:[JSON objectForKey:@"title"]                                                      delegate:nil                                              cancelButtonTitle:@"close"                                              otherButtonTitles:nil];
        [alertView show];
        */
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"iOSConnectPHPJson"                                                        message:[array objectAtIndex:2]                                                      delegate:nil                                              cancelButtonTitle:@"close"                                              otherButtonTitles:nil];
        [alertView show];

        //NSString *TableViewCellUser = [user objectForKey:@"username"];
        NSLog (@"Your Array elements are = %@", array);
        [TableView reloadData];
        
        
    }
    
    /*
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"iOSConnectPHPJson"                                                        message:responseString                                                      delegate:nil                                              cancelButtonTitle:@"close"                                              otherButtonTitles:nil];
    [alertView show];
    */

    //NSString * responseString2 = [array componentsJoinedByString:@","];
}

/*
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [webData setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [webData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"failed with error");
}
*/
//-(void)connectionDidFinishLoading:(NSURLConnection *)connection
//{
    // i think this will work
    /*
    https ://stackoverflow.com/questions/7483085/how-to-use-the-nsurlconnection-for-getting-the-data-from-web
    NSString *responseString = [[NSString alloc] initWithData:self.responseData encoding:NSUTF8StringEncoding];
    self.responseData = nil;
    */
    
    // https: //stackoverflow.com/questions/20077328/objective-c-parse-json-from-url-request
    /*
    NSString *responseString = [[NSString alloc] initWithData:webData encoding:NSUTF8StringEncoding];
    NSError *e = nil;
    NSData *jsonData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:jsonData options: NSJSONReadingMutableContainers error: &e];
    NSLog(@"JSON: %@", JSON);
     */
    
    /*
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:webData options:0 error:nil];
    NSDictionary *products = [json objectForKey:@"products"];
    NSArray *arrayOfProducts = [products objectForKey:@"username"];
    
    for (id user in arrayOfProducts)
    {
        [array addObject:user];
        
        [self.TableView reloadData];
    }
    */
    
//}
- (IBAction)updateDatabasePHP:(id)sender {
    
    //https ://stackoverflow.com/questions/12916928/call-method-in-uibutton-action-in-another-class
    
    self.responseData = [NSMutableData data];
    NSURL *url = [NSURL URLWithString:@"https://jsonplaceholder.typicode.com/todos/1"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    //NSURL *url = [NSURL URLWithString:@"https://pizzaria2.000webhostapp.com/android_connect/get_all_products.php"];
    //NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
    if(connection)
    {
        //webData = [[NSMutableData alloc] init];
        
        // https ://dzone.com/articles/do-not-publishcreating-your
        //[TableView reloadData];
        
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"my app alert"                                                        message:@"something went wrong"                                                      delegate:nil                                              cancelButtonTitle:@"close"                                              otherButtonTitles:nil];
        [alertView show];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [array count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [array objectAtIndex:indexPath.row];
    
    return cell;
}

@end
