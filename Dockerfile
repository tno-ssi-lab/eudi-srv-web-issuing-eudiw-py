FROM python:3.9.6
RUN mkdir /usr/src/app

RUN apt-get -y update &&  \
    apt-get -y install git
RUN python3 -m pip install --upgrade pip
WORKDIR /usr/src/app/
COPY . .

# Create folders for private DS keys and certificates
RUN mkdir -p /etc/eudiw/pid-issuer/{cert,privkey}/

# Use example test private DS key and certificate, for country Utopia (pw for private keys is b"pid-ds-0002")
COPY ./api_docs/test_tokens/DS-token/PID-DS-0002/PID-DS-0002.pid-ds-0002.key.pem /etc/eudiw/pid-issuer/privkey/
COPY ./api_docs/test_tokens/DS-token/PID-DS-0002/PID-DS-0002.cert.der /etc/eudiw/pid-issuer/cert/

RUN pip3 install -r ./app/requirements.txt

EXPOSE 5000
CMD flask --app app run --host=0.0.0.0