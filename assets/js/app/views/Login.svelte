<script lang="typescript">
  import { useNavigate } from "svelte-navigator";
  import { useAuth } from "../graphql/queries/userQueries";
  const user = useAuth();

  import InputField from "../components/InputField.svelte";
  import { signInMutation } from "../graphql/queries/userQueries";

  const mutate = signInMutation();
  const navigate = useNavigate();

  $: if (!$user.loading && $user.data?.currentUser) {
    navigate("/");
  }

  let errorMessage: string;

  let form = {
    email: "",
    password: ""
  };

  const onSubmit = async (e: Event) => {
    e.preventDefault();
    const res = await mutate({
      variables: form,
      refetchQueries: ["CurrentUser"],
      awaitRefetchQueries: true
    });
    if (res.data!.signIn.success) {
      errorMessage = "";
      navigate("/");
    } else {
      errorMessage = "login failed";
    }
  };
</script>

<div class="login">
  <div class="login-content">
    <div class="card">
      <div class="card-content">
        <form on:submit={onSubmit}>
          <h1 class="title">Log in</h1>
          <div>
            {#if errorMessage}<div class="notification is-danger">
                {errorMessage}
              </div>{/if}
            <InputField
              id="email"
              name="email"
              bind:value={form.email}
              label="Email:"
              type="text"
              autofocus={true}
            />
            <InputField
              id="password"
              name="password"
              type="password"
              label="Password:"
              bind:value={form.password}
            />
          </div>
          <button class="button is-primary is-fullwidth mt-4">Submit</button>
        </form>
      </div>
    </div>
  </div>
</div>
