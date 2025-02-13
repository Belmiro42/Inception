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



openssl genpkey -algorithm EC -pkeyopt ec_paramgen_curve:prime256v1 -out /etc/ssl/private/ecc_private.key

#openssl ecparam -genkey -name prime256v1 -out /etc/ssl/private/ecc_private.key

#openssl ec -in /etc/ssl/private/ecc_private.key -check -noout                          # checks if the ecc key is valid

#todo why is certs hidden?
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
openssl req -new -x509 -days 365 -key /etc/ssl/private/ecc_private.key -out  /etc/ssl/certs/ecc_cert.crt  -subj "/C=ES/L=MD/O=42/OU=student/CN=bmatos-d.42.ma"




nginx -g "daemon off;"
