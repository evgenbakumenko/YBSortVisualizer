//
//  ViewController.m
//  YBSortVisualizer
//
//  Created by Evgen Bakumenko on 1/30/17.
//  Copyright © 2017 Evgen Bakumenko. All rights reserved.
//


#import "YBMainViewController.h"
#import "YBSortVisualizationView.h"

@interface YBMainViewController ()

@property (copy) NSMutableArray *dataArray;
@property (strong, nonatomic) IBOutlet UILabel *addValuesLabel;
@property (strong, nonatomic) IBOutlet UITextField *inputValuesTextField;
@property (strong, nonatomic) IBOutlet YBSortVisualizationView *sortVisualizationView;

@end

@implementation YBMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setupView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupView{
    _addValuesLabel.text = [NSString stringWithFormat:@"Add up to %d integers to start", kMaxValuesInUnsortedArray];
}

#pragma mark - Actions

- (IBAction)addValueButtonClicked:(id)sender{
    if(!_dataArray){
        _dataArray = [NSMutableArray array];
    }
    
    if (_inputValuesTextField.text.length > 0 && TextIsNumberValue(_inputValuesTextField.text)) {
        [_dataArray addObject:@([_inputValuesTextField.text integerValue])];
        _inputValuesTextField.text = nil;
    }
}

- (IBAction)visualizeSortButtonClicked:(id)sender{
    if (_dataArray.count > 0) {
        [_sortVisualizationView reloadWithData:_dataArray];
    }
}

#pragma mark - Visualization


#pragma mark - Validation

static bool TextIsNumberValue( NSString *validationText)
{
    BOOL isValid;
    NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:validationText];
    isValid = [alphaNums isSupersetOfSet:inStringSet];
    return isValid;
}

@end
