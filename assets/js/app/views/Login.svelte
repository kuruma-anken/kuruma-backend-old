<script lang="typescript">
  import { useNavigate, useFocus } from "svelte-navigator";
  import { useAuth } from "../graphql/queries/userQueries";
  const user = useAuth();

  import InputField from "../components/InputField.svelte";
  import { signInMutation } from "../graphql/queries/userQueries";
  import clsx from "clsx";

  const mutate = signInMutation();
  const navigate = useNavigate();
  let loading = false;
  const autoFocus = useFocus();

  $: if (!$user.loading && $user.data?.currentUser) {
    navigate("/");
  }

  let errorMessage: string;

  let form = {
    email: "",
    password: ""
  };

  const onSubmit = async (e: Event) => {
    loading = true;
    const res = await mutate({
      variables: form,
      refetchQueries: ["CurrentUser"],
      awaitRefetchQueries: true
    });
    if (res.data!.signIn.success) {
      errorMessage = "";
      navigate("/");
    } else {
      loading = false;
      errorMessage = "Invalid email/password combination.";
    }
  };
</script>

<div class="login">
  <div class="login-content">
    <div class="card">
      <div class="card-content">
        <form on:submit|preventDefault={onSubmit}>
          <div>
            <h1 class="title mb-4">Log in</h1>
            {#if errorMessage}<div class="notification is-warning">
                {errorMessage}
              </div>{/if}
          </div>
          <div>
            <InputField
              id="email"
              name="email"
              bind:value={form.email}
              label="Email:"
              type="text"
              {autoFocus}
            />
            <InputField
              id="password"
              name="password"
              type="password"
              label="Password:"
              bind:value={form.password}
            />
          </div>
          <button
            class={clsx("button is-primary is-fullwidth mt-4", {
              "is-loading": loading
            })}>Submit</button
          >
        </form>
      </div>
    </div>
  </div>
</div>
