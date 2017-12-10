//
//  ViewController.m
//  PhoneMatic
//
//  Created by Ashank Singh on 9/21/17.
//  Copyright © 2017 Ashank Singh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, retain) UISlider *slider;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGAffineTransform trans = CGAffineTransformMakeRotation(M_PI_2);
    self.slider.transform = trans;
    // Do any additional setup after loading the view, typically from a nib.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) startScanning {
    if (self.bean.state == BeanState_ConnectedAndValidated) {
        NSError *error;
        [self.beanManager disconnectBean:self.bean error:&error];
        if (error) statusLabel.text = [error localizedDescription];
        [scanButton setTitle:@"Search for PhoneMatics" forState:UIControlStateNormal];
        
    } else {
        if(self.beanManager.state == BeanManagerState_PoweredOn) {
            NSError *error;
            [self.beanManager startScanningForBeans_error:&error];
            statusLabel.text = @"Looking for PhoneMatics...";
            if (error) {
                statusLabel.text = [error localizedDescription];
            }
        } else {
            statusLabel.text = @" ";
        }
    }
}


- (void) sliderMoved:(UISlider *)sender {
    float maxPos = 180;                                  // Max position of servo
    unsigned int sendData = floor(sender.value * maxPos);    // Convert slider value to servo rotation degrees
    
    if (self.bean) {
        NSMutableData *data = [NSMutableData dataWithBytes:&sendData length:sizeof(sendData)];
        
        // Cancel any pending data sends
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
        
        // We send the data after 0.3 seconds to avoid the quick movement of the slider backing up send commands
        [self performSelector:@selector(sendDataToBean:) withObject:data afterDelay:0.3];
        
    }
}

- (void) sendDataToBean:(NSMutableData *)sendData {
    [self.bean setScratchNumber:1 withValue:sendData];
}



// check the delegate value
-(void)bean:(PTDBean *)bean didUpdateScratchNumber:(NSNumber *)number withValue:(NSData *)data {
    unsigned int scratchNumber;
    [data getBytes:&scratchNumber length:sizeof(unsigned int)];
   // NSLog(@"Program number : %d", z);
}

// bean discovered
- (void)BeanManager:(PTDBeanManager*)beanManager didDiscoverBean:(PTDBean*)bean error:(NSError*)error{
    if (error) {
        statusLabel.text = [error localizedDescription];
        return;
    }
    statusLabel.text = [NSString stringWithFormat:@"PhoneMatic found: %@",[bean name]];
    [self.beanManager connectToBean:bean error:nil];
}


// bean connected
- (void)BeanManager:(PTDBeanManager*)beanManager didConnectToBean:(PTDBean*)bean error:(NSError*)error{
    if (error) {
        statusLabel.text = [error localizedDescription];
        return;
    }
    statusLabel.text = [NSString stringWithFormat:@"Connected to %@",[bean name]];
    self.bean = bean;
    self.bean.delegate = self;
    
    [scanButton setTitle:@"Disconnect" forState:UIControlStateNormal];
    
}




@end
