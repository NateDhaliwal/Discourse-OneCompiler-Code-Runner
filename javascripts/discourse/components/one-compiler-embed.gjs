import Component from "@glimmer/component";
import { tracked } from "@glimmer/tracking";
import { action } from "@ember/object";
import { concat } from "@ember/helper";
import { on } from "@ember/modifier";

export default class OneCompilerEmbed extends Component {
  file_extensions = {
    "python": "py",
    "py": "py",
    "javascript": "js",
    "js": "js",
    "cpp": "cpp",
    "java": "java",
    "cs": "cs",
    "csharp": "cs",
    "rb": "rb",
    "ruby": "rb",
    "sql": "sql"
  }

  get code() {
    return this.args.code;
  }

  get codeLanguage() {}

  @action
  onIframeLoaded() {
    const iFrame = document.getElementById('oc-editor');
    console.log(this.codeLang);
    console.log(this.code);
    iFrame.contentWindow.postMessage({
      eventType: "populateCode",
      language: `${this.codeLang}`,
      files: [
        {
          "name": `code.${this.file_extensions[this.codeLang]}`,
          "content": `${this.code}`
        }
      ]
    }, "*");
    return;
  }

  <template>
    <iframe
      frameBorder="0"
      height="450px"
      src={{(concat "https://onecompiler.com/embed/" this.codeLang "?listenToEvents=true&hideLanguageSelection=true&hideNew=true")}}
      width="100%"
      id="oc-editor"
      title="OneCompiler Code Editor"
    </iframe>
  </template>
}
