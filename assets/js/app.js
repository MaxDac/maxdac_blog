// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.css"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//

import "phoenix_html";
import Quill from "quill";

window.Editor = (function() {
    const initialize = function(editorId, hiddenId, initialText, options) {
        const container = document.getElementById(editorId);
        const hiddenField = document.getElementById(hiddenId);

        const editorOptions = options === undefined ?
            {
                modules: {
                toolbar: [
                    [{ header: [1, 2, false] }],
                    ['bold', 'italic', 'underline'],
                    ['image', 'code-block'],
                    [{ 'align': [] }],
                ]
                },
                placeholder: 'Compose an epic...',
                theme: 'snow'  // or 'bubble'
            } :
            options;
    
        let editor = undefined;
        
        if (container !== undefined) {
            editor = new Quill(container, editorOptions);

            editor.root.innerHTML = initialText;
        
            editor.on('text-change', function(eventName, ...args) {
                hiddenField.value = editor.root.innerHTML;
            });
        }

        return editor;
    }

    const getValue = function() { return editor.root.innerHTML; }
    
    return {
        initialize: initialize,
        getValue: getValue
    }
});

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"
