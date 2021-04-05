<script lang="typescript">
  import InputField from "../../components/InputField.svelte";
  import CarMakerSelect from "./CarMakerSelect.svelte";
  import VehiclesLayout from "./VehiclesLayout.svelte";

  let form: any = {
    carMakerId: ""
  };

  const onSubmit = () => {
    console.log(form);
  };
</script>

<VehiclesLayout contentTitle="New vehicle">
  <form on:submit|preventDefault={onSubmit}>
    <InputField
      name="registration"
      bind:value={form.registration}
      label="Registration:"
    />
    <CarMakerSelect bind:value={form.carMakerId} />
    <button type="submit" class="button is-primary">Submit</button>
  </form>
</VehiclesLayout>
