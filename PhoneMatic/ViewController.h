//
//  ViewController.h
//  PhoneMatic
//
//  Created by Ashank Singh on 9/21/17.
//  Copyright © 2017 Ashank Singh. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PTDBean.h"
#import "PTDBeanManager.h"
#import "PTDBeanRadioConfig.h"

@interface ViewController : UIViewController <PTDBeanDelegate, PTDBeanManagerDelegate> {
    UILabel *statusLabel;
    UIButton *scanButton;
}

@property (nonatomic, retain) PTDBean *bean;
@property (nonatomic, retain) PTDBeanManager *beanManager;

@end

