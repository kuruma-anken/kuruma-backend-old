<script lang="typescript">
  import useParams from "../../hooks/useParams";

  import {
    PaginateVehiclesQueryVariables,
    usePaginateVehiclesQuery,
    Vehicle
  } from "../../graphql/queries/vehicleQueries";
  import Layout from "../../layout/Layout.svelte";
  import Loader from "../../components/Loader.svelte";

  let vehicles: ReadonlyArray<Vehicle> = [];
  const params = useParams<PaginateVehiclesQueryVariables>();
  const page = Number($params.page) || 1;
  const query = usePaginateVehiclesQuery({ page });
  $: vehicles = $query.data?.result?.data || [];
</script>

<Layout title="Vehicles">
  {#if $query.data}
    <table class="table is-bordered is-hoverable is-fullwidth crud-table">
      <thead>
        <tr>
          <th class="id">ID</th>
          <th>Registration</th>
          <th>Manufacturing Year</th>
          <th>Model</th>
        </tr>
      </thead>
      <tbody>
        {#each vehicles as vehicle (vehicle.id)}
          <tr>
            <td class="id">{vehicle.id}</td>
            <td>{vehicle.registration}</td>
            <td>{vehicle.manufacturingYear}</td>
            <td>{vehicle.carModel.carMaker.name} {vehicle.carModel.name}</td>
          </tr>
        {/each}
      </tbody>
    </table>
  {:else}
    <Loader />
  {/if}
</Layout>
