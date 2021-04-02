import { useLocation } from "svelte-navigator";
import { derived } from "svelte/store";

export default function <T = Record<string, string>>() {
  const location = useLocation();
  return derived(location, ($location) => {
    const params = new URLSearchParams($location.search);
    return Object.fromEntries(params as any) as T;
  });
}
