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

  constructor() {
    super(...arguments);
    this.runInit();
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

  runInit() {
    const iFrame = document.createElement("iframe");
    iFrame.frameBorder = "0";
    iFrame.height = "450px";
    iFrame.width = "100%";
    iFrame.src = `https://onecompiler.com/embed/${this.codeLang}?listenToEvents=true&hideLanguageSelection=true&hideNew=true`;
    iFrame.id = `oc-editor-${document.querySelectorAll("iframe[data-onecompiler]").length.toString()}`;
    iFrame.dataset.onecompiler = true;

    // iFrame.contentWindow.postMessage({
    //   eventType: "populateCode",
    //   language: `${this.codeLang}`,
    //   files: [
    //     {
    //       "name": `code.${this.file_extensions[this.codeLang]}`,
    //       "content": `${this.code}`
    //     }
    //   ]
    // }, "*");
  }

  <template>
    <p>Hello</p>
  </template>
}
