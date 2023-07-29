FROM alpine:latest

RUN apk add --no-cache bash-completion curl ncurses openssl perl \
	&& apk add --no-cache direnv exa fzf jq kubectl k9s openssh-client py3-pip starship vim \
    --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing

RUN pip install awscli --no-cache-dir

RUN curl -L https://raw.githubusercontent.com/warrensbox/terraform-switcher/release/install.sh | bash

RUN curl -L https://raw.githubusercontent.com/warrensbox/tgswitch/release/install.sh | bash

CMD [ "bash" ]