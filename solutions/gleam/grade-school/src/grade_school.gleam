import gleam/int
import gleam/list
import gleam/dict.{type Dict}
import gleam/order.{Eq}
import gleam/pair
import gleam/string

pub type School =
  Dict(StudentName, ClassGrade)

type StudentName =
  String

type ClassGrade =
  Int

type Student =
  #(StudentName, ClassGrade)

pub fn roster(school: School) -> List(String) {
  school
  |> dict.to_list()
  |> list.sort(compare)
  |> list.map(pair.first)
}

pub fn add(
  to school: School,
  student name: StudentName, 
  grade grade: ClassGrade,
) -> Result(School, School) {
  case dict.has_key(school, name) {
    True -> Error(school)
    False -> Ok(dict.insert(school, name, grade))
  }
}

pub fn grade(school: School, desired_grade: ClassGrade) -> List(StudentName) {
  school
  |> dict.filter(fn(_, grade) { grade == desired_grade })
  |> dict.keys()
  |> list.sort(string.compare)
}

pub fn create() -> School {
  dict.new()
}

fn compare(student1: Student, student2: Student) {
  case int.compare(student1.1, student2.1) {
    Eq -> string.compare(student1.0, student2.0)
    r -> r
  }
}
