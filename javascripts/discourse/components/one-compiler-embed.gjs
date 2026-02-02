import Component from "@glimmer/component";
import { concat } from "@ember/helper";
import { action } from "@ember/object";
import DButton from "discourse/components/d-button";

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
    // this.runInit();
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

  // @action
  // onIframeLoaded() {
  //   const iFrame = document.getElementById('oc-editor');
  //   console.log(this.codeLanguage);
  //   console.log(this.code);
  //   iFrame.contentWindow.postMessage({
  //     eventType: "populateCode",
  //     language: `${this.codeLang}`,
  //     files: [
  //       {
  //         "name": `code.${this.file_extensions[this.codeLang]}`,
  //         "content": `${this.code}`
  //       }
  //     ]
  //   }, "*");
  //   return;
  // }

  // @action
  // runInit() {
  //   const iFrame = document.createElement("iframe");
  //   iFrame.frameBorder = "0";
  //   iFrame.height = "450px";
  //   iFrame.width = "100%";
  //   console.log(this.codeLanguage(iFrame));
  //   iFrame.src = `https://onecompiler.com/embed/${this.codeLanguage(iFrame)}?listenToEvents=true&hideLanguageSelection=true&hideNew=true`;
  //   iFrame.id = `oc-editor-${this.iFrameId()}`;
  //   iFrame.dataset.onecompiler = true;

  //   // iFrame.contentWindow.postMessage({
  //   //   eventType: "populateCode",
  //   //   language: `${this.codeLanguage("oc-editor-" + this.iFrameId)}`,
  //   //   files: [
  //   //     {
  //   //       "name": `code.${this.codeLanguage(iFrame)}`,
  //   //       "content": `${this.code}`
  //   //     }
  //   //   ]
  //   // }, "*");
  // }

  @action
  loadIframe() {
    const iFrame = document.getElementById(`oc-editor-${this.iFrameId}`);
    console.log(iFrame);
    if (iFrame) {
      const language = this.codeLanguage(`oc-editor-${this.iFrameId}`);
      console.log(`file.${this.file_extensions[language]`);
      iFrame.src = "https://onecompiler.com/embed/" + language + "?listenToEvents=true&hideLanguageSelection=true&hideNew=true";
      setTimeout(()=> {}, 1000);
      iFrame.style.display = "block";
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
    <p>Hello</p>
    <DButton
      class="btn btn-text btn-primary"
      @action={{this.loadIframe}}
      @label="Hi"
    />
    <iframe
      frameBorder="0"
      height="450px"
      width="100%"
      id={{(concat "oc-editor-" this.iFrameId)}}
      title="OneCompiler Code Editor"
      style="display: none;"
    ></iframe>
  </template>
}
