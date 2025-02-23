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
        <iframe
         frameBorder="0"
         height="450px"  
         src="https://onecompiler.com/embed/python" 
         width="100%"
         id="oc-editor"
         title="OneCompiler Code Editor">
        </iframe>
      </DModal>
    {{/if}}
  </template>
}
