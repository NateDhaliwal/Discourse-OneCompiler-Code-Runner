import Component from "@glimmer/component";
import { action } from "@ember/object";
import { service } from "@ember/service";
import { ajax } from "discourse/lib/ajax";
import { popupAjaxError } from "discourse/lib/ajax-error";
import DButton from "discourse/components/d-button";
import DModal from "discourse/components/d-modal";
import { tracked } from '@glimmer/tracking';


export default class ShowOnecompiler extends Component {
  @tracked modalIsVisible;
  @tracked codeLang;
  @tracked code;

  get getCode() {
    const response = ajax(`/posts/${this.args.post.id}/raw`, {
        dataType: "text",
    });
    this.codeLang = String(response).split("```")[1].split(' ');
    this.code = String(response).replace("```", "").replace("```", "").replace(this.codeLang, "");
    /*
    var iFrame = document.getElementById('oc-editor'); // add an ID for the <iframe tag
    console.log(this.codeLang, this.code);
    iFrame.contentWindow.postMessage({
      eventType: 'populateCode',
      language: 'python',
      files: [
        {
          "name": "HelloWorld.py",
          "content": "your code...."
        }
      ]
    }, "*");
    */
    return this.code;
  } 
  
  @action
  showModal() {
    this.modalIsVisible = true;
    return;
  }

  @action
  hideModal() {
    this.modalIsVisible = false;
    return;
  }

  <template>
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
         src="https://onecompiler.com/embed/{{this.code}}" 
         width="100%"
         id="oc-editor"
         title="OneCompiler Code Editor"
         listenToEvents=true>
        </iframe>
      </DModal>
    {{/if}}
  </template>
}
