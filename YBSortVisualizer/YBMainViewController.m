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

static NSInteger kRandomIntegersMaxValue = 200;

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
    _addValuesLabel.text = [NSString stringWithFormat:@"Add %ld integers to start", kMaxValuesInUnsortedArray];
}

- (void)resetData{
    [_dataArray removeAllObjects];
    [_sortVisualizationData removeAllObjects];
    [_sortVisualizationView reloadWithData:nil];
}

#pragma mark - Actions

- (IBAction)addValueButtonClicked:(id)sender{
    if(!_dataArray){
        _dataArray = [NSMutableArray array];
    }
    
    NSString *inputText = _inputValuesTextField.text;
    
    if (_dataArray.count >= kMaxValuesInUnsortedArray) {
        [self showAlertWithMessage:@"Array already has maximum elements. \nGo sort :)"];
        return;
    }
    
    if (inputText.length > 0 && TextIsNumberValue(inputText)) {
        [_dataArray addObject:@([inputText integerValue])];
        [_sortVisualizationView reloadWithData:_dataArray];
        _inputValuesTextField.text = nil;
    } else {
        [self showAlertWithMessage:@"Please enter valid integer"];
    }
}

- (IBAction)addRandomValuesButtonClicked:(id)sender {
    if(!_dataArray){
        _dataArray = [NSMutableArray array];
    }
    [self resetData];
    
    for (int index = 0; index < kMaxValuesInUnsortedArray; index++) {
        [_dataArray addObject:@(arc4random() % kRandomIntegersMaxValue)];
    }
    [_sortVisualizationView reloadWithData:_dataArray];
}

- (IBAction)visualizeSortButtonClicked:(id)sender{
    if (_dataArray.count > 0) {
        [_sortVisualizationView reloadWithData:_dataArray];
        [self shellSort:_dataArray];
        if (_sortVisualizationData.count > 0) {
            for (YBShellSortStep *step in _sortVisualizationData) {
                NSLog(@"%@", [step description]);
                [_sortVisualizationView swapElementWithSortStep:step];
            }
        }
    }
}

- (IBAction)resetButtonClicked:(id)sender{
    [self resetData];
}

#pragma mark - Validation

static bool TextIsNumberValue(NSString *validationText)
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
                    [_sortVisualizationData addObject:sortStep];
                    break;
                } else {
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

#pragma mark - Alerts

- (void)showAlertWithMessage:(NSString *)message{
    if (message.length > 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert" message:message preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}


@end
