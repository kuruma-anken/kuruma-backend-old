<script lang="typescript">
  import { useGetVehicleQuery } from "../../graphql/queries/vehicleQueries";
  import { useParams } from "svelte-navigator";
  import Layout from "../../layout/Layout.svelte";
  import PieLoader from "../../components/PieLoader.svelte";
  import { onMount } from "svelte";

  const params = useParams();
  const query = useGetVehicleQuery($params.id);
</script>

<Layout title="Vehicles" loading={$query.loading}>
  <h1>Displaying Vehicle</h1>
  <PieLoader size={80} />
</Layout>
