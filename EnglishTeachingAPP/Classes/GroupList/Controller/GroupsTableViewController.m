//
//  GroupsTableViewController.m
//  EnglishTeachingAPP
//
//  Created by will on 2017/10/12.
//  Copyright © 2017年 will. All rights reserved.
//

#import "GroupsTableViewController.h"

@interface GroupsTableViewController ()
@property (nonatomic, strong)NSMutableArray *classes;
@end

@implementation GroupsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAction)];
    
    self.navigationItem.rightBarButtonItems = @[self.navigationItem.rightBarButtonItem,addItem];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadClasses];
}

- (void)addAction{
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入班级名称" preferredStyle:UIAlertControllerStyleAlert];
    [ac addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"班级名称";
    }];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        BmobObject *bObj = [BmobObject objectWithClassName:@"Classes"];
            [bObj setObject:ac.textFields.firstObject.text forKey:@"className"];
            [bObj setObject:[BmobUser currentUser] forKey:@"byUser"];
            [bObj saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                //进行操作
                if (isSuccessful) {
                    [self loadClasses];
                }else NSLog(@"保存失败");
            }];
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [ac addAction:action1];
    [ac addAction:action2];
    
    [self presentViewController:ac animated:YES completion:nil];
}

- (void)loadClasses{
    BmobQuery *bq = [BmobQuery queryWithClassName:@"Classes"];
    [bq includeKey:@"byUser"];
        //开始查找所有
        [bq findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
            self.classes = [array mutableCopy];
            [self.tableView reloadData];
        }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.classes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    BmobObject *bObj = self.classes[indexPath.row];
    cell.textLabel.text = [bObj objectForKey:@"className"];
    BmobUser *user = [bObj objectForKey:@"byUser"];
    cell.detailTextLabel.text = user.username;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"警告" message:@"确定要删除吗?" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            BmobObject *bObj = self.classes[indexPath.row];
            [bObj deleteInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
                if (isSuccessful) {
                    NSLog(@"删除成功");
                }
            }];
            [self.classes removeObject:bObj];
            
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }];
        
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        [ac addAction:action1];
        [ac addAction:action2];
        
        [self presentViewController:ac animated:YES completion:nil];
        
        [self loadClasses];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BmobObject *bObj = self.classes[indexPath.row];
    
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"提示" message:@"请修改班级名称" preferredStyle:UIAlertControllerStyleAlert];
    [ac addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = [bObj objectForKey:@"className"];
    }];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [bObj setObject:ac.textFields.firstObject.text forKey:@"className"];
        NSLog(@"%@", ac.textFields.firstObject.text);
        [bObj setObject:[BmobUser currentUser] forKey:@"byUser"];
        
        [bObj updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
            if (isSuccessful) {
                NSLog(@"保存成功");
                [self loadClasses];
            }
        }];
    }];
    
    
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [ac addAction:action1];
    [ac addAction:action2];
    
    [self presentViewController:ac animated:YES completion:nil];
}



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
