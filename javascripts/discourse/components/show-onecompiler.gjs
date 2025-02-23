import Component from "@glimmer/component";
import { action } from "@ember/object";
import { service } from "@ember/service";
import { ajax } from "discourse/lib/ajax";
import { popupAjaxError } from "discourse/lib/ajax-error";

export default class ShowOnecompiler extends Component {
  static hidden = true;
  /*
  @action
  async showRaw() {
    try {
      const response = await ajax(`/posts/${this.args.post.id}/raw`, {
        dataType: "text",
      });
      await this.modal.show(FullscreenCode, {
        model: {
          code: response,
        },
      });
    } catch (e) {
      popupAjaxError(e);
    }
  }
  */
  
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
