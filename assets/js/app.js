// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import "../css/app.scss";
import App from "./app/App.svelte";

document.addEventListener("DOMContentLoaded", () => {
  const container = document.getElementById("App");
  if (container) {
    new App({
      target: container
    });
  }
});
