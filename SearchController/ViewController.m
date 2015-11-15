//
//  ViewController.m
//  SearchController
//
//  Created by Roberts on 15/10/16.
//  Copyright © 2015年 iBokan Wisdom. All rights reserved.
// iOS8中已经将UISearchDisplaycontroller注销了，因为这个类只能将结果显示在tableView上，已经不符合现在所需，从iOS8之后开始用UISearchController类，可以将结果显示在collection或者mapView上，功能更加先进，也容易控制。

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating>

@property (strong, nonatomic) NSArray *allSongs;
@property (strong, nonatomic) NSArray *searchSongs;
@property (strong, nonatomic) UISearchController *searchController;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.navigationItem.title = @"搜索";
    
    // 准备数据源
    self.allSongs = @[
                      @"hahaha",
                      @"Nothing S Gonna Change My Love For You - Westlife",
                      @"Stand By Me - John Lennon",
                      @"Just the Way You Are (ft. Lupe Fiasco) [Remix] - Bruno Mars / Lupe Fiasco",
                      @"Hands Up - Black Eyed Peas",
                      @"When I'm Gone - Eminem",
                      @"Love The Way You Lie - Eminem / Rihanna",
                      @"Gives You Hell - Glee Cast",
                      @"Business - Eminem / DJ Break",
                      @"Never Grow Old - The Cranberries",
                      @"Ridiculous Thoughts - The Cranberrie",
                      @"Someone Like You - Adele",
                      @"Dead and Gone - Justin Timberlake / T.I.",
                      @"The Sound Of Silence - Simon & Garfunkel",
                      @"Long Long Way To Go - Def Leppard",
                      @"Cuckoo - Adam Lambert",
                      @"Time In A Bottle - Jim Croce",
                      @"Whatever Will Be, Will Be - Doris Day",
                      @"Test Drive - John Powell",
                      @"fugitive - Sam Reynolds",
                      @"Could You Ever - C21",
                      @"Sunshine - Skylar Grey",
                      @"Touch My Hand - David Archuleta",
                      @"Mary Jane - The Click Five",
                      @"Oceans Deep - Sons of Day",
                      @"Because You Live - Various Artists / Jesse McCartney",
                      @"Everybody Knows I Love You - Lovebugs",
                      @"What Do You Got? - Bon Jovi",
                      @"Angel - Saybia"
                      ];
    
    UITableViewController *resultController = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    // 初始化UISearchController，最后一个参数为nil表示搜索结果要显示在目前的view上
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:resultController];
    // NO代表搜索时背景不要变暗
    self.searchController.dimsBackgroundDuringPresentation = NO;
    // 指定委托
    resultController.tableView.delegate = self;
    resultController.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.dataSource =self;
    
    // 要将searchBar的高度设置为44.0，searchBar才会出现，默认值为0.0
    self.searchController.searchBar.frame = CGRectMake(0, 0, self.view.frame.size.width, 44);
//    CGRect rect = self.searchController.searchBar.frame;
//    rect.size.height = 44.0;
//    self.searchController.searchBar.frame = rect;
    
    // 将searchBar放到tableView的上方
    self.tableView.tableHeaderView = self.searchController.searchBar;
    // 设置那个Controller要负责响应searchBar的更新
    self.searchController.searchResultsUpdater = self;
    // YES表示UISearchController的画面可以覆盖目前的controller
    self.searchController.definesPresentationContext = NO;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView)
    {
        return self.allSongs.count;
    }
    else
    {
        return self.searchSongs.count;
    }
    
    
//    if (self.searchSongs != nil) {
//        return self.searchSongs.count;
//    }
//    return self.allSongs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",self.allSongs[indexPath.row]);
    UITableViewCell *cell = nil;
    if (tableView == self.tableView)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.textLabel.text = self.allSongs[indexPath.row];
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        cell.textLabel.text = self.searchSongs[indexPath.row];
    }
    return cell;
}

#pragma mark 当用户点击搜索栏以及在搜索栏输入数据时会触发
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *key = self.searchController.searchBar.text;
    self.searchSongs = [self.allSongs filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF CONTAINS[CD] %@",key]];
    
    [((UITableViewController *)self.searchController.searchResultsController).tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
