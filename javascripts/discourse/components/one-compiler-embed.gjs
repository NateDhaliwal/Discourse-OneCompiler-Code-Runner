import Component from "@glimmer/component";
import { tracked } from "@glimmer/tracking";
import { concat } from "@ember/helper";
import { action } from "@ember/object";
import ConditionalLoadingSpinner from "discourse/components/conditional-loading-spinner";
import DButton from "discourse/components/d-button";

export default class OneCompilerEmbed extends Component {
  @tracked loading = false;

  file_extensions = {
    "java": "java",
    "python": "py",
    "python2": "py",
    "py": "py",
    "c": "c",
    "c++": "cpp",
    "cpp": "cpp",
    "nodejs": "js",
    "javascript": "js",
    "js": "js",
    "groovy": "groovy",
    "jshell": "jsh",
    "haskell": "hs",
    "tcl": "tcl",
    "lua": "lua",
    "ada": "adb",
    "commonlisp": "lsp",
    "lisp": "lisp",
    "d": "d",
    "elixir": "ex",
    "erlang": "erl",
    "f#": "fs",
    "fsharp": "fs",
    "fortran": "ftn",
    "assembly": "asm",
    "asm": "asm",
    "scala": "scala",
    "php": "php",
    "c#": "cs",
    "csharp": "cs",
    "perl": "pl",
    "ruby": "rb",
    "rb": "rb",
    "go": "go",
    "golang": "go",
    "r": "r",
    "racket": "rkt",
    "ocaml": "ml",
    "visual basic": "vb",
    "vb.net": "vb",
    "basic": "bas",
    "html": "html",
    "bash": "sh",
    "sh": "sh",
    "shell script": "sh",
    "clojure": "clj",
    "typescript": "ts",
    "cobol": "cbl",
    "kotlin": "kt",
    "pascal": "pas",
    "prolog": "pl",
    "rust": "rs",
    "swift": "swift",
    "objective-c": "m",
    "octave": "m",
    "text": "txt",
    "brainfk": "bf",
    "brainfuck": "bf",
    "coffeescript": "coffee",
    "ejs": "ejs",
    "dart": "dart",
    "deno": "ts",
    "bun": "ts",
    "crystal": "cr",
    "julia": "jl",
    "zig": "zig",
    "awk": "awk",
    "ispc": "ispc",
    "smalltalk": "st",
    "nim": "nim",
    "scheme": "scm",
    "j": "ijs",
    "v": "v",
    "raku": "raku",
    "verilog": "v",
    "haxe": "hx",
    "forth": "fs",
    "icon": "icn",
    "odin": "odin",
    "mysql": "sql",
    "oracle database": "sql",
    "postgresql": "sql",
    "mongodb": "js",
    "sqlite": "sql",
    "redis": "redis",
    "mariadb": "sql",
    "oracle pl/sql": "sql",
    "microsoft sql server": "sql",
    "cassandra": "cql",
    "questdb": "sql",
    "duckdb": "sql",
    "surrealdb": "surql",
    "firebird": "sql",
    "clickhouse": "sql"
  }

  get code() {
    return this.args.code;
  }

  get iFrameId() {
    return document.querySelectorAll("iframe[data-onecompiler]").length.toString();
  }

  codeLanguage(iFrame_id) {
    const codeblockContainer = document.getElementById(iFrame_id).parentElement.children[0]; // pre tag
    if (codeblockContainer) {
      const codeWrapper = codeblockContainer.children[1]; // code tag
      const codeLang = codeWrapper.classList[2].split("language-")[1];
      return codeLang;
    }
  }

  @action
  loadIframe() {
    const iFrame = document.getElementById(`oc-editor-${this.iFrameId}`);
    if (iFrame) {
      this.loading = true;
      const language = this.codeLanguage(`oc-editor-${this.iFrameId}`);
      iFrame.src = `https://onecompiler.com/embed/${language}?listenToEvents=true&hideLanguageSelection=${!settings.show_language_switcher}&hideNewFileOption=${!settings.show_create_new_file_button}`;
      setTimeout(() => {
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
      }, 1000);

      this.loading = false;
    }
  }

  <template>
    <DButton
      class="btn btn-text btn-primary"
      @action={{this.loadIframe}}
      @label={{(themePrefix "load_iframe_button_label")}}
      @title={{(themePrefix "load_iframe_button_label")}}
    />

    <ConditionalLoadingSpinner @condition={{this.loading}} />

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
