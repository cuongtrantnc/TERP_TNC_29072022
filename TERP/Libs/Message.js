
function showMessage(msg_type, content) {
    toastr.options.closeButton = true;
    toastr.options.debug = false;
    toastr.options.newestOnTop = false;
    toastr.options.progressBar = true;
    toastr.options.positionClass = 'toast-top-right';
    toastr.options.preventDuplicates = false;
    toastr.options.onclick = null;
    toastr.options.showDuration= '300';
    toastr.options.hideDuration = '1000';
    toastr.options.timeOut= '9000';
    toastr.options.extendedTimeOut = '1000';
    toastr.options.showEasing= 'swing';
    toastr.options.hideEasing = 'linear';
    toastr.options.showMethod= 'fadeIn';
    toastr.options.hideMethod = 'fadeOut';

    switch (msg_type) {
        case 'info':
            toastr.info(content);
            break;
        case 'warning':
            toastr.warning(content);
            break;
        case 'success':
            toastr.success(content);
            break;
        case 'error':
            toastr.error(content);
            break;
    }
};

