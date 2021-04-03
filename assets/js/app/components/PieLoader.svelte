<script lang="typescript">
  export let size = 250;
  export let progress: number | null = null;
  const half = size / 2;
  let path = "";

  function draw(progress: number, size: number) {
    const π = Math.PI;
    const α = (progress % 1) * 360;
    const r = (α * π) / 180,
      x = Math.sin(r) * half,
      y = Math.cos(r) * -half,
      mid = α > 180 ? 1 : 0;
    return (
      `M 0 0 v -${half} A ${half} ${half} 1 ` + mid + " 1 " + x + " " + y + " z"
    );
  }

  $: path = progress ? draw(progress, size) : "";
</script>

{#if progress !== null}
  <svg
    width={size}
    height={size}
    viewBox="0 0 {size} {size}"
    class="pie-loader"
  >
    <path transform="translate({half}, {half})" d={path} />
  </svg>
{/if}

<style lang="scss">
  .pie-loader {
    display: block;
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
  }

  .pie-loader path {
    fill: transparentize(#fff, 0.3);
  }
</style>
