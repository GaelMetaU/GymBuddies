//
//  HomeViewController.m
//  GymBuddies
//
//  Created by Gael Rodriguez Gomez on 7/8/22.
//

#import "HomeViewController.h"
#import "ParseAPIManager.h"
#import "GoogleMaps/GoogleMaps.h"
#import "CoreLocation/CoreLocation.h"
#import "GoogleMapsView.h"

@interface HomeViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet GoogleMapsView *googleMapsView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight =UITableViewAutomaticDimension;
    
    [self.googleMapsView setContent];
}


#pragma mark - Table view methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"GoogleMapsTableViewCell"];
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
