import { apiInitializer } from "discourse/lib/api";
import ShowOnecompiler from "../components/show-onecompiler";

export default apiInitializer("1.8.0", (api) => {
  api.registerValueTransformer(
    "post-menu-buttons",
    ({
      value: dag,
      context: { lastHiddenButtonKey, secondLastHiddenButtonKey },
    }) => {
      dag.add("show-onecompiler", ShowOnecompiler, {
        before: lastHiddenButtonKey,
        after: secondLastHiddenButtonKey,
      });
    }
  );
});
