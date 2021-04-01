import gql from "graphql-tag";
import { query } from "svelte-apollo";

export const CURRENT_USER_QUERY = gql`
  {
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
