$( document ).ready(function() {

    $('#live-chat header').on('click', function() {
        $('.chat').slideToggle(300, 'swing');
        $('.chat-message-counter').fadeToggle(300, 'swing');

    });

    $("chat-history").on('DOMSubtreeModified', "#chat-history", function() {
        alert("hello");
    });

    $('.chat-close').on('click', function(e) {

        e.preventDefault();
        $('.chat-message-counter').fadeToggle(300, 'swing');

    });

});

$( document ).ready(function() {
setInterval(updateScroll,1000);

function updateScroll(){
    var element = document.getElementById("chat-history");
    element.scrollTop = element.scrollHeight;
}
});