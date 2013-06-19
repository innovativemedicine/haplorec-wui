var jsonstream = (function(m) {
	'use strict';

    m.get = function(url, onMessage) {
        /* TODO:
         * read the response of a long-lived asynchronous http request consisting of JSON strings delimited by newlines.
         * - use XMLHTTPRequest to perform the asynchronous http request
         *   - possibly use it's on* handlers (e.g. onprogress) to 
         *   - if using the on* handlers isn't practical (e.g. they don't fire when new messages are 
         *   received, or they don't fire as frequently as we'd like), set a timer via javascript's 
         *   setInterval (see: http://friendlybit.com/js/partial-xmlhttprequest-responses/)
         * - keep track of:
         *   - start: the position of the start of the next (unread) message in XMLHTTPRequest.responseText (initially 
         *   0; on reading a message, this should change to position of newline+1)
         *   - l: the length of data that has been read so far (initially 0)
         *   - each time we poll XMLHTTPRequest.responseText for changes (regardless of how that might be triggered), do the following:
         */
        var xhr = new XMLHttpRequest();
        xhr.open("GET", url, true); 
        xhr.onprogress=readMessages;
        xhr.onloadend=readMessages;
        xhr.send();

        var l = 0; 
        var begin = 0;

        function readMessages() {
            var L = xhr.responseText.length
            while (l < L && xhr.responseText[l] != '\n'){ 
                l += 1;
            }
            if (l < L){ 
                // reponseText[l] == '\n' must be true if we're here, so there's a new message waiting
                var message = xhr.responseText.substring(begin, l);
                onMessage(JSON.parse(message));
                // read past newline delimiter 
                l += 1;
                // mark the beginning of the next message
                begin = l;
                // there might still be messages available to read
                readMessages();
            }
        }
    };

    return m;
    
})(jsonstream || {});

