var AJAX,
    WS = null,
    MSG,
    USER = {
        id: null,
        name: null,
        channel: null,
        key: null
    },
    STYLE = {
        active: 0,
        source: ['admin','green']
    },
    PAGE = 2,
    CHAT,
    tmp;

window.onload = function(){

    //Iniciando LIBRARYS
    SOUND = new lib.sound();
    FILE = new lib.upload();
    FILE.set.statusElement(_('fileList'));

    //TESTE ONLY --- BEGIN
    _('help').onclick = function (e){
        if(e.target.nodeName == 'LI'){
            _('login').value = e.target.innerHTML;
            _('password').value = '1234567890';
        }
    }
    //TESTE ONLY --- END

    //Chave de segurança
    USER.key = _passw.gen(40);

    //Botão de "ENTRADA/LOGIN"
    _('go').onclick = function(){
        var login = _('login').value;
        var password = _('password').value;

        // VERIFICANDO OS DADOS INFORMADOS
        if(login.length < 5 || password.length < 5) {
            SOUND.play('error');
            return _msg(0);
        }
        if(USER.key.length < 20) return _msg(1);

        var js = JSON.stringify({login:login, password:password, asskey:USER.key})

        //convertendo...
        var vk = RSA.encrypt(js, RSA.getPublicKey(key));

        AJAX = new lib.ajax();
        AJAX.set.url(URL+'user/checkUser');
        AJAX.set.data({key:vk});
        AJAX.set.complete(function(data){
            var e = JSON.parse(AES.dec(data, USER.key));

            if(e) {
                USER.id = e.ID;
                USER.name = e.NAME;

                //novo conteúdo...
                _('container').innerHTML =
                '<h1>Admin</h1>'
                +'<div id="private" class="key">Private key ... </div>'
                +'<div id="public" class="key">Public key ... </div>'
                +'<select id="bytes">'
                +'<option value="512">512</option>'
                +'<option value="1024" selected="true">1.024</option>'
                +'<option value="2048">2.048</option>'
                +'<option value="4096">4.096</option>'
                +'<option value="8192">8.192</option>'
                +'<option value="16384">16.384</option>'
                +'</select>'
                +'<button id="keygen">Generate Keys</button>'
                +'<button id="saveKeys">Save Keys</button>';


                _('keygen').onclick = function(){
                    _('private').innerHTML = 'Generating private key - Wait ... <img src="'+URL+'img/icon/ld.gif">'
                    _('public').innerHTML = 'Generating public key - Wait... <img src="'+URL+'img/icon/ld.gif">'

                    var bytes = _('bytes').value;

                    if(bytes > 4000) {
                        _msg(11);
                        SOUND.play('error');
                    }
                    setTimeout(function(){generation(_('bytes').value)}, 400)
                }

                _('saveKeys').onclick = function(){
                    AJAX = new lib.ajax();
                    AJAX.set.url(URL+'padmin/saveKeys');
                    AJAX.set.data({enc:AES.enc(JSON.stringify({public:_('public').innerHTML, private: _('private').innerHTML}), USER.key), id:USER.id});
                    AJAX.set.complete(function(data){ console.log(data)
                        var e = JSON.parse(AES.dec(data, USER.key));console.log(e)

                        if(e && "string" == typeof e.ret && e.ret == 'ok') _msg(12);
                        else  {
                            _msg(13);
                            SOUND.play('error');
                        }
                    })
                    AJAX.send();
                }


            } else {
                _msg(2, 4000);
                SOUND.play('error')
            }
        })
        AJAX.send();
    }
}


    //enc()




    function enc(){
        var string = 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna';

        var pem = '-----BEGIN PUBLIC KEY-----MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAmDhl8g5zKd4rhHKSsBjFTzOrdGl+45K+Uv+OrW+b0RZLsoj9kpc/2PcP4jnMQ6V+2IwRBDL+VHIuJDaURSa1/aDchaPrZ+1QzSRGPKj0aQDBU3pEjiPX6FZXB/2LO9kzVECNJNVl/G1Y5gFWj3C61CNBbPTngAdtKGQcXDGiBIbmgmf2g2dbVNpmx7IluThdcGi8djYrVdcnf/dCfPVtaJbe79urM2tWurP7tX/+N7nwtd5TQ/g4Pe6Z5pP/OS9Y3wVDNcbldIplnmGAcHAX74VNkcB7KPrkrL3BqDZXj1JNIO99SIvEvDPfs0SMGhPho+M5O/MRuCsHNucZBV+XKQIDAQAB-----END PUBLIC KEY-----';
        var key = pem.replace('-----BEGIN PUBLIC KEY-----','').replace('-----END PUBLIC KEY-----','');

        console.log(key)
        console.log(forge.pki.publicKeyFromPem(pem))

        var data = forge.pki.rsa.encrypt(string, forge.pki.publicKeyFromPem(pem),true);
        var enc = forge.util.encode64(data);

        _('private').innerHTML = enc; console.log(RSA.getPublicKey(key));
        _('public').innerHTML = RSA.encrypt(string, RSA.getPublicKey(key));
    }



    function generation(b){
        var keys = forge.pki.rsa.generateKeyPair(b);
        //Print
        _('private').innerHTML = forge.pki.privateKeyToPem(keys.privateKey);
        _('public').innerHTML =  forge.pki.publicKeyToPem(keys.publicKey);


    }