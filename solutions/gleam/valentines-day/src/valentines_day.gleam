pub type Approval {
  Yes
  No
  Maybe
}

pub type Genre {
  Crime
  Horror
  Romance
  Thriller
}

pub type Cuisine {
  Korean
  Turkish
}

pub type Activity {
  BoardGame
  Chill
  Movie(Genre)
  Restaurant(Cuisine)
  Walk(Int)
}

pub fn rate_activity(activity: Activity) -> Approval {
  case activity {
    Movie(Romance) | Restaurant(Korean) -> Yes
    Walk(i) if i > 11 -> Yes
    Restaurant(Turkish) -> Maybe
    Walk(i) if i > 6 -> Maybe
    _ -> No
  }
}
