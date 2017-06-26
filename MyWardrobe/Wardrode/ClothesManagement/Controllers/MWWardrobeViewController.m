//
//  MWWardrobeViewController.m
//  MyWardrobe
//
//  Created by develop1 on 2017/6/7.
//  Copyright © 2017年 残夜孤鸥. All rights reserved.
//

#import "MWWardrobeViewController.h"
#import "MWMacro.h"
#import "WardrobeViewController.h"
#import "MWClothesDisplayTestViewController.h"
#import "AppDelegate.h"
#import "MWCaseViewModel.h"

@interface MWWardrobeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *dataAry;
@property (nonatomic, strong) AppDelegate *app;

@end

@implementation MWWardrobeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;
    self.app = (AppDelegate *)[[UIApplication sharedApplication] delegate];

//    self.dataAry = [[NSUserDefaults standardUserDefaults] objectForKey:@"clothes_Data"];
    self.dataAry = self.app.dataAry;

    [self.view addSubview:self.myTableView];

}


#pragma mark -- UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataAry.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_id" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"我是%ld衣橱", indexPath.row];
    return cell;
}

#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        [self.navigationController pushViewController:[WardrobeViewController new] animated:YES];
    }else{
        MWClothesDisplayTestViewController *mwward = [[MWClothesDisplayTestViewController alloc] init];
        MWCaseViewModel *model =  self.dataAry[indexPath.row - 1];
        mwward.caseAry = model.caseAry;
        mwward.order = model.order;
        mwward.aLong = model.aLong;
        mwward.caseAry = model.caseAry;

        [self.navigationController pushViewController:mwward animated:YES];
    }

}


#pragma mark -- 懒加载
-(UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, kScreenW, kScreenH-40) style:(UITableViewStylePlain)];
        [_myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell_id"];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
    }
    return _myTableView;
}

-(NSMutableArray *)dataAry{
    if (!_dataAry) {
        _dataAry = [@[] mutableCopy];
    }
    return _dataAry;
}







#pragma mark -- 内存警告
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
