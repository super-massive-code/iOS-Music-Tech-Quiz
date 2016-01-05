//
//  GameEngine.h
//  MusicTechQuiz
//
//  Created by Carl  on 05/01/2016.
//  Copyright © 2016 Carl Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>

@class QuestionAnswerCompModel;

@protocol GameEngineDelegate <NSObject>
@required
-(void)gameEngineDelegateDidConfirmAnswerIsCorrect:(BOOL)answerCorrect;
-(void)gameEngineDelegateDidLoadNextQuestion:(QuestionAnswerCompModel*)model;
-(void)gameEngineDelegateDidEndWithTotalScore:(NSNumber*)totalScore;
@end

@interface GameEngine : NSObject

-(void)startGame;
-(void)answerNumberSelected:(NSInteger)answerNumber;

@property (nonatomic, weak) id<GameEngineDelegate>delegate;

@end
