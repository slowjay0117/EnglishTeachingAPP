//
//  LYRecordButton.h
//  ITSNS
//
//  Created by Ivan on 16/1/13.
//  Copyright © 2016年 Ivan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCVoice.h"
@protocol RecordButtonDelegate <NSObject>
- (void)didFinishRecordAction:(NSData *)audioData andTime:(float)time;
@end
@interface RecordButton : UIButton
@property (nonatomic, weak)id<RecordButtonDelegate> delegate;
@property (nonatomic, strong)LCVoice *voice;
@end
