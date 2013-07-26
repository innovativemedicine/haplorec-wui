var jsonstream = (function(m) {
	'use strict';

    /* Reading a response consisting of newline separated JSON objects:
     * { target: "variant", state: "running" }
     * { target: "variant", state: "done" }
     * { target: "geneHaplotype", state: "running" }
     * ...
     * from a web page and applying a function to each line
     *
     * Using a XMLHTTPRequest to perform a asynchronous http request. 
     * readMessages() is applied with the handlers onprogress and onloadend
     * readMessages() breaks up the response into individual lines 
     * and then applies the input function onMessage to each line
     * 
     */
    m.get = function(url, onMessage, onError) {

        var xhr = new XMLHttpRequest();
        xhr.open("GET", url, true); 
        xhr.onprogress = readMessages;
        xhr.onloadend = readMessages;
        xhr.onerror = onError;
        xhr.send();
        
        var l = 0; 
        var begin = 0;

        function readMessages() {
            if (xhr.status != 200) {
                if (typeof onError !== 'undefined') {
                    onError();
                }
            }
            var L = xhr.responseText.length

            /* Finding the end of the next line
             */
            while (l < L && xhr.responseText[l] != '\n'){ 
                l += 1;
            }
            if (l < L){ 
                var message = xhr.responseText.substring(begin, l);
                onMessage(JSON.parse(message));

                /* read past newline delimiter 
                 */
                l += 1;

                /* mark the beginning of the next message
                 */ 
                begin = l;
                
                /* there might still be messages available to read
                 */
                readMessages();
            }
        }
    };

    return m;
    
})(jsonstream || {});

