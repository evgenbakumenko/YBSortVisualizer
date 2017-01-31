//
//  ViewController.m
//  YBSortVisualizer
//
//  Created by Evgen Bakumenko on 1/30/17.
//  Copyright © 2017 Evgen Bakumenko. All rights reserved.
//


#import "YBMainViewController.h"
#import "YBSortVisualizationView.h"
#import "YBShellSortStep.h"

@interface YBMainViewController ()

@property (copy) NSMutableArray *dataArray;
@property (copy) NSMutableArray *sortVisualizationData;
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
        [self shellSort:_dataArray];
        if (_sortVisualizationData.count > 0) {
            for (YBShellSortStep *step in _sortVisualizationData) {
                if (step.exchangeToIndex != step.exchangeFromIndex) {
                    NSLog(@"%@", [step description]);
                    [_sortVisualizationView swapElementAtIndex:step.exchangeFromIndex withElementAtIndex:step.exchangeToIndex];
                }
            }
        }
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

#pragma mark - Sorting

- (NSMutableArray *)shellSort:(NSMutableArray *)arrayToSort
{
    if (!_sortVisualizationData){
        _sortVisualizationData = [NSMutableArray array];
    }
    else {
        [_sortVisualizationData removeAllObjects];
    }
    NSUInteger count = [arrayToSort count];
    
    for (NSInteger i = count / 2; i > 0; i = i / 2) {
        for (NSInteger j = i; j < count; j++) {
            for (NSInteger k = j - i; k >= 0; k = k - i) {
                YBShellSortStep *sortStep = [[YBShellSortStep alloc] initWithIndexOfI:i indexOfJ:j indexOfK:k];
                
                NSLog(@"k index = %ld, j index = %ld, i index = %ld", k, j, i);
                if ([arrayToSort[k + 1] floatValue] >= [arrayToSort[k] floatValue]) {
                    break;
                }
                else {
                    [arrayToSort exchangeObjectAtIndex:k withObjectAtIndex:(k + i)];
                    [sortStep setExchangeFromIndex:k andExchangeToIndex:(k + i)];
                    NSLog(@"Exchange object at %ld with object at %ld", k, (k + i));
                }
                
                [_sortVisualizationData addObject:sortStep];
            }
        }
    }
    
    return arrayToSort;
}


@end
