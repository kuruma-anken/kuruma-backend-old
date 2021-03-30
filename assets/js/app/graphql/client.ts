import { ApolloClient, InMemoryCache } from "@apollo/client/core";

const client = new ApolloClient({
  uri: "/api/graphql",
  cache: new InMemoryCache()
});

export default client;
