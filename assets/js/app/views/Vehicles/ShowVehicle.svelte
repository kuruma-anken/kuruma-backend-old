<script lang="typescript">
  import { useGetVehicleQuery } from "../../graphql/queries/vehicleQueries";
  import type { Vehicle } from "../../graphql/queries/vehicleQueries";
  import { useParams } from "svelte-navigator";
  import Layout from "../../layout/Layout.svelte";
  import { formatVehicleDisplayName } from "../../helpers/vehicleHelpers";
  import VehicleImages from "./VehicleImages.svelte";

  let vehicle: Vehicle | null;
  let title: string | null;
  const params = useParams();
  const query = useGetVehicleQuery($params.id);
  $: vehicle = $query.data?.vehicle ?? null;
  $: title = formatVehicleDisplayName(vehicle);
</script>

<Layout
  title="Vehicles"
  loading={$query.loading}
  contentTitle={`Vehicle: ${title}`}
>
  {#if vehicle}<VehicleImages {vehicle} />{/if}
</Layout>
