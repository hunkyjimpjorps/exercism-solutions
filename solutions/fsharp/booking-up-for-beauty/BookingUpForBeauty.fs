module BookingUpForBeauty

open System

let schedule (appointmentDateDescription: string) : DateTime =
    DateTime.Parse(appointmentDateDescription)

let hasPassed (appointmentDate: DateTime) : bool =
    appointmentDate <= DateTime.Now

let isAfternoonAppointment (appointmentDate: DateTime) : bool =
    let h = appointmentDate.Hour
    h >= 12 && h < 18

let description (appointmentDate: DateTime) : string =
    $"You have an appointment on {appointmentDate.ToString()}."

let anniversaryDate () : DateTime = DateTime(DateTime.Now.Year, 9, 15)
