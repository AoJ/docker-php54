# Create the CA Key and Certificate for signing Client Certs
openssl genrsa -out ca.key 4096 > /dev/null 2>&1
openssl req -new -x509 -days 3650 -key ca.key -out ca.crt -subj "/C=MA/ST=MARS/L=MARS/O=IT/CN=*" > /dev/null 2>&1


# Create the Server Key, CSR, and Certificate
openssl genrsa -out server.key 2048 > /dev/null 2>&1
openssl req -new -key server.key -out server.csr  -subj "/C=SE/ST=SERVER/L=SERVER/O=IT/CN=*" > /dev/null 2>&1

# We're self signing our own server cert here.  This is a no-no in production.
openssl x509 -req -days 3650 -in server.csr -CA ca.crt -CAkey ca.key -set_serial 01 -out server.crt > /dev/null 2>&1

# Create the Client Key and CSR
openssl genrsa -out client.key 2048 > /dev/null 2>&1
openssl req -new -key client.key -out client.csr  -subj "/C=CL/ST=CLIENT/L=CLIENT/O=IT/CN=*" > /dev/null 2>&1

# Sign the client certificate with our CA cert.  Unlike signing our own server cert, this is what we want to do.
openssl x509 -req -days 3650 -in client.csr -CA ca.crt -CAkey ca.key -set_serial 01 -out client.crt > /dev/null 2>&1


mkdir -p /etc/nginx/certs
cp server.crt /etc/nginx/certs/server.crt
cp server.key /etc/nginx/certs/server.key
cp ca.crt /etc/nginx/certs/ca.crt
cp ca.crt /var/www/ca.crt

echo "====>>> CA CERT <<<====="
echo ""
cat ca.crt

echo ""
echo ""

rm client.* server.* ca.*
