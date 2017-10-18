//
//  StudentTableViewController.m
//  EnglishTeachingAPP
//
//  Created by will on 2017/10/12.
//  Copyright © 2017年 will. All rights reserved.
//

#import "StudentTableViewController.h"
#import "RegistrationStudentViewController.h"
#import "StudentListCell.h"

@interface StudentTableViewController ()
@property (nonatomic, strong)NSMutableArray *students;
@end

@implementation StudentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAction)];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"StudentListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"StudentListCell"];
    
    __weak StudentTableViewController *weakSelf = self;
    //添加上拉加载
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        
        BmobQuery *bq = [BmobQuery queryForUser];
        bq.limit = 30;
        bq.skip = weakSelf.students.count;
        //查询不是老师的用户
        [bq whereKey:@"isteacher" notEqualTo:@(YES)];
        [bq findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
            [SVProgressHUD dismiss];
            [weakSelf.students addObjectsFromArray:array];
            [weakSelf.tableView reloadData];
            [weakSelf.tableView.infiniteScrollingView stopAnimating];
        }];
        
        
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadStudents];
}

- (void)loadStudents{
    [SVProgressHUD show];
    BmobQuery *bq = [BmobQuery queryWithClassName:@"_User"];
    [bq whereKey:@"isTeacher" notEqualTo:@"YES"];
    [bq findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        [SVProgressHUD dismiss];
        self.students = [array mutableCopy];
        [self.tableView reloadData];
    }];
}

- (void)addAction{
    RegistrationStudentViewController *rsVC = [RegistrationStudentViewController new];
    [self.navigationController pushViewController:rsVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.students.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    StudentListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StudentListCell" forIndexPath:indexPath];
    
    cell.students = self.students[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
