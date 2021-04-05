import { query } from "svelte-apollo";
import gql from "graphql-tag";
import { SelectOption } from "../interfaces/common";

export const LIST_CAR_MAKERS_FOR_SELECT = gql`
  query ListCarMakersForSelect {
    listCarMakers {
      label: name
      value: id
    }
  }
`;

export interface ListCarMakersForSelectResult {
  listCarMakers: SelectOption[];
}

export const useListCarMakersForSelect = () =>
  query<ListCarMakersForSelectResult>(LIST_CAR_MAKERS_FOR_SELECT);
