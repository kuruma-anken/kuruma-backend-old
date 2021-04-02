alias Kuruma.Repo

alias Kuruma.CarMakers
alias Kuruma.CarModels
alias Kuruma.Vehicles
alias Kuruma.Users

{:ok, maker} = CarMakers.create_car_maker(%{name: "BMW"})

{:ok, e36} = CarModels.create_car_model(%{car_maker_id: maker.id, name: "E36"})

{:ok, _} =
  Vehicles.create_vehicle(%{
    registration: "ANN2137",
    car_model_id: e36.id,
    manufacturing_year: 1997
  })

Users.create_user(%{
  first_name: "John",
  last_name: "Smith",
  email: "user@example.com",
  password: "foobar",
  password_confirmation: "foobar"
})
