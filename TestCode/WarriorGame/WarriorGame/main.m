//
//  main.m
//  WarriorGame
//
//  Created by Hanson Jung on 2017. 1. 29..
//  Copyright © 2017년 Hanson Jung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Warrior.h"
#import "Wizard.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        Warrior *jack = [[Warrior alloc] init];
        jack.name = @"잭";
        jack.health = 100;
        
        
        Wizard *rose = [[Wizard alloc] init];
//      rose.name = @"장미";
        
        
        [jack attack:@"장미"];
        [rose attack:jack.name];
        
        
        
        
    }
    return 0;
}