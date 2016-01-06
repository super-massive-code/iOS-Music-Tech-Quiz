//
//  GameEngine.h
//  MusicTechQuiz
//
//  Created by Carl  on 05/01/2016.
//  Copyright © 2016 Carl Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>

@class QuestionAnswerCompModel;

@protocol GameControllerDelegate <NSObject>
@required
-(void)gameControllerDelegateDidConfirmAnswerIsCorrect:(BOOL)answerCorrect forUserAnswer:(NSString*)userAnswer withCorrectAnswer:(NSString*)correctAnswer;
-(void)gameControllerDelegateDidLoadNextQuestion:(QuestionAnswerCompModel*)model;
-(void)gameControllerDelegateDidEndWithTotalScore:(NSNumber*)totalScore;
-(void)gameControllerDelegateTimerDidRunOut;
@optional
-(void)gameControllerDelegateTimeUpdate:(NSInteger)timeLeft;
@end

@interface GameController : NSObject

-(void)loadNextQuestion;
-(void)answerSelected:(NSString*)answer;

@property (nonatomic, weak) id<GameControllerDelegate>delegate;

@end
