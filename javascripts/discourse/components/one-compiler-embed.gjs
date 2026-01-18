import Component from "@glimmer/component";
import { action } from "@ember/object";
import DButton from "discourse/components/d-button";
import DModal from "discourse/components/d-modal";
import { tracked } from '@glimmer/tracking';
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

  @tracked modalIsVisible;
  @tracked codeLang;
  @tracked code;
  @tracked modalShouldShow = (this.args.post.cooked).includes("lang-");

  get code() {
    return this.args.code;
  }

  @action
  hideModal() {
    this.modalIsVisible = false;
    return;
  }

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
    {{#if this.modalShouldShow}}
      <DButton
        @translatedLabel="Show Modal"
        @action={{this.showModal}}
      />
      {{#if this.modalIsVisible}}
        <DModal @title="Code Compiler" @closeModal={{this.hideModal}}>
          {{this.getCode}}
          <iframe
            frameBorder="0"
            height="450px"
            src="https://onecompiler.com/embed/{{this.codeLang}}?listenToEvents=true&hideLanguageSelection=true&hideNew=true"
            width="100%"
            id="oc-editor"
            title="OneCompiler Code Editor"
            {{on "load" this.onIframeLoaded}}>
          </iframe>
        </DModal>
      {{/if}}
    {{/if}}
  </template>
}
