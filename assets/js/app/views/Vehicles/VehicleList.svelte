<script lang="typescript">
  import useParams from "../../hooks/useParams";

  import type {
    PaginateVehiclesQueryVariables,
    Vehicle
  } from "../../graphql/queries/vehicleQueries";
  import { usePaginateVehiclesQuery } from "../../graphql/queries/vehicleQueries";
  import type { ID } from "../../graphql/interfaces/common";
  import { navigate } from "svelte-navigator";
  import VehiclesLayout from "./VehiclesLayout.svelte";

  let vehicles: ReadonlyArray<Vehicle> = [];
  const params = useParams<PaginateVehiclesQueryVariables>();
  const page = Number($params.page) || 1;
  const query = usePaginateVehiclesQuery({ page });
  $: vehicles = $query.data?.result?.data || [];

  const onClick = (id: ID) => () => {
    navigate(`/vehicles/${id}`);
  };
</script>

<VehiclesLayout loading={$query.loading}>
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
        <tr on:click={onClick(vehicle.id)}>
          <td class="id">{vehicle.id}</td>
          <td>{vehicle.registration}</td>
          <td>{vehicle.manufacturingYear}</td>
          <td>{vehicle.carModel.carMaker.name} {vehicle.carModel.name}</td>
        </tr>
      {/each}
    </tbody>
  </table>
</VehiclesLayout>
