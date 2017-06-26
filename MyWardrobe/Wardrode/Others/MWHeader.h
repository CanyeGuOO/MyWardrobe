//
//  MWHeader.h
//  MyWardrobe
//
//  Created by develop1 on 2017/5/15.
//  Copyright © 2017年 残夜孤鸥. All rights reserved.
//

#ifndef MWHeader_h
#define MWHeader_h



#define MWNetwork_Api_Host @"https://123456"

/// 接口路径全拼
#define MW_PATH(_path) [NSString stringWithFormat:_path, MWNetwork_Api_Host]

/// 登陆
#define MW_Api_Login MW_PATH(@"%@/")






#endif /* MWHeader_h */
