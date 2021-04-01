import gql from "graphql-tag";
import { query, mutation } from "svelte-apollo";

export const CURRENT_USER_QUERY = gql`
  query CurrentUser {
    currentUser {
      id
      email
      firstName
      lastName
    }
  }
`;

interface User {
  id: string | number;
  email: string;
  firstName: string;
  lastName: string;
}
interface CurrentUserQueryResult {
  currentUser: User | null;
}

export const useAuth = () => query<CurrentUserQueryResult>(CURRENT_USER_QUERY);

export const SIGN_IN_MUTATION = gql`
  mutation SignIn($email: String!, $password: String!) {
    signIn(email: $email, password: $password) {
      success
      errors
      data {
        user {
          id
        }
        accessToken
      }
    }
  }
`;

export interface SignInMutationResult {
  signIn: {
    success: boolean;
    errors: Record<string, string> | null;
    data: {
      user: User;
      accessToken: string;
    } | null;
  };
}

export interface SignInMutationVariables {
  email: string;
  password: string;
}

export const SIGN_OUT_MUTATION = gql`
  mutation SignOut {
    signOut {
      success
    }
  }
`;

export const useSignOutMutation = () => {
  const mutate = mutation(SIGN_OUT_MUTATION);
  return () => {
    mutate({ refetchQueries: ["CurrentUser"], awaitRefetchQueries: true });
  };
};

export const signInMutation = () =>
  mutation<SignInMutationResult, SignInMutationVariables>(SIGN_IN_MUTATION);
