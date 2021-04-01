<script>
  import { Router, Route } from "svelte-navigator";
  import Dashboard from "./views/Dashboard.svelte";
  import Login from "./views/Login.svelte";
  import NotFound from "./views/NotFound.svelte";
</script>

<Router>
  <Route path="/" component={Dashboard} />
  <Route path="/login" component={Login} />
  <Route component={NotFound} />
</Router>
