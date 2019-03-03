require_relative "../config/environment.rb"
require 'pry'
class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
attr_accessor :id, :name, :grade

def initialize(id = nil, name, grade)
  @id = id
  @name = name
  @grade = grade
end

def self.create_table
  DB[:conn].execute(
    "CREATE TABLE students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade INTEGER
      )"
    )
end

def self.drop_table
  DB[:conn].execute(
    "DROP TABLE students"
    )
end

def save
  if self.id
     self.update
  else
    DB[:conn].execute(
    "INSERT INTO students(name, grade) VALUES (?,?)",
    [self.name, self.grade]
    )
    self.id = DB[:conn].last_insert_row_id
    #binding.pry
  end
end

def update(song)
  DB[:conn].execute("
    UPDATE students SET name = ?, grade = ?, WHERE id = ?
  ",
    [song.name, song.grade, song.id]
    )
end

end
