require_relative '../questions_database.rb'

class Reply

  attr_accessor :body, :question_id, :user_id, :parent_id
  def initialize(options)
    @id = options['id']
    @body = options['body']
    @question_id = options['question_id']
    @user_id = options['user_id']
    @parent_id = options['parent_id']
  end

  def self.find_by_id(id)
  id_data = QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT
      *
    FROM
      replies
    WHERE
      id = ?
  SQL

  id_data.map { |datum| Reply.new(datum) }[0]

  end

  def self.find_by_user_id(user_id)
  id_data = QuestionsDatabase.instance.execute(<<-SQL, user_id)
    SELECT
      *
    FROM
      replies
    WHERE
      user_id = ?
  SQL

  id_data.map { |datum| Reply.new(datum) }

  end

  def self.find_by_question_id(question_id)
  id_data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
    SELECT
      *
    FROM
      replies
    WHERE
      question_id = ?
  SQL

  id_data.map { |datum| Reply.new(datum) }

  end

  def author
    User.find_by_id(@user_id)
  end

  def question
    Question.find_by_id(@question_id)
  end

  def parent_reply
    raise "No parent id" unless @parent_id
    Reply.find_by_id(@parent_id)
  end

  def child_replies
    child_data = QuestionsDatabase.instance.execute(<<-SQL, @id)
    SELECT
      *
    FROM
      replies
    WHERE
      parent_id = ?
    SQL
    child_data.map { |c_reply| Reply.new(c_reply) }
  end

end
