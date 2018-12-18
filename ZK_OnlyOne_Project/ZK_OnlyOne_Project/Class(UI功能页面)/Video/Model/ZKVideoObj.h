//
//  ZKVideoObj.h
//  ZK_OnlyOne_Project
//
//  Created by 01 on 2018/12/18.
//  Copyright © 2018 极客_艾欧尼亚. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZKVideoAuthorModel : NSObject<YYModel>

@property (nonatomic, copy) NSString        *fans_num;
@property (nonatomic, copy) NSString        *follow_num;
@property (nonatomic, copy) NSString        *gender;
@property (nonatomic, copy) NSString        *intro;
@property (nonatomic, copy) NSString        *is_follow;
@property (nonatomic, copy) NSString        *name_show;
@property (nonatomic, copy) NSString        *portrait;
@property (nonatomic, copy) NSString        *user_id;
@property (nonatomic, copy) NSString        *user_name;

@end

@interface ZKVideoObj : NSObject

@property (nonatomic, copy) NSString        *agree_num;
@property (nonatomic, copy) NSString        *agreed_num;
@property (nonatomic, strong) ZKVideoAuthorModel   *author;
@property (nonatomic, copy) NSString        *comment_num;
@property (nonatomic, copy) NSString        *create_time;
@property (nonatomic, copy) NSString        *first_frame_cover;
@property (nonatomic, copy) NSString        *is_deleted;
@property (nonatomic, copy) NSString        *is_private;
@property (nonatomic, copy) NSString        *need_hide_title;
@property (nonatomic, copy) NSString        *play_count;
@property (nonatomic, copy) NSString        *post_id;
@property (nonatomic, copy) NSString        *share_num;
@property (nonatomic, copy) NSString        *tags;
@property (nonatomic, copy) NSString        *thread_id;
@property (nonatomic, copy) NSString        *thumbnail_height;
@property (nonatomic, copy) NSString        *thumbnail_url;
@property (nonatomic, copy) NSString        *thumbnail_width;
@property (nonatomic, copy) NSString        *title;
@property (nonatomic, copy) NSString        *video_duration;
@property (nonatomic, copy) NSString        *video_height;
@property (nonatomic, copy) NSString        *video_length;
@property (nonatomic, copy) NSString        *video_log_id;
@property (nonatomic, copy) NSString        *video_url;
@property (nonatomic, copy) NSString        *video_width;

@end

NS_ASSUME_NONNULL_END
