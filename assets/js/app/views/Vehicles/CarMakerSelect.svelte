<script lang="ts">
  import Select from "../../components/Select.svelte";
  import { SelectOption } from "../../graphql/interfaces/common";
  import { useListCarMakersForSelect } from "../../graphql/queries/carModelQueries";

  export let value: string | number;
  let options: SelectOption[] = [];
  const query = useListCarMakersForSelect();
  $: options = $query.data?.listCarMakers ?? [];
</script>

<Select {options} bind:value name="carMakerId" label="Car maker:" />
