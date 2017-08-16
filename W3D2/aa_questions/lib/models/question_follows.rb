require_relative '../questions_database.rb'
require_relative 'user.rb'
require_relative 'question.rb'

class QuestionFollow
  def self.followers_for_question_id(question_id)
    followers = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        users.*
      FROM
        users
      JOIN
        question_follows
      ON
        users.id = question_follows.user_id
      WHERE
        question_follows.question_id = ?
    SQL

    followers.map { |follower| User.new(follower) }
  end

  def self.followed_questions_for_user_id(user_id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
    SELECT
      questions.*
    FROM
      questions
    JOIN
      question_follows
    ON
      question_id = questions.id
    WHERE
      question_follows.user_id = ?
    SQL

    questions.map { |q| Question.new(q) }
  end

  def self.most_followed_questions(n)
    questions = QuestionsDatabase.instance.execute(<<-SQL, n)
    SELECT
      questions.*
    FROM
      questions
    JOIN
      question_follows
    ON
      questions.id = question_follows.question_id
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
