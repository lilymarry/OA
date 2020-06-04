#import "SelectPIckView.h"

@implementation SelectPIckView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        _pickView =[[UIPickerView alloc]initWithFrame:CGRectMake(0, 30, self.frame.size.width, self.frame.size.height-50)];
        _pickView.backgroundColor=[UIColor lightTextColor];
        _pickView.dataSource=self;
        _pickView.delegate=self;
        [self addSubview:_pickView];
        UIButton *quedin=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        quedin.frame=CGRectMake(self.frame.size.width-50, 0,50, 30);
        [quedin setTitle:@"确定" forState:UIControlStateNormal];
        [quedin addTarget:self action:@selector(sureBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:quedin];
    }
    return self;
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.dataArr.count;
}
//#pragma mark-UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{ 
 
    return [self.dataArr objectAtIndex:row];
}

- (void)sureBtnPress:(id)sender
{
    int  rowI=  (int) [_pickView selectedRowInComponent:0];
    _selected = [self.dataArr objectAtIndex:rowI];
    if ([self.delegate respondsToSelector:@selector(doButtonWithSelectRow:state:selectRow:)])
    {
        [self.delegate doButtonWithSelectRow:_selected state:_state selectRow:rowI];
    }
}
-(void)reloaPickView
{

    [_pickView reloadAllComponents];

}
@end
