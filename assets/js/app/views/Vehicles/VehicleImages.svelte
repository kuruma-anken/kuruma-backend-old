<script lang="typescript">
  import VehicleAttachmentThumbnail from "./VehicleAttachmentThumbnail.svelte";
  import type { Vehicle } from "../../graphql/queries/vehicleQueries";
  import FilePicker from "../../components/FilePicker.svelte";
  import UploaderThumbnail from "../../components/UploaderThumbnail.svelte";

  export let vehicle: Vehicle;
  export let reloadVehicle: () => void;
  let upload: File | null = null;

  const onUpload = (ev: any) => {
    if (ev.target?.files?.length) {
      upload = ev.target.files[0];
    }
  };

  const onDone = () => {
    upload = null;
    reloadVehicle();
  };
</script>

<section class="vehicle-images">
  <FilePicker onChange={onUpload} />
  <div class="grid">
    {#each vehicle.attachments as attachment (attachment.id)}
      <VehicleAttachmentThumbnail {attachment} />
    {/each}
    {#if upload}
      <UploaderThumbnail file={upload} vehicleId={vehicle.id} {onDone} />
    {/if}
  </div>
</section>

<style lang="scss">
  @import "../../../../css/_variables.sass";

  .grid {
    display: grid;
    margin-top: 1.5rem;
    grid-template-columns: repeat(auto-fit, $vehicle-image-size);
    gap: 1.5rem;
  }
</style>
