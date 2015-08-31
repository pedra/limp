/*

    Your Javascript main file

*/


window.onload = function(){

    setTimeout(
        function(){
            _('status').innerHTML = 'Javascript is ready!'
            _('status').className = 'notice'
        }, 1000);

}



function _(e){return document.getElementById(e)}

