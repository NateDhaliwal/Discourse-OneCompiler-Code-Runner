import Component from "@glimmer/component";
import { tracked } from "@glimmer/tracking";
import { concat } from "@ember/helper";
import { action } from "@ember/object";
import DButton from "discourse/components/d-button";

export default class OneCompilerEmbed extends Component {
  @tracked modalShowing = false;

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

  get iFrameId() {
    return document.querySelectorAll("iframe[data-onecompiler]").length.toString();
  }

  codeLanguage(iFrame_id) {
    const codeblockContainer = document.getElementById(iFrame_id).parentElement.children[0]; // pre tag
    console.log(codeblockContainer);
    if (codeblockContainer) {
      const codeWrapper = codeblockContainer.children[1]; // code tag
      console.log(codeWrapper);
      console.log(codeWrapper.classList[2]);
      const codeLang = codeWrapper.classList[2].split("language-")[1];
      console.log(codeLang);
      return codeLang;
    }
  }

  @action
  loadIframe() {
    const iFrame = document.getElementById(`oc-editor-${this.iFrameId}`);
    if (iFrame) {
      const language = this.codeLanguage(`oc-editor-${this.iFrameId}`);
      iFrame.src = "https://onecompiler.com/embed/" + language + "?listenToEvents=true&hideLanguageSelection=true&hideNew=true";
      this.modalShowing = true;
      setTimeout(() => {
        iFrame.contentWindow.postMessage({
          eventType: "populateCode",
          language: language,
          files: [
            {
              "name": `file.${this.file_extensions[language]}`,
              "content": `${this.code}`
            }
          ]
        }, "*");
      }, 1000);
      iFrame.contentWindow.postMessage({
        eventType: "populateCode",
        language: language,
        files: [
          {
            "name": `file.${this.file_extensions[language]}`,
            "content": `${this.code}`
          }
        ]
      }, "*");
    }
  }

  

  <template>
    <DButton
      class="btn btn-text btn-primary"
      @action={{this.loadIframe}}
      @label={{(themePrefix "load_iframe_button"}}
    />
    {{#if this.modalShowing}}
      <iframe
        frameBorder="0"
        height="450px"
        width="100%"
        id={{(concat "oc-editor-" this.iFrameId)}}
        title="OneCompiler Code Editor"
      ></iframe>
    {{/if}}
  </template>
}
