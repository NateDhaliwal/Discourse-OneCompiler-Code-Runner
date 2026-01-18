import { apiInitializer } from "discourse/lib/api";
import Component from "@glimmer/component";

export default apiInitializer((api) => {
  api.renderAfterWrapperOutlet(
    "fullscreen-codeblock-code",
    class ShowOneCompilerEmbed extends Component {}
  );
}
