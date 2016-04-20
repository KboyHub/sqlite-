//
//  ViewController.m
//  TTTTTT
//
//  Created by 闫康 on 16/4/19.
//  Copyright © 2016年 yankang. All rights reserved.
//

#import "ViewController.h"
#import "YDContact.h"
#import "YDContactTool.h"


@interface ViewController ()

@property (nonatomic,strong)YDContact *contact;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _contact = [[YDContact alloc]init];
    _contact.roleID = @"1111111";
    _contact.name = @"小明";
    _contact.iconUrl = @"www.baidu.com";
}
- (IBAction)add:(id)sender {
//    _contact.name = @"小张";
//    _contact.roleID = @"3333333";
//    _contact.iconUrl = @"www.baidu.com";
    [YDContactTool updateContact:_contact];
    
}
- (IBAction)update:(id)sender {
    _contact.roleID = @"1111111";
    _contact.iconUrl = @"www.1111.com";
    _contact.name = @"小lei";
    [YDContactTool updateContact:_contact];
}
- (IBAction)look:(id)sender {
    NSArray *contactArray = [[YDContactTool contactArray]copy];
    for (YDContact *contact in contactArray) {
        NSLog(@"%@,%@,%@",contact.roleID,contact.name,contact.iconUrl);
    }
}

- (IBAction)getOneContact:(id)sender {
    YDContact *contact = [YDContactTool getContactByRoleID:@"1111111"];
     NSLog(@"%@,%@,%@",contact.roleID,contact.name,contact.iconUrl);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
