// module MDL

exports.upgradeElement = function(element) {
    return function() {
        try {
            console.log('upgradeElement: ' + element.outerHTML);
            window.setTimeout(function() { componentHandler.upgradeElement(element); }, 0);
        } catch (e) {
            console.error('Failed to upgradeElement', element, e);
        }
        return {};
    };
};

exports.trace = function (x) {
    return function (k) {
            console.log(k);
        return k({});
    };
};
