#! bin/sh

#┌─┐
#│ │
#├─┤
#│ │	
#└─┘

#┌─────────────────────────────────────────────────────────────────────────┐
#│               GENERATING AND STORING THE CERTIFICATE                    │	
#├─────────────────────────────────────────────────────────────────────────┤
#│ RSA keys are what everyone uses so to understand what I'm doing and     │
#│ avoid copy and pasting im using an ECC key.                             │
#└─────────────────────────────────────────────────────────────────────────┘


#┌────────┐
#│ KEYGEN │	
#└────────┘
#Genkey 
# Generates a private key or key pair.

#-algorithm alg
# Specify the algorithm to use. EC = Elliptic Curve Cryptography

#-pkeyopt
# Select an algorithm option. In this case which curve to use in this case
# y^2 ≡ x^3+ax+b

#-out 
# Output the key to ...

openssl genpkey -algorithm EC -pkeyopt ec_paramgen_curve:prime256v1 -out /etc/ssl/private/ecc_private.key
#┌──────────┐
#│ KEYCHECK │	
#└──────────┘
#ec 
# Process and EC key

#-in arg
# read from this arg

#-check
# check the validity of the key

#-noout
# do not print the key

#openssl ec -in /etc/ssl/private/ecc_private.key -check -noout

#┌──────────────────────┐
#│ CERTIFICATE CREATION │	
#└──────────────────────┘
#req 
# This command primarily creates and processes certificate requests (CSRs) 
# in PKCS#10 format. It can additionally create self-signed certificates 
# for use as root CAs for example.

#-new
# This option generates a new certificate request. It will prompt the user 
# for the relevant field values. The actual fields prompted for and their 
# maximum and minimum sizes are specified in the configuration file and any 
# requested extensions.

#-x509
# This option outputs a certificate instead of a certificate request. This
# is typically used to generate test certificates. It is implied by the -CA 
# option. This option implies the -new flag if -in is not given.


# -key filename|uri
# This option provides the private key for signing a new certificate or 
# certificate request. Unless -in is given, the corresponding public key is 
# placed in the new certificate or certificate request, resulting in a 
# self-signature.


#-out filename
# This specifies the output filename to write to or standard output by default.

#-days duration
# How long the request lasts
#todo why is certs hidden?
openssl req -new -x509 -days 365 -key /etc/ssl/private/ecc_private.key -out  /etc/ssl/certs/ecc_cert.crt  -subj "/C=ES/L=MD/O=42/OU=CEO/CN=bmatos-d.42.ma"

#┌─────────────────────────────────────────────────────────────────────────┐
#│                         NGINX CONFIGURATION                             │
#├─────────────────────────────────────────────────────────────────────────┤
#│ Here we configure nginx.                                                │	
#│ https://nginx.org/en/docs/beginners_guide.html                          │	
#│ nginx consists of modules which are controlled by directives specified  │
#│ in the configuration file. Directives are divided into simple directives│ 
#│ and block directives. A simple directive consists of the name and       │
#│ parameters separated by spaces and ends with a semicolon (;). A block   │
#│ directive has the same structure as a simple directive, but instead of  │
#│ the semicolon it ends with a set of additional instructions surrounded  │
#│ by braces ({ and }). If a block directive can have other directives     │
#│ inside braces, it is called a context (examples: events, http, server,  │
#│ and location).                                                          │         
#│                                                                         │	
#└─────────────────────────────────────────────────────────────────────────┘

#┌────────────┐
#│ DAEMON OFF │	
#└────────────┘
# This turns off the daemon option for nginx which makes nginx run in the 
# background. Running in the background will mean we end this script after 
# the nginx command and the container will stop.

echo "daemon off;"                                                                  > /etc/nginx/nginx.conf

#┌─────────────┐
#│ EVENT BLOCK │	
#└─────────────┘
echo "
events
{
    worker_connections 1024;
}

"                             >> /etc/nginx/nginx.conf

#┌──────────┐
#│ SSL CONF │	
#└──────────┘

echo "
http     
{ 
        server
        {
            listen                  443 ssl;
            listen                  [::]:443 ssl;
            server_name             www.bmatos-d.42.ma bmatos-d.42.ma;
            ssl_certificate         /etc/ssl/certs/ecc_cert.crt;
            ssl_certificate_key     /etc/ssl/private/ecc_private.key;
            ssl_protocols           TLSv1.3;
            root                    /var/www/html;
            index                   index.php;
            location ~ \.php$
            {
                try_files                       \$uri =404;
                include                         fastcgi_params;
            }
        }

}

"                             >> /etc/nginx/nginx.conf
cat /etc/hosts

echo "
127.0.0.1 www.bmatos-d.42.ma bmatos-d.42.ma" >> /etc/hosts
                #fastcgi_pass                    wordpress:9000;
                #fastcgi_param SCRIPT_FILENAME   $document_root$fastcgi_script_name;

#┌──────────┐
#│ SSL CONF │	
#└──────────┘


nginx
