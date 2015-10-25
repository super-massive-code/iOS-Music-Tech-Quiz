//
//  ViewController.m
//  MusicTechQuiz
//
//  Created by Carl  on 25/10/2015.
//  Copyright © 2015 Carl Taylor. All rights reserved.
//

#import "QuestionAnswerViewController.h"
#import "QuestionAnswerModel.h"

@interface QuestionAnswerViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;

@property (strong, nonatomic) NSMutableArray *allModelsArray;
@property (strong, nonatomic) QuestionAnswerModel *currentModel;

@end

@implementation QuestionAnswerViewController

#pragma mark - 
#pragma mark VcLifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *question = @"Name the Roland Acid Synth";
    NSArray *answers = @[@"TB 303", @"Jupiter 8", @"909"];
    
    
    QuestionAnswerModel *model = [[QuestionAnswerModel alloc]initWithQuestion:question answers:answers correctAnswer:@"TB 303"];
    self.currentModel = model;
}

#pragma mark -
#pragma mark TableView DataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.currentModel.answers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = @"answerCell";
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    NSString *answer = [self.currentModel.answers objectAtIndex:indexPath.row];
    cell.textLabel.text = answer;
    
    return cell;
}

#pragma mark -
#pragma mark TableView Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark -
#pragma mark QuestionLoad

-(void)loadNextQuestion
{
    
}


@end
