//
//  ViewController.m
//  TestAnimal
//
//  Created by FlyOceanFish on 2018/5/11.
//  Copyright © 2018年 FlyOceanFish. All rights reserved.
//

#import "ViewController.h"
#import "MyTableViewCell.h"
#import "SecondViewController.h"
#import "FullScreenTransiontAnimator.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property (nonatomic,strong)NSIndexPath *indexPath;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.delegate = self;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.mTableView.estimatedRowHeight = 0;
    // Do any additional setup after loading the view, typically from a nib.
    UINib *nib = [UINib nibWithNibName:@"MyTableViewCell" bundle:nil];
    [self.mTableView registerNib:nib forCellReuseIdentifier:@"MyTableViewCell"];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 220;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyTableViewCell" forIndexPath:indexPath];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SecondViewController *vc = [[SecondViewController alloc] init];
    self.indexPath = indexPath;
    [self.navigationController pushViewController:vc animated:YES];
}
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC{
    FullScreenTransiontAnimator *animator =[FullScreenTransiontAnimator new];
    animator.indexPath = self.indexPath;
    return animator;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
