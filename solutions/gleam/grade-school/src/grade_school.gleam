import gleam/int
import gleam/list
import gleam/map.{Map}
import gleam/order.{Eq}
import gleam/pair
import gleam/string

pub type School =
  Map(StudentName, ClassGrade)

type StudentName =
  String

type ClassGrade =
  Int

type Student =
  #(StudentName, ClassGrade)

pub fn roster(school: School) -> List(String) {
  school
  |> map.to_list()
  |> list.sort(compare)
  |> list.map(pair.first)
}

pub fn add(
  to school: School,
  student name: StudentName,
  grade grade: ClassGrade,
) -> Result(School, School) {
  case map.has_key(school, name) {
    True -> Error(school)
    False -> Ok(map.insert(school, name, grade))
  }
}

pub fn grade(school: School, desired_grade: ClassGrade) -> List(StudentName) {
  school
  |> map.filter(fn(_, grade) { grade == desired_grade })
  |> map.keys()
  |> list.sort(string.compare)
}

pub fn create() -> School {
  map.new()
}

fn compare(student1: Student, student2: Student) {
  case int.compare(student1.1, student2.1) {
    Eq -> string.compare(student1.0, student2.0)
    r -> r
  }
}
