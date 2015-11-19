/*global cordova, module*/

module.exports = {
    /**
     * Send request to ARcode engine.
     *
     * @param {String} name       Place name
     * @param {String} category   Place category
     * @param {String} icon       Image icon url from map
     * @param {Float} latitude    Latitude
     * @param {Float} longitude   Longitude
     */
    arcodeview: function (data, successCallback) {
        if(data.length > 0){
            var sendData = {};
            if(!data.url) return;
            sendData.url = (data.url||'');
            sendData.volume = (data.volume||100);
            sendData.scale = (data.scale||true);
            var senddata = JSON.stringify(sendData);
            cordova.exec(successCallback, null, "AutoVideoPlay", "autoplay", [senddata]);
        }

    }
};
