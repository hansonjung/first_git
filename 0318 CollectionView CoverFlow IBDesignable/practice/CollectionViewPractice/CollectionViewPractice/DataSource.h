//
//  DataSource.h
//  CollectionViewPractice
//
//  Created by Dabu on 2017. 3. 19..
//  Copyright © 2017년 Dabu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ParkData.h"

@interface DataSource : NSObject


- (NSInteger)numberOfSections;
- (NSInteger)numberOfItems;
- (ParkData *)parkDataAtIndexPath:(NSIndexPath *)indexPath;

@end
