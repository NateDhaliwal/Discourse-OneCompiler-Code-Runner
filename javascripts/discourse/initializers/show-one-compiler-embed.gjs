import { apiInitializer } from "discourse/lib/api";
import OneCompilerEmbed from "../components/one-compiler-embed";

export default apiInitializer((api) => {
  api.renderAfterWrapperOutlet(
    "fullscreen-codeblock-code",
    <template>
      <OneCompilerEmbed @code={{@code}} />
    </template>
  );
}
