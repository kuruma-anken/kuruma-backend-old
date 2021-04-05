<script>
  import { Router, Route } from "svelte-navigator";
  import Dashboard from "./views/Dashboard.svelte";
  import Login from "./views/Login.svelte";
  import NotFound from "./views/NotFound.svelte";
  import NewVehicle from "./views/Vehicles/NewVehicle.svelte";
  import ShowVehicle from "./views/Vehicles/ShowVehicle.svelte";
  import VehicleList from "./views/Vehicles/VehicleList.svelte";
</script>

<Router>
  <Route path="/"><VehicleList /></Route>
  <Route path="/login"><Login /></Route>
  <Route path="/dashboard"><Dashboard /></Route>
  <Route path="/vehicles/new"><NewVehicle /></Route>
  <Route path="/vehicles/:id"><ShowVehicle /></Route>
  <Route><NotFound /></Route>
</Router>
