//
//  RenWuDetailHotModel.m
//  Re-OA
//
//  Created by imac-1 on 2016/11/7.
//  Copyright © 2016年 姜任鹏. All rights reserved.
//

#import "RenWuDetailHotModel.h"

@implementation RenWuDetailHotModel
-(id)initWithJson:(NSDictionary *)json;
{
    self = [super init];
    if(self)
    {
        if(json != nil)
        {
            self.Taop_Comment  = [json objectForKey:@"Taop_Comment"];
            self.Taop_Date  = [json objectForKey:@"Taop_Date"];
            self.Taop_Date_1  = [json objectForKey:@"Taop_Date_1"];
            self.Taop_Description  = [json objectForKey:@"Taop_Description"];
            self.Taop_Id  = [json objectForKey:@"Taop_Id"];
            
            self.Taop_Img1  = [json objectForKey:@"Taop_Img1"];
            self.Taop_Img2  = [json objectForKey:@"Taop_Img2"];
            
            self.Taop_Img3  = [json objectForKey:@"Taop_Img3"];
            self.Taop_ImgDate1  = [json objectForKey:@"Taop_ImgDate1"];
            self.Taop_ImgDate2  = [json objectForKey:@"Taop_ImgDate2"];
            self.Taop_ImgDate3  = [json objectForKey:@"Taop_ImgDate3"];
            
            self.Taop_IsSee  = [json objectForKey:@"Taop_IsSee"];
            self.Taop_IsTimeout  = [json objectForKey:@"Taop_IsTimeout"];
            self.Taop_Iscomplete  = [json objectForKey:@"Taop_Iscomplete"];
            self.Taop_Latitude1=[json objectForKey:@"Taop_Latitude1"];
            
            self.Taop_Latitude2  = [json objectForKey:@"Taop_Latitude2"];
            self.Taop_Latitude3  = [json objectForKey:@"Taop_Latitude3"];
            
            self.Taop_Longitude1  = [json objectForKey:@"Taop_Longitude1"];
            self.Taop_Longitude2  = [json objectForKey:@"Taop_Longitude2"];
            self.Taop_Longitude3  = [json objectForKey:@"Taop_Longitude3"];
            self.Taop_Taid  = [json objectForKey:@"Taop_Taid"];
            
            self.Taop_UserName  = [json objectForKey:@"Taop_UserName"];
            self.Taop_Userid  = [json objectForKey:@"Taop_Userid"];
            self.Taop_Describe1  = [json objectForKey:@"Taop_Describe1"];
             self.Taop_Describe2  = [json objectForKey:@"Taop_Describe2"];
              self.Taop_Describe3  = [json objectForKey:@"Taop_Describe3"];
        }
    }
    return self;
}

@end
