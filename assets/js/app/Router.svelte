<script>
  import { Router, Route } from "svelte-navigator";
  import Dashboard from "./views/Dashboard.svelte";
  import Login from "./views/Login.svelte";
</script>

<Router>
  <Route path="/"><Dashboard /></Route>
  <Route path="/login"><Login /></Route>
</Router>
