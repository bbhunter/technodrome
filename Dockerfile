FROM debian:bullseye
ENV RUNNING_IN_DOCKER true
ENV tools="/root/tools"
ENV payloads="/root/payloads"
ENV go="/usr/bin/go/bin/go"
#generics
RUN apt-get update && apt-get -y install python python3-pip git unzip wget zsh curl tar chromium nodejs npm
RUN wget https://go.dev/dl/go1.20.linux-amd64.tar.gz -O /tmp/go.tar.gz && tar xf /tmp/go.tar.gz -C /tmp && mv /tmp/go /usr/bin && wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true
COPY ./configs/zsh /root/zsh
RUN mkdir $tools && mkdir $payloads
#sublist3r
WORKDIR $tools
RUN git clone https://github.com/aboul3la/Sublist3r.git
WORKDIR $tools/Sublist3r
RUN pip3 install -r requirements.txt
#amass
WORKDIR $tools
RUN wget https://github.com/OWASP/Amass/releases/download/v3.19.3/amass_linux_amd64.zip && unzip amass_linux_amd64.zip -d $tools &&  rm amass_linux_amd64.zip && mv $tools/amass_linux_amd64 $tools/amass
#massdns
WORKDIR $tools
RUN git clone https://github.com/blechschmidt/massdns.git
WORKDIR $tools/massdns
RUN make && mv $tools/massdns/bin/massdns $tools/massdns
#findomain
RUN mkdir $tools/findomain
WORKDIR $tools/findomain
RUN curl -LO https://github.com/Findomain/Findomain/releases/latest/download/findomain-linux.zip && unzip findomain-linux.zip && rm findomain-linux.zip && chmod +x ./findomain
#shuffledns
RUN mkdir $tools/shuffledns
WORKDIR $tools/shuffledns
RUN wget https://github.com/projectdiscovery/shuffledns/releases/download/v1.0.8/shuffledns_1.0.8_linux_amd64.zip &&  unzip shuffledns_1.0.8_linux_amd64.zip && rm shuffledns_1.0.8_linux_amd64.zip
#altdns
WORKDIR $tools
RUN git clone https://github.com/infosec-au/altdns.git
WORKDIR $tools/altdns
RUN pip install -r requirements.txt && python3 setup.py build && python3 setup.py install
#assetfinder
RUN mkdir $tools/assetfinder
WORKDIR $tools/assetfinder
RUN wget https://github.com/tomnomnom/assetfinder/releases/download/v0.1.1/assetfinder-linux-amd64-0.1.1.tgz && tar xf assetfinder-linux-amd64-0.1.1.tgz && rm assetfinder-linux-amd64-0.1.1.tgz
#masscan
RUN apt-get -y install libpcap0.8
WORKDIR $tools
RUN git clone https://github.com/robertdavidgraham/masscan
WORKDIR $tools/masscan
RUN make && make install
#naabu
RUN mkdir $tools/naabu
WORKDIR $tools/naabu
RUN wget https://github.com/projectdiscovery/naabu/releases/download/v2.1.0/naabu_2.1.0_linux_amd64.zip && unzip naabu_2.1.0_linux_amd64.zip
#gowitness 
RUN mkdir $tools/gowitness &&  wget https://github.com/sensepost/gowitness/releases/download/2.4.1/gowitness-2.4.1-linux-amd64 -O $tools/gowitness/gowitness && chmod +x $tools/gowitness/gowitness
#scrying
WORKDIR $tools
RUN apt-get -y install libwebkit2gtk-4.0-dev && wget https://github.com/nccgroup/scrying/releases/download/v0.9.0-alpha.2/scrying_0.9.0-alpha.2_amd64_linux.zip &&  unzip scrying_0.9.0-alpha.2_amd64_linux.zip &&  rm scrying/README.md scrying_0.9.0-alpha.2_amd64_linux.zip
#webanalyze
RUN mkdir $tools/webanalyze
WORKDIR $tools/webanalyze
RUN wget https://github.com/rverton/webanalyze/releases/download/v0.3.6/webanalyze_0.3.6_Linux_x86_64.tar.gz && tar xf webanalyze_0.3.6_Linux_x86_64.tar.gz && rm webanalyze_0.3.6_Linux_x86_64.tar.gz
#retirejs
RUN npm install -g retire
#httpx
WORKDIR $tools
RUN mkdir $tools/httpx
WORKDIR $tools/httpx
RUN wget https://github.com/projectdiscovery/httpx/releases/download/v1.2.4/httpx_1.2.4_linux_amd64.zip && unzip httpx_1.2.4_linux_amd64.zip &&  rm README.md LICENSE.md httpx_1.2.4_linux_amd64.zip
#feroxbuster
WORKDIR $tools
RUN mkdir $tools/feroxbuster
WORKDIR $tools/feroxbuster
RUN curl -sL https://raw.githubusercontent.com/epi052/feroxbuster/master/install-nix.sh | bash
#dirsearch
WORKDIR $tools
RUN git clone https://github.com/maurosoria/dirsearch.git --depth 1
WORKDIR $tools/dirsearch
RUN sed -i 's/^requests>.*/requests/' requirements.txt &&  pip install -r requirements.txt
#gospider
RUN GO111MODULE=on $go install github.com/jaeles-project/gospider@latest
#hakrawler
RUN $go install github.com/hakluke/hakrawler@latest
#linkfinder
WORKDIR $tools
RUN git clone https://github.com/GerbenJavado/LinkFinder.git
WORKDIR $tools/LinkFinder
RUN pip3 install -r requirements.txt &&  python3 setup.py install
#GoLinkFinder
RUN $go install github.com/0xsha/GoLinkFinder@latest
#gau
RUN $go install github.com/lc/gau/v2/cmd/gau@latest && mv /root/go/bin/gau /root/go/bin/getallurls
#chaos
RUN $go install -v github.com/projectdiscovery/chaos-client/cmd/chaos@latest
#linx
RUN $go install -v github.com/riza/linx/cmd/linx@latest
#getJS
RUN $go install github.com/003random/getJS@latest
#ParamPamPam
WORKDIR $tools
RUN git clone https://github.com/Bo0oM/ParamPamPam.git
WORKDIR $tools/ParamPamPam
RUN pip install -r requirements.txt
#arjun
WORKDIR $tools
RUN git clone https://github.com/s0md3v/Arjun.git
WORKDIR $tools/Arjun
RUN python3 setup.py install
#ParamSpider
WORKDIR $tools
RUN git clone https://github.com/devanshbatham/ParamSpider
WORKDIR $tools/ParamSpider
RUN pip install .
#ffuf
RUN $go install github.com/ffuf/ffuf@latest
#commix
WORKDIR $tools
RUN git clone https://github.com/commixproject/commix.git commix
#Corsy
RUN git clone https://github.com/s0md3v/Corsy.git
#crlfuzz
RUN  GO111MODULE=on $go install github.com/dwisiswant0/crlfuzz/cmd/crlfuzz@latest
#crlf-injection-scanner
RUN git clone https://github.com/MichaelStott/CRLF-Injection-Scanner.git
WORKDIR $tools/CRLF-Injection-Scanner
RUN python3 setup.py install
#injectus
WORKDIR $tools
RUN git clone https://github.com/BountyStrike/Injectus.git
WORKDIR $tools/Injectus
RUN pip3 install -r requirements.txt
#liffy
WORKDIR $tools
RUN git clone https://github.com/mzfr/liffy.git
WORKDIR $tools/liffy
RUN pip3 install -r requirements.txt
#FDsploit
WORKDIR $tools
RUN git clone https://github.com/chrispetrou/FDsploit.git
WORKDIR $tools/FDsploit
RUN pip3 install -r requirements.txt
#dotdotpwn
WORKDIR $tools
RUN git clone https://github.com/wireghoul/dotdotpwn.git
WORKDIR dotdotpwn
COPY ./scripts/dotdotpwn.sh $tools/dotdotpwn/dotdotpwn.sh
RUN chmod +x $tools/dotdotpwn/dotdotpwn.sh
#graphqlmap 
WORKDIR $tools
RUN git clone https://github.com/swisskyrepo/GraphQLmap
WORKDIR $tools/GraphQLmap
RUN python3 setup.py install
#shapeshifter
WORKDIR $tools
RUN pip3 install python-dateutil
RUN git clone https://github.com/szski/shapeshifter.git
WORKDIR $tools/shapeshifter/shapeshifter
RUN python3 setup.py install
#clairvoyance
WORKDIR $tools
RUN git clone https://github.com/nikitastupin/clairvoyance.git
COPY ./scripts/clairvoyance.sh $tools/clairvoyance/clairvoyance.sh
RUN chmod +x $tools/clairvoyance/clairvoyance.sh
WORKDIR $tools/clairvoyance
#headi
RUN $go install github.com/mlcsec/headi@latest
#Oralyzer
WORKDIR $tools
RUN git clone https://github.com/r0075h3ll/Oralyzer.git
WORKDIR $tools/Oralyzer
RUN pip3 install -r requirements.txt
#dom-red
WORKDIR $tools
RUN  git clone https://github.com/Naategh/dom-red.git
WORKDIR $tools/dom-red
RUN sed 's/^certifi.*/certifi/' -i requirements.txt  &&  sed 's/^urllib3.*/urllib3/' -i requirements.txt && pip3 install -r requirements.txt
#http-request-smuggling
WORKDIR $tools
RUN git clone https://github.com/anshumanpattnaik/http-request-smuggling.git
WORKDIR $tools/http-request-smuggling
RUN pip3 install -r requirements.txt
#smuggler
WORKDIR $tools
RUN git clone https://github.com/defparam/smuggler.git
#h2smuggler
RUN pip3 install h2
RUN git clone https://github.com/BishopFox/h2csmuggler.git
#nuclei
RUN $go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest
RUN mkdir $payloads/nuclei
WORKDIR $payloads/nuclei
RUN git clone https://github.com/projectdiscovery/nuclei-templates.git &&  wget https://raw.githubusercontent.com/tamimhasan404/Open-Source-Nuclei-Templates-Downloader/main/open-source-nuclei-templates-downloader.sh && chmod +x open-source-nuclei-templates-downloader.sh && ./open-source-nuclei-templates-downloader.sh
#metasploit
WORKDIR /tmp
RUN curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && chmod 755 msfinstall && ./msfinstall
#vhostscan
WORKDIR $tools
RUN git clone https://github.com/codingo/VHostScan.git
WORKDIR $tools/VHostScan
RUN sed 's/^numpy.*/numpy/' -i requirements.txt && sed 's/^pandas.*/pandas/' -i requirements.txt &&  pip install -r requirements.txt &&  python3 setup.py install && pip3 install Levenshtein
#brutespray
WORKDIR $tools
RUN git clone https://github.com/x90skysn3k/brutespray.git
WORKDIR $tools/brutespray
RUN pip3 install -r requirements.txt
#dnsvalidator
WORKDIR $tools
RUN git clone https://github.com/vortexau/dnsvalidator.git
WORKDIR $tools/dnsvalidator
RUN python3 setup.py install
#git-dumper
RUN pip3 install git-dumper
WORKDIR /tmp
COPY ./scripts/update-path.sh /tmp/update-path.sh
RUN chmod +x /tmp/update-path.sh && /tmp/update-path.sh
WORKDIR $tools
ENTRYPOINT [ "/bin/zsh" ]
