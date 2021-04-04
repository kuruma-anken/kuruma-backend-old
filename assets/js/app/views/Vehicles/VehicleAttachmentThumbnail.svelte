<script lang="typescript">
  import type { VehicleAttachment } from "../../graphql/queries/vehicleQueries";

  export let attachment: VehicleAttachment;
</script>

<div class="attachment-thumbnail card">
  {#if attachment.attachmentType === "IMAGE"}
    <img src={attachment.publicUrl} alt="" class="preview" />
  {/if}
</div>
