<script lang="typescript">
  import {
    useGetVehicleQuery,
    Vehicle
  } from "../../graphql/queries/vehicleQueries";
  import { useParams } from "svelte-navigator";
  import Layout from "../../layout/Layout.svelte";
  import PieLoader from "../../components/PieLoader.svelte";
  import FilePicker from "../../components/FilePicker.svelte";
  import { formatVehicleDisplayName } from "../../helpers/vehicleHelpers";

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
  <FilePicker onChange={console.log} />
  <PieLoader size={80} />
</Layout>
