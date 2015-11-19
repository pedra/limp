<?php
//Gerador de certificados e chaves pública e privada.

$dir = __DIR__.'/';
$file = '';

if(!is_dir($dir)) mkdir($dir, 0777);

array_shift($argv);
foreach($argv as $a){
    if(strpos($a, '-h') !== false || strpos($a, '?') !== false) exit(help());
    if(strpos($a, '-d:') !== false) $dir = trim(substr($a, 3));
    if(strpos($a, '-f:') !== false) $file = trim(substr($a, 3));
}

if(realpath($dir) === false ) $dir = __DIR__;
$dir = rtrim($dir, ' /\\').'/';

$file = trim($file, ' /\\');
if($file == ''){
    $fncert = $dir.'certificate';
    $fnsscert = $dir.'self_signed_certificate';
    $fnprivate = $dir.'private';
    $fnpublic = $dir.'public';
} else {
    $fncert = $fnsscert = $fnprivate = $fnpublic = $dir.$file;
}

/* DEBUG
echo    "\n1 - ".$fncert.
        "\n2 - ".$fnsscert.
        "\n3 - ".$fnprivate.
        "\n4 - ".$fnpublic;
    exit();
*/


$SSLcnf = array(
            'config' => __DIR__.'/openssl.cnf',
            'encrypt_key' => true,
            'private_key_type' => OPENSSL_KEYTYPE_RSA,
            'digest_alg' => 'sha512',
            'x509_extensions' => 'v3_ca',
            'private_key_bits' => 2048
         );

// Fill in data for the distinguished name to be used in the cert
// You must change the values of these keys to match your name and
// company, or more precisely, the name and company of the person/site
// that you are generating the certificate for.
// For SSL certificates, the commonName is usually the domain name of
// that will be using the certificate, but for S/MIME certificates,
// the commonName will be the name of the individual who will use the
// certificate.

$dn = array(
    "countryName" => "BR",
    "stateOrProvinceName" => "Rio de Janeiro",
    "localityName" => "Mage",
    "organizationName" => "Qzumba - security chat relay",
    "organizationalUnitName" => "Security",
    "commonName" => "zumbi.loc",
    "emailAddress" => "admin@zumbi.loc"
);

// Generate a new private (and public) key pair
$privkey = openssl_pkey_new($SSLcnf);

// Generate a certificate signing request
$csr = openssl_csr_new($dn, $privkey, $SSLcnf);

// You will usually want to create a self-signed certificate at this
// point until your CA fulfills your request.
// This creates a self-signed cert that is valid for 365 days
$sscert = openssl_csr_sign($csr, null, $privkey, 365, $SSLcnf);

// Now you will want to preserve your private key, CSR and self-signed
// cert so that they can be installed into your web server, mail server
// or mail client (depending on the intended use of the certificate).
// This example shows how to get those things into variables, but you
// can also store them directly into files.
// Typically, you will send the CSR on to your CA who will then issue
// you with the "real" certificate.

//CERTIFICADO
openssl_csr_export_to_file($csr, $fncert.'.crt', false);

//CERTIFICADO AUTO-ASSINADO
openssl_x509_export_to_file($sscert, $fnsscert.'.cer', false);

//CHAVE PRIVADA (private.pem)
openssl_pkey_export_to_file($privkey , $fnprivate.'.pem', null, $SSLcnf);

//CHAVE PÚBLICA (public.key)
file_put_contents($fnpublic.'.key', openssl_pkey_get_details($privkey)['key']);

out:
// Show any errors that occurred here
while (($e = openssl_error_string()) !== false) {
    echo "\n".$e."\n";
}


//Help display
function help(){
    return '
  Create Openssl certificate and keys

  Usage: php open.php [options]

  -d:<path/to/dir>  Set save path - default: ./
  -f:<filename>     Set all names to "filename"
  -h            This help

  ';
}
//From DEBUG Only
function e($v){exit('<pre>'.print_r($v, true).'</pre>');}
function p($v){echo '<pre>'.print_r($v, true).'</pre>';}