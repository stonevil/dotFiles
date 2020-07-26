# vim:ft=sh :

passgen() {
	openssl rand -base64 "$1"
}
