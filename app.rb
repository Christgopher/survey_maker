require("sinatra")
require("sinatra/reloader")
require "sinatra/activerecord"
require("./lib/survey")
require("./lib/question")
require("./lib/answer")
require "./lib/datatable"
also_reload("lib/**/*.rb")
require("pg")
require "pry"

get('/') do
  @surveys = Survey.all()
  erb(:index)
end

get('/manager') do
  @surveys = Survey.all()
  erb(:manager)
end

post('/surveys') do
  survey = Survey.create({title: params.fetch("title")})
  @surveys = Survey.all()
  erb(:index)
end

get('/survey/:id') do
  @survey = Survey.find(params.fetch("id").to_i())
  @questions = Question.all()
  erb(:survey)
end

patch('/survey/:id/edit') do
  @survey = Survey.find(params.fetch("id").to_i())
  title = params.fetch('title')
  @survey.update({title: title})
  @questions = Question.all()
  erb(:survey)
end

post('/questions') do
  question = params.fetch("question")
  @survey = Survey.find(params.fetch("survey_id").to_i())

  question_object = Question.create({:question => question, :survey_id => @survey.id()})
  @questions = Question.all()
  erb(:survey)
end

get('/delete_question/:id') do
  question = Question.find(params.fetch("id").to_i())
  survey = Survey.find(question.survey_id())
  @survey = survey
  question.delete()
  @questions = Question.all()
  erb(:survey)
end

delete('/survey/:id') do
  survey = Survey.find(params.fetch("id").to_i())
  survey.delete()
  @surveys = Survey.all()
  erb(:index)
end

get('/question/:id') do
  @question = Question.find(params.fetch("id").to_i())
  erb(:question)
end

post('/answers') do
  answer = params.fetch("answer")
  @question = Question.find(params.fetch("question_id").to_i())

  answer_object = Answer.create({:answer => answer, :question_id => @question.id()})
  @answer = Answer.all()
  erb(:question)
end

get('/user_survey/:id') do
  @survey = Survey.find(params.fetch("id").to_i())
  @question = @survey.questions.at(0)
  erb(:user_survey)
end

post('/user_survey') do
  answer = Answer.find(params.fetch('answer'))

  question = Question.find(params.fetch("question_id").to_i())

  data = Datatable.create({answer_id: answer.id()})

  @survey = Survey.find(params.fetch("survey_id").to_i())


  if @survey.questions.at(@survey.questions.index(question)+(1)).!=(nil)
    @question = @survey.questions.at(@survey.questions.index(question)+(1))
      erb(:user_survey)
  else
      erb(:end_survey)
  end


end
