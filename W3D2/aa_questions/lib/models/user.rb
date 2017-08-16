require_relative '../questions_database.rb'
require_relative 'question_follows.rb'
require_relative 'question_likes.rb'

class User
  attr_accessor :fname, :lname, :is_instructor
  def self.find_by_id(id)
    user_data = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        users
      WHERE
        id = ?
    SQL
    return nil unless user_data.length > 0
    user_data.map { |user| User.new(user)}[0]
  end

  def self.find_by_name(fname, lname)
    user_data = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
    SELECT
    *
    FROM
    users
    WHERE
    fname = ? AND lname = ?
    SQL

    user_data.map { |user| User.new(user) }[0]
  end

  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
    @is_instructor = options['is_instructor']
  end

  def authored_questions
    if @id.nil?
      raise "The id doesn't exist."
    else
      Question.find_by_author_id(@id)
    end
  end

  def authored_replies
    if @id.nil?
      raise "The id doesn't exist."
    else
      Reply.find_by_user_id(@id)
    end
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(@id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(@id)
  end

end
