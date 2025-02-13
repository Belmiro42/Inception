#! bin/sh

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

openssl req -new -x509 -key ecc_private.key -out ecc_cert.crt -days 365 -subj "/C=ES/L=MD/O=42/OU=student/CN=bmatos-d.42.ma"

sleep infinity