$(document).on('turbolinks:load', function () {
    $(".nav-trigger").click(function () {
        $(this).next().slideToggle();
    }).next().hide();
});