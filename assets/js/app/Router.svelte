<script>
  import { Router, Route } from "svelte-navigator";
  import Dashboard from "./views/Dashboard.svelte";
  import Login from "./views/Login.svelte";
  import NotFound from "./views/NotFound.svelte";
  import ShowVehicle from "./views/Vehicles/ShowVehicle.svelte";
  import VehicleList from "./views/Vehicles/VehicleList.svelte";
</script>

<Router>
  <Route path="/"><Dashboard /></Route>
  <Route path="/login"><Login /></Route>
  <Route path="/vehicles"><VehicleList /></Route>
  <Route path="/vehicles/:id"><ShowVehicle /></Route>
  <Route><NotFound /></Route>
</Router>
