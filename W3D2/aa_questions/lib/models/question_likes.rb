require_relative '../questions_database.rb'
require_relative 'question.rb'
require_relative 'user.rb'

class QuestionLike
  def self.likers_for_question_id(question_id)
    likers = QuestionsDatabase.instance.execute(<<-SQL, question_id)
    SELECT
      users.*
    FROM
      users
    JOIN
      question_likes
    ON
      question_likes.user_id = users.id
    WHERE
      question_likes.question_id = ?
    SQL

    likers.map { |liker| User.new(liker) }
  end

def self.num_likes_for_question_id(question_id)
  count = QuestionsDatabase.instance.execute(<<-SQL, question_id)
  SELECT
    COUNT(*) AS count
  FROM
    users
  JOIN
    question_likes
  ON
    question_likes.user_id = users.id
  WHERE
    question_likes.question_id = ?
  SQL
  count[0]['count']
end

def self.liked_questions_for_user_id(user_id)
  questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
  SELECT
    questions.*
  FROM
    questions
  JOIN
    question_likes
  ON
    question_likes.question_id = questions.id
  WHERE
    question_likes.user_id = ?
  SQL

  questions.map { |question| Question.new(question) }
end

def self.most_liked_questions(n)
  questions = QuestionsDatabase.instance.execute(<<-SQL, n)
  SELECT
    questions.*
  FROM
    questions
  JOIN
    question_likes
  ON
    questions.id = question_likes.question_id
  GROUP BY
    questions.id
  ORDER BY
    COUNT(*)
  LIMIT
    ?
  SQL

  questions.map { |question| Question.new(question) }

end



end
