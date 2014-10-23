//
//  MasterViewController.m
//  SneakrBook
//
//  Created by Vi on 10/22/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "Person.h"

@interface MasterViewController ()<UITableViewDataSource>
@property NSArray *peopleArray;
@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];

}

- (void) loadData {

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults objectForKey:@"dataImported"])
    {

    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://s3.amazonaws.com/mobile-makers-assets/app/public/ckeditor_assets/attachments/18/friends.json"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
    {
        NSArray *friends = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError];
        for (NSString *name in friends)
        {
            Person *person = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:self.managedObjectContext];
            person.name = name;

        }
        [self.managedObjectContext save:nil];
    }];
    [self fetchData];
    }  
}

-(void)fetchData{
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Person"];
    self.peopleArray = [self.managedObjectContext executeFetchRequest:request error:nil];
    NSLog(@"%lu",(unsigned long)self.peopleArray.count);
    [self.tableView reloadData];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Person *friend = [self.peopleArray objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text = friend.name;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.peopleArray.count;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    Person *friendPerson = [self.peopleArray objectAtIndex:self.tableView.indexPathForSelectedRow.row];
    DetailViewController *viewController = segue.destinationViewController;
    viewController.detailPerson = friendPerson;


}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"BattleSegue" sender:self];
    

}
@end

