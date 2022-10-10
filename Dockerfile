FROM python:3.10

ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn

RUN set -e; \
    apt-get update && apt-get -y install netcat &&  apt-get -y install gettext; \
    apt-get install -y --no-install-recommends \
        software-properties-common \
    ; \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0xB1998361219BD9C9; \
    apt-add-repository 'deb http://repos.azulsystems.com/debian stable main'; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        zulu-11 \
    ; \
    apt-get clean; \
    pip install JPype1==1.4.0 hedera-sdk-py==2.17.3 click==8.1.3 Flask==2.2.2 install==1.3.5 itsdangerous==2.1.2 ; \
        Jinja2==3.1.2 JPype1==1.4.0 MarkupSafe==2.1.1 pyjnius==1.4.2 python-dotenv==0.21.0 six==1.16.0 Werkzeug==2.2.2; \
    rm -rf /var/tmp/* /tmp/* /var/lib/apt/lists/*

ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1
ENV JAVA_HOME="/usr/lib/jvm/zulu-11-amd64"
ENTRYPOINT ["python","./server.py"]