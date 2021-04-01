<script>
  import InputField from "../components/InputField.svelte";

  let form = {
    email: "",
    password: ""
  };

  const onSubmit = (e) => {
    e.preventDefault();
    console.log(form);
  };
</script>

<div class="login">
  <div class="login-content">
    <div class="card">
      <div class="card-content">
        <h1 class="title">Log in</h1>
        <form on:submit={onSubmit}>
          <InputField
            id="email"
            name="email"
            bind:value={form.email}
            label="Email:"
            type="text"
            autofocus
          />
          <InputField
            id="password"
            name="password"
            type="password"
            label="Password:"
            bind:value={form.password}
          />
          <button class="button is-primary is-fullwidth mt-4">Submit</button>
        </form>
      </div>
    </div>
  </div>
</div>
