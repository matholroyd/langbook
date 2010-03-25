function _ajax_request(url, data, callback, type, async, method) {
    if (jQuery.isFunction(data)) {
        callback = data;
        data = {};
    }
    return jQuery.ajax({
        type: method,
        url: url,
        data: data,
        success: callback,
        dataType: type,
        async: async
        });
}

jQuery.extend({
    put: function(url, data, callback, type, async) {
        return _ajax_request(url, data, callback, type, async, 'PUT');
    },
    delete_: function(url, data, callback, type, async) {
        return _ajax_request(url, data, callback, type, async, 'DELETE');
    },
    putSync: function(url, data, callback, type, async) {
        return _ajax_request(url, data, callback, type, async, 'PUT');
    }
});