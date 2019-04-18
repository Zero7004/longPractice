//
//  AppPush.h
//  longPractice
//
//  Created by forms on 2019/4/18.
//  Copyright © 2019 Long. All rights reserved.
//

#ifndef AppPush_h
#define AppPush_h

//storyboard push
#define PushVC(storyboardName,VCName)  \
UIStoryboard *sb = [UIStoryboard storyboardWithName:storyboardName bundle:nil];\
UIViewController *vc = [sb instantiateViewControllerWithIdentifier:VCName];\
[self.navigationController pushViewController:vc animated:YES];\

//普通push
#define PushToVC(pushString) \
UIViewController *vc = [[NSClassFromString(pushString) alloc]init];\
[self.navigationController pushViewController:vc animated:YES];\

//普通POPVC
#define POPVC [self.navigationController popViewControllerAnimated:YES];\

#define UIStoryboardVC(name,identifier) [[UIStoryboard storyboardWithName:name bundle:nil] instantiateViewControllerWithIdentifier:identifier];

#endif /* AppPush_h */
