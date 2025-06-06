pub fn expected_minutes_in_oven() -> Int {
    40
}

pub fn remaining_minutes_in_oven(elapsed_time: Int) -> Int {
    expected_minutes_in_oven() - elapsed_time
}

pub fn preparation_time_in_minutes(layers: Int) -> Int {
    2 * layers
}

pub fn total_time_in_minutes(layers: Int, elapsed_time: Int) -> Int {
    preparation_time_in_minutes(layers) + elapsed_time
}

pub fn alarm() {
    "Ding!"
}
