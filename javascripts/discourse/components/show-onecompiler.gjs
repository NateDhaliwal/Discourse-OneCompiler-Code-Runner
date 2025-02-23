import Component from "@glimmer/component";
import { action } from "@ember/object";
import { service } from "@ember/service";
import { ajax } from "discourse/lib/ajax";
import { popupAjaxError } from "discourse/lib/ajax-error";
import DButton from "discourse/components/d-button";
import DModal from "discourse/components/d-modal";

export default class ShowOnecompiler extends Component {
  
  <template>
    <DButton
      @translatedLabel="Show Modal"
      @action={{fn (mut this.modalIsVisible) true}}
    />

    {{#if this.modalIsVisible}}
      <DModal @title="Code Compiler" @closeModal={{fn (mut this.modalIsVisible) false}}>
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
