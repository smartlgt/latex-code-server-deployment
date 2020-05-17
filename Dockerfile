FROM linuxserver/code-server:3.2.0-ls40
#FROM codercom/code-server:3.2.0

USER root

RUN apt update && apt -y install texlive-latex-base nodejs npm

RUN mkdir /config/extensions/  && cd /config/extensions && git clone https://github.com/smartlgt/LaTeX-Workshop.git \
&& cd ./LaTeX-Workshop \
&& npm install --no-optional

# build the missing out folder form the extension
RUN cd /config/extensions/LaTeX-Workshop && npm run compile

# optional, speedup server start, by setting the owner to abc
RUN mkdir -p /config/{extensions,data,workspace,.ssh}
RUN sed -i 's/chown -R abc:abc \\//g' /etc/cont-init.d/30-config
RUN sed -i 's/        \/config//g' /etc/cont-init.d/30-config
RUN chown -R abc:abc /config
