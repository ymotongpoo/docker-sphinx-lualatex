# Copyright 2019 Yoshi Yamaguchi
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM ubuntu:18.04 as builder
LABEL maintainer Yoshi Yamaguchi <ymotongpoo+docker@gmail.com>
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NOWARNINGS yes
ENV TEXLIVE_DEPS \
    xz-utils \
    tar \
    fontconfig
ENV TEXLIVE_PATH /opt/texlive
ENV FONT_DEPS \
    unzip \
    fontconfig
ENV FONT_PATH /usr/share/fonts/
ENV PERSISTENT_DEPS \
    wget \
    make \
    perl \
    ghostscript \
    bash \
    git
ENV PATH $TEXLIVE_PATH/bin/x86_64-linux:$PATH
ENV SOURCE_HAN_SANS_URL https://github.com/adobe-fonts/source-han-sans/raw/release/SubsetOTF/SourceHanSansJP.zip 
ENV SOURCE_HAN_SERIF_URL https://github.com/adobe-fonts/source-han-serif/raw/release/SubsetOTF/SourceHanSerifJP.zip
ENV TEXLIVE_URL http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
ENV SPHINX_DEPS \
    build-essential \
    wget \
    python3 \
    python3-dev \
    libjpeg-dev \
    zlib1g-dev \
    libfreetype6 \
    libfreetype6-dev
ENV PIP_INSTALLER_URL https://bootstrap.pypa.io/get-pip.py
ENV PYTHON_PIP_VERSION 19.0.1

# Install basic dependencies
RUN apt-get -qq update \
    && apt-get install -y --no-install-recommends -q \
         $PERSISTENT_DEPS

# Setup fonts
RUN mkdir -p $FONT_PATH && \
    apt-get install -y --no-install-recommends -q $FONT_DEPS && \
    wget --no-check-certificate $SOURCE_HAN_SANS_URL && \ 
      unzip SourceHanSansJP.zip && \
      cp SourceHanSansJP/*.otf $FONT_PATH && \
      rm -rf SourceHanSansJP.zip SourceHanSansJP && \
    wget --no-check-certificate $SOURCE_HAN_SERIF_URL && \
      unzip SourceHanSerifJP.zip && \
      cp SourceHanSerifJP/*.otf $FONT_PATH && \
      rm -rf SourceHanSerifJP.zip SourceHanSerifJP && \
    fc-cache -f -v && \
    apt-get remove -y $FONT_DEPS

# Set timezone to Tokyo
RUN apt-get install -y --no-install-recommends -q tzdata \
    && cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
    && echo 'Asia/Tokyo' > /etc/timezone

# Install TeXLive
RUN apt-get install -y --no-install-recommends -q $TEXLIVE_DEPS \
    && mkdir /tmp/install-tl-unx \
    && wget -qO- $TEXLIVE_URL | tar -xz -C /tmp/install-tl-unx --strip-components=1 \
    && printf "%s\n" \
      "TEXDIR $TEXLIVE_PATH" \
      "selected_scheme scheme-small" \
      "option_doc 0" \
      "option_src 0" \
      > /tmp/install-tl-unx/texlive.profile \
    && /tmp/install-tl-unx/install-tl -profile /tmp/install-tl-unx/texlive.profile
   
RUN tlmgr install \
      latexmk \
      collection-luatex \
      collection-langjapanese \
      collection-fontsrecommended \
      type1cm \
      mdframed \
      needspace \
      fontaxes \
      boondox \
      everyhook \
      svn-prov \
      framed \
      placeins \
      adjustbox \
      collectbox \
      fncychap \
      sourcesanspro \
      sourceserifpro \
      cm-unicode \
    && luaotfload-tool -u -vvv

# Install Python 3.6
RUN apt-get install -y --no-install-recommends $SPHINX_DEPS \
    && wget --no-check-certificate -O get-pip.py $PIP_INSTALLER_URL \
    && python3 get-pip.py --disable-pip-version-check --no-cache-dir "pip==$PYTHON_PIP_VERSION" \
    && rm -f get-pip.py \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImporant=false
COPY requirements.txt .
COPY constraints.txt .
RUN pip3 install -r requirements.txt -c constraints.txt
VOLUME ["/workdir"]
WORKDIR /workdir
CMD ["/bin/bash"]
