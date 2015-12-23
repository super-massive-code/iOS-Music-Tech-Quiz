//
//  QuestionUpdateManager.m
//  MusicTechQuiz
//
//  Created by Carl  on 25/10/2015.
//  Copyright © 2015 Carl Taylor. All rights reserved.
//

#import "UpdateManager.h"
#import "ServerComms.h"
#import "BaseRealmObj.h"

//url(r'^$', views.api_route),
//url(r'^login_user', views.login_user),
//url(r'^updates_since/(?P<epoch_time>[+\d]+)', views.get_updates_since),
//url(r'^all_questions', views.get_all_questions),
//url(r'^question/(?P<question_id>[+\d]+)$', views.get_question),
//url(r'^add_question_with_answers', views.post_question),
//url(r'^delete_question', views.delete_question),
//url(r'^answer/(?P<answer_id>[+\d]+)$', views.get_answer),
//url(r'^user/(?P<username>[+\w]+)$', views.get_user),


@implementation UpdateManager

+(void)checkForUpdates
{
    // NSDate last update time
    
  
   
  NSString *url = @"https://carltaylor43.pythonanywhere.com/updates_since/7878";
    
    ServerComms *comms = [[ServerComms alloc]init];
    [comms getJSONfromUrl:url callCallBack:^(ServerResponse *responseObject) {
        
    }];
}

-(void)saveToStore
{
    // create questionStoreController
}

@end
